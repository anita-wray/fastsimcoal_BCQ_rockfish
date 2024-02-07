# bootstrap
setwd("/Users/anita.wray/miniconda3/envs/easysfs_env/easySFS")
boots <- 100
blocks <- paste("CBQ_boot.sites0",c("00","01","02","03","04","05","06","07","08","09",as.character(10:99)),sep="")
head <- readLines("header")
for(i in 1:boots){
  print(i)
  out <- NULL
  for(j in 1:100){
    thisInName <- sample(blocks,1)
    thisInFile <- read.table(thisInName,header=FALSE,sep=" ")
    out <- rbind(out,thisInFile)
  }
  subDir <- paste("bs",i,sep="") 
  mainDir <- "/Users/anita.wray/miniconda3/envs/easysfs_env/easySFS"
  if (file.exists(subDir)){
    setwd(file.path(mainDir, subDir))
  } else {
    dir.create(file.path(mainDir, subDir))
    setwd(file.path(mainDir, subDir))
  }
  write.table(out,file=paste("CQB_boot.bs.",i,".vcf",sep=""),quote=FALSE,row.names=FALSE,col.names=FALSE)
  out2 <- readLines(paste("CQB_boot.bs.",i,".vcf",sep=""))
  out3 <- c(head[1:88],out2)
  write.table(out3,file=paste("CQB_boot.bs.",i,".vcf",sep=""),quote=FALSE,row.names=FALSE,col.names=FALSE)
  setwd("/Users/anita.wray/miniconda3/envs/easysfs_env/easySFS")
}