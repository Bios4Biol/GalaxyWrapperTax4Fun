# Galaxy Wrapper Tax4Fun

Predicts the functional or metabolic capabilities of microbial communities based on 16S data samples and Function Table for Tax4Fun matrix 
This Galaxy wrapper allow to use BIOM output file from Frogs to run Tax4Fun metabolic and functional prediction.
This Tax4Fun pipeline can be run after Frogs pipeline. Output BIOM file is Tax4Fun input file.


![alt text](https://raw.githubusercontent.com/Bios4Biol/GalaxyWrapperTax4Fun/master/pipeline_tax4fun.png)


A- First, we convert BIOM output file from Frogs in en standard BIOM file thanks to this Galaxy tool : «FROGS BIOM to std BIOM
  Converts a FROGS BIOM in fully compatible BIOM. (Galaxy Version 1.1.0)»
  
B- Then, we convert this standard BIOM in a TSV file with this Galaxy tool : «FROGS BIOM to TSV Converts a BIOM file in TSV file. (Galaxy Version 2.1.0)»

C- Only two columns have to be kept in Tax4Fun input file : total abundance and taxonomy. To recover these informations, we run this Galaxy tool : «Cut columns from a table (Galaxy Version 1.0.2) » in order to generate two files : one with taxonomy column and another one with abondance_sum column. Then Galaxy tool « Paste two   files   side   by   side   (Galaxy   Version   1.0.0) »   allow us to generate an unic file with a left colmun containing total abundance data and, a right column with toxonomy. Be careful, the order of the columns is important.
  
![alt text](https://raw.githubusercontent.com/Bios4Biol/GalaxyWrapperTax4Fun/master/tax4fun_input_file.png)

E- The new Galaxy tool entitled « Tax4Fun predicts   the   functional   or   metabolic   capabilities   of   microbial communities   based   on   16S   data   samples   (Galaxy   Version   1.0.0) »  take as input file the previous one (step C), sort data, reformate taxonomy, and add abundancescorresponding to the same taxonomic informations.

It is important to note that the only available reference is SILVA123.


# How to install Tax4Fun wrapper ?

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
