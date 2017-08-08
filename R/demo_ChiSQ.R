#Chi square test
#June 10, 2015

library("MASS")
setwd("//150.135.42.6/Ravi-Lab/Xunliang/Paper/Data")

Transmission_t <- read.csv("PT-TM_TransgeneTM.csv",header = TRUE)
Transmission <- Transmission_t[,-1]
rownames(Transmission) <- Transmission_t[,1]
Transmission <- Transmission[,1:2]
Transmission
#nrow(Transmission)
#chisq.test(Transmission[1,])
Test <- Transmission[1:2,]
chisq.test(Test)
Test <- Transmission[2:3,]
chisq.test(Test)
print("=============")
Test <- Transmission[4:5,]
chisq.test(Test)
Test <- Transmission[5:6,]
chisq.test(Test)
print("=============")
Test <- Transmission[7:8,]
Chi <- chisq.test(Test)
print(Chi$observed)
print(Chi$expected)
print(Chi$statistic)
print(Chi$p.value)
print(Chi$parameter)
print(Chi$method)
Test <- Transmission[8:9,]
Chi <- chisq.test(Test)
print(Chi$observed)
print(Chi$expected)
print(Chi$statistic)
print(Chi$p.value)
print(Chi$parameter)
print(Chi$method)
chisq.test(Test)
print("=============")
Test <- Transmission[10:11,]
chisq.test(Test)
Test <- Transmission[11:12,]
chisq.test(Test)
print("=============")
Test <- Transmission[13:14,]
chisq.test(Test)
Test <- Transmission[14:15,]
chisq.test(Test)
print("=============")

for (i in 1:nrow(Transmission)) {
  chi <- chisq.test(Transmission[i,])
  print("##################################")
#  print(Transmission[i,])
  print(chi$observed)
  print(chi$expected)
  print("Pvaleu = ", chi$p.value)
  print(chi$statistic)
# print(chi$parameter)
# print(chi$method)
}

##
#M <- as.table(rbind(c(762, 327, 468), c(484, 239, 477),c()))
#M
#dimnames(M) <- list(gender = c("F", "M"),
#                    party = c("Democrat","Independent", "Republican"))
#M
##
