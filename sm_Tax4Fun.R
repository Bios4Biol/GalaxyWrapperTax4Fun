# The function -------------------------------------
#---------------------------------------------------
GalaxyFrogsTax <- function(input.file,
                      reference,
                      output.file = "Tax4FunProfile.txt"
                      ) {
library(Tax4Fun)
folderReferenceData<- reference  

Tax4FunOutput<-Tax4Fun(importSilvaNgsData(input.file), folderReferenceData) # optionnal: fctProfiling = TRUE, refProfile = "UProc", shortReadMode = TRUE, normCopyNo = TRUE)
#folderReferenceData (required): a character vector with one character string indicating the folder location of the unzipped reference data. The reference data can be  obtained  from  the  Tax4Fun  website  http://tax4fun.gobics.de/  ("SILVA  Reference data").
#reference = "/galaxydata/galaxy-preprod/my_tools/sm_Tax4Fun/SILVA123/"

Tax4FunProfile <- Tax4FunOutput$Tax4FunProfile
Tax4FunProfile <- data.frame(t(Tax4FunOutput$Tax4FunProfile))
#View(Tax4FunProfile)

write.table(Tax4FunProfile, "Tax4FunProfile.txt", sep="\t")

} #fin de la fonction
