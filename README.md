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
