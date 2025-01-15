library(qqman)
library(data.table)

file_list <- vector(mode="list", length=22)
for(i in 1:22){
	file_list[[i]]<-read.delim(paste('both-pa-',as.character(i),'.out',sep=''),sep='',row.names=NULL)
}
summary(file_list)
x <- rbindlist(file_list)
significant_snps <- x[as.numeric(x$robust_P_Value_Interaction)<0.0000005,]
write.csv(significant_snps,file='final_pa.csv')
x$CHR <- as.numeric(x$CHR)
x$BP <- as.numeric(x$BP)
x$P <- as.numeric(x$P)

#y <- x[!is.na(x$CHR),]
#summary(y)
#write.csv(y,file='manhattan_pa_both.csv')
options(bitmapType='cairo')
png(file="manhattan_pa_both_final.png")
manhattan(y,suggestiveline=-log10(5e-6))
dev.off()
