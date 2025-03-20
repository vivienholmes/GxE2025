args<-commandArgs(TRUE)
pheno<-args[1]

library(qqman)
library(data.table)

file_list <- vector(mode="list", length=22)
for(i in 1:22){
	file_list[[i]]<-read.delim(paste('manhattan-',tolower(pheno),'-gs-',as.character(i),'.out',sep=''),sep='',row.names=NULL)
}
summary(file_list)
x <- rbindlist(file_list)

x$CHR <- as.numeric(x$CHR)
x$BP <- as.numeric(x$BP)
x$P <- as.numeric(x$P)

y <- x[!is.na(x$CHR),]
summary(y)
significant_snps <- y[y$P<0.00000005,]
write.csv(significant_snps,file=paste('snps_',pheno,'.csv',sep=''))
write.csv(y,file=paste('new_manhattan_',pheno,'_both.csv',sep=''))
options(bitmapType='cairo')
png(file=paste('fresh_manhattan_', pheno, '_gs.png',sep=''))
manhattan(y,suggestiveline=-log10(5e-6))
dev.off()
