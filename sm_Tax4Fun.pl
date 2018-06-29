#Declaration de l espace de travail et du chemin de l executable R :
use strict;
use Carp;
use Statistics::R;
use Cwd qw(abs_path);
use File::Basename;
use Getopt::Long;


#Variables Globales ###########################
defined $ENV{'MY_GALAXY_DIR'} || die "MY_GALAXY_DIR environment variable not defined";
use lib "$ENV{'MY_GALAXY_DIR'}";
use GalaxyPath;

my ($r_bin,$log_dir,$R,$cmd,$line, $out, $input, $reference);


#test:
#perl sm_Tax4Fun.pl --input DATA/testtax4fun---ssu---fingerprint----Total---sim_93---tax_silva---td_20.csv --out DATA/Tax4FunProfile.txt


#Parametres d'entree
Getopt::Long::Configure( 'no_ignorecase', 'bundling' );
GetOptions (
    'out=s' => \$out,
    'input=s' => \$input,
    'reference=s' => \$reference
) or die "Usage: Error in command line arguments\n";

# SETTING GLOBAL VARIABLES ####################################################
my $cfg = GalaxyPath->new( -file => $ENV{"GALAXY_CONFIG_FILE"} );
my $file_path = $cfg->my_path( 'workPath', 'MYWORKSPACE' );
$r_bin = $cfg->my_path( 'toolsPath', 'R_BIN_PATH' );
my $SCRIPTS_R_path = $cfg->my_path( 'toolsPath', 'SCRIPTS_R_path' );
###############################################################################

#workspace
my $debug = 0; #Mode debug (0)
if ($debug == 0)
	{
	print STDOUT "Debug mode OK \n";
	}
else	
	{
	$file_path = dirname($out); 
	print STDOUT "No debug \n";
	}



my ($nb) = ($out=~/dataset_(\d+)\.\S+$/);
#For debugging in command line on vm-galaxy-preprod 
#my ($nb) = (1);
#creation du repertoire de sortie
`cd $file_path; mkdir $nb; chmod -R 777 $nb `;
my $dirresults= $file_path."/".$nb;


print STDOUT "Job working directory : $dirresults \n";



#remplacer les [a-z]__ du fichier entrant $input par rien
#$str =~ s/$find/$replace/g;
`cp -a $input $dirresults/INPUT.csv`;
open(FILE, "<$dirresults/INPUT.csv") || die "File not found";
my @lines = <FILE>;
close(FILE);

my @newlines;
my %Taxo=();
foreach(@lines) {
   $_ =~ s/[a-z]\_\_//g;   #homogeneiser la taxonomie issues de frogs avec celle utilisée par tax4fun
   $_ =~ s/\n/;\n/g;       #pour qu'il y ait un point virgule a la fin de chaque ligne
   $_ =~ s/;;/;/g;         #remplacer les ;; par un seul ;
   $_ =~ s/;;/;/g;         #remplacer les ;; par un seul ; une seconde fois pour les triples points virgules
   #push(@newlines,$_);
   /^(\d+)\t(.+)/||die "bad line: $_";
   $Taxo{$2}+=$1;
}

open(FILE, ">$dirresults/INPUT.csv") || die "File not found";
#print FILE "abondance_sum\tTaxonomy\n";
print FILE "abondance_sum;\n";
#print FILE @newlines;
foreach my $taxo (sort {$a cmp $b} keys %Taxo) {
    printf FILE "%d\t%s\n",$Taxo{$taxo},$taxo;
}
close(FILE);


#Log dir
$log_dir = $dirresults;

#déaration de l'objet $R et ouverture du pont :
$R = Statistics::R->new(
    "r_bin"   => $r_bin,
    "log_dir" => $log_dir,
) or die "Problem with R : $!\n";
# Ouverture du pont
$R->startR;


print STDOUT "Ouverture du pont R \n";

#Read R script
$cmd="";
#[galaxy-preprod@vm-galaxy-preprod sm_Tax4Fun]$ ln -s /galaxydata/galaxy-preprod/my_tools/sm_Tax4Fun/sm_Tax4Fun.R /galaxydata/galaxy-preprod/my_bin/scripts_R/.
open IN,"< $SCRIPTS_R_path/sm_Tax4Fun.R"
	or die "Unable to read R script : $!\n";
while ($line=<IN>) {
	$cmd.=$line;
}
close(IN);

#Declare R function
print STDOUT "Declaration du script R \n";
   
#$dirresults/INPUT.csv  #"input.file = '$input', ".
$R->send(
     "setwd('$dirresults')\n".
     "$cmd\n".
     "GalaxyFrogsTax( ".
     "input.file = '$dirresults/INPUT.csv', ".   
     "reference = '$reference', ".
     "output.file = '$out')\n");

print STDOUT "Envoi du script R ";




#Fermeture du pont
$R->stopR();

print STDOUT "Fermeture du pont R \n";

#Recuperation des outputs dans Galaxy
my $cmdOUT ='';
my $outTax= "$dirresults/Tax4FunProfile.txt";
if (! -e $out){print STDERR "Pas de fichier Tax4FunProfile.txt produit \n";}
else {$cmdOUT = "(mv $outTax $out) >& ./cp_taxout.log 2>&1";
system $cmdOUT;}
