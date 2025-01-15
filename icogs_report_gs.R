args<-commandArgs(TRUE)
chr<-args[1]

data <- read.delim(paste('~/scratch/Predoctoral_fellowship_gene_environment/PRACTICAL_analysis/prs_environment_analysis/GEM/cca/12-3/icogs_pa_bmi_gs_GEM_output-',as.character(chr),'.out',sep=''))
manhattan <- data.frame(SNP=data$RSID, CHR=data$CHR,BP=data$POS,P=data$robust_P_Value_Interaction)
summary(data)
#manhattan['Beta']<-data['Beta_G-BMI']
write.table(manhattan,file=paste("man-icogs-gs-",as.character(chr),".out",sep=''),append=TRUE)

