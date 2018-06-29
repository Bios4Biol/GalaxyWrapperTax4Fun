# GalaxyWrapperTax4Fun
Predicts the functional or metabolic capabilities of microbial communities based on 16S data samples and Function Table for Tax4Fun matrix 

Ce wrapper Galaxy permet de passer du BIOM issu de FROGS à la prédiction métabolique et fonctionnelle Tax4Fun

Ce pipeline Tax4Fun peut être lançé à la suite du pipeline FROGS. Le BIOM sortant sera le fichier d'entrée de ce pipeline Tax4Fun.

A- Dans un permier temps, nous convertissons le BIOM issu de FROGS en BIOM standard à l'aide de l'outil «FROGS BIOM to std BIOM
  Converts a FROGS BIOM in fully compatible BIOM. (Galaxy Version 1.1.0)»
  
B- Nous convertissons ensuite le BIOM standard obtenu en fichier TSV à l'aide de l'outil «FROGS BIOM to TSV Converts a BIOM file in TSV file. (Galaxy Version 2.1.0)»

C-  Seules deux colonnes sont à donner en entrée de Tax4Fun : l'abondance totale et la taxonomie. Pour récupérer ces informations, nous utilisons l'outil «Cut columns from a table (Galaxy Version 1.0.2) » afin de générer deux fichiers : un fichier avec la colonne Taxonomie, et un autre avec la colonne   abondance_sum.   L'outil   « Paste two   files   side   by   side   (Galaxy   Version   1.0.0) »   nous permet ensuite de générer un seul fichier avec, colonne de gauche, l'abondance totale, et, colonne de droite, la taxonomie.
  
E- Le   nouvel   outil   « Tax4Fun predicts   the   functional   or   metabolic   capabilities   of   microbial communities   based   on   16S   data   samples   (Galaxy   Version   1.0.0) »   prends   en   entrée   le   fichier précédent, trie les  données, reformate la taxonomie, et somme  les abondances  pour les  mêmes informations   taxonomiques. 
Il   est   important   de   souligner   que   la   référence   disponible   est SILVA123.


# How ton install Tax4Fun wrapper ?

1 - Add Tax4Fun files (xml, perl and R) in tools directory 
<pre>
Create a sm_Tax4Fun/ directory in tools/
Get Tax4Fun files in this new directory
</pre>

2 - Add Tax4Fun wrapper in your Tool Menu
<pre>
Add TAX4FUN wrapper in your tool_conf.xml file :
geany ../../my_config/my_tool_conf.xml &
in your FROGS section:
<tool file="my_tools/sm_Tax4Fun/sm_Tax4Fun.xml" />
</pre>

3 - Create a symbolique link for the R script
<pre>
ln -s /path/to/tools/sm_Tax4Fun/sm_Tax4Fun.R /path/to/bin/scripts_R/.
</pre>

and add the path in your galaxy.ini file :
<pre>
[workPath]
SCRIPTS_R_path=/galaxydata/galaxy-preprod/my_bin/scripts_R/
</pre> 
 
4 - Specify pah to SILVA123 in sm_Tax4Fun.xml file, in the label names "Folder location of the unzipped reference data"
<pre>
    option value="/Path/to/sm_Tax4Fun/SILVA123/"
</pre>


# References

K.P. Aßhauer, B. Wemheuer, R. Daniel, P. Meinicke (2015)
Tax4Fun: predicting functional profiles from metagenomic 16S rRNA data
Bioinformatics (2015) 31 (17): 2882-2884. doi:10.1093/bioinformatics/btv287. 

# Galaxy wrapper

Contacts : support.sigenae@inra.fr

E-learning available : http://genoweb.toulouse.inra.fr/~formation/GALAXY_news/howto3_Tax4Fun.pdf
