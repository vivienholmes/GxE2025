args<-commandArgs(TRUE)
chr<-args[1]

data <- read.delim(paste('~/scratch/gxe/freshgraphs/GEM_pa-',as.character(chr),'.out',sep=''))
manhattan <- data.frame(SNP=data$RSID, CHR=data$CHR,BP=data$POS,P=data$robust_P_Value_Interaction)


write.table(manhattan,file=paste("manhattan-pa-caco-",as.character(chr),".out",sep=''),append=TRUE)
write.table(data,file=paste("full-manhattan-pa-caco-",as.character(chr),".out",sep=''),append=TRUE)

