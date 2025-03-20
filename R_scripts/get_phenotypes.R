pheno_data <- read.delim("/mnt/mhs01-home01/KMuir/y78216vh/PRACTICAL_Data/App362_Muir_phenos_and_Readmes/DataDistribution/Phenotype_data/App_362_Onco_phenotypes_Sep2021_v7.txt", stringsAsFactors=TRUE)
pheno_data[pheno_data == "" | pheno_data == "U"] <- NA
pheno_data <- droplevels(pheno_data)
 
samples <- read.delim("/mnt/mhs01-home01/KMuir/y78216vh/PRACTICAL_Data/OncoArray/Imputation/onco_sample_euro_bycountry_imp_7pcs.txt")[-1,]
merged_data <- merge(samples, pheno_data, by.x = "ID_1", by.y="Onc_ID")

md <- merged_data[,!sapply(merged_data, function(x) all(is.na(x) | x ==""))] # Remove empty columns
md[] <- lapply(md, gsub, pattern=',', replacement='') #remove all commas (to avoid csv trouble)
md <- subset(md, select=-c(Gender, Missing)) # Remove duplicated & irrelevant columns
md <- md[,-grep("Date$",colnames(md))] # Remove columns with dates
md$strata_country_study <- as.factor(md$strata_country_study) #tidying up
md$aff <- as.factor(md$aff) #tidying up
md$PRACTICAL_ANID <- as.character(md$PRACTICAL_ANID)

#md <- md[is.na(md$iCOGS_ID),] #remove iCOGS participants
#md[md$CaCo==0,]$GleasonScore <- 0 #fix Gleason Score

#Add Aggression
md$Aggression <- with(md, ifelse(CauseDeath == 1 | GleasonScore %in% c(8,9,10) | as.character(TStage) %in% c('T3', 'T4') | as.character(NStage) == 'N1' | as.character(MStage) == 'M1' | as.character(SEERStaging) %in% c('Regional', 'Distant'), TRUE, FALSE))
summary(md$Aggression)
md$Aggressive <- with(md, ifelse(Aggression %in% c(NA, FALSE),FALSE,TRUE))
summary(md$Aggressive)
md <- md[!is.na(md$strata_country_study),]
md <- md[!md$strata_country_study %in% c('Germany', 'Malaysia', 'Norway', 'Multi Center'),]
md <- droplevels(md)



cca.p <- md[!is.na(md$P_Activity),]
cases.p <- cca.p[cca.p$CaCo==1,]
write.csv(cca.p, file="pa.pheno",row.names=FALSE,quote=FALSE)
write.csv(cases.p, file="cases_pa.pheno",row.names=FALSE,quote=FALSE)
write.csv(subset(cca.p,select=c(ID_1,ID_2)), file="pa_id.csv",row.names=FALSE,quote=FALSE, col.names=FALSE,sep=' ')
write.csv(subset(cases.p,select=c(ID_1,ID_2)), file="cases_pa_id.csv",row.names=FALSE,quote=FALSE, col.names=FALSE,sep=' ')

cca.b <- md[!is.na(md$BMI),]
cases.b <- cca.b[cca.b$CaCo==1,]
write.csv(cca.b, file="bmi.pheno",row.names=FALSE,quote=FALSE)
write.csv(cases.b, file="cases_bmi.pheno",row.names=FALSE,quote=FALSE)
write.csv(subset(cca.b,select=c(ID_1,ID_2)), file="bmi_id.csv",row.names=FALSE,quote=FALSE, col.names=FALSE,sep=' ')
write.csv(subset(cases.b,select=c(ID_1,ID_2)), file="cases_bmi_id.csv",row.names=FALSE,quote=FALSE, col.names=FALSE,sep=' ')
