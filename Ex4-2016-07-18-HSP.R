#04.03 H
# 드럼통에 들어있는 원료를 알칼리로 씻어내는 실험.
# 수없이 많은 드럼통에 대하여 드럼통마다 그 특성치를 측정하고 사용하기는 경제적으로 곤란함.
# 드럼통 5개를 랜덤하게 골라, 4종의 알칼리 처리조건(A=6,7,8,9%)으로 세척
# 20회의 실험을 랜덤하게 하여 실시한 결과 다음의 결과 얻음

WD = c("D:\\project\\ExperimentDesign\\src", # 회의실 컴퓨터
       "~/GIT/ExperimentDesign/src",
       "D:\\GIT\\ExperimentDesign\\src")
setwd(WD[3])
Ex4.3 = read.csv("shan/Ex4.3.CSV"); matrix(Ex4.3$Y, ncol=4)
#     [,1] [,2] [,3] [,4]
#[1,] 13.2 12.5  9.8  6.9
#[2,] 11.4 10.0  8.7  5.8
#[3,] 10.9  8.5  7.6  4.2
#[4,]  9.9  9.7  9.4  6.6
#[5,] 10.3  9.0  7.5  5.2

# (1) 드럼통 인자 B는 모수인자인가, 변량인자인가? (모수)
#     이 인자 B는 블록인자인가, 집단인자인가? (집단)
#     이런 시험계획법을 무엇이라 부르나? (난괴법)
# (2) ANOVA 행하라. 요인 B가 유의하다면 그 의미는 무엇? (유의하다.)

source("a2wnorpl.R")
Ex4.3Res = a2wnorpl(Ex4.3, alpha = 0.05)
Ex4.3Res[["SS"]]
#           SS phi         MS
#[1,]  80.8335   3 26.9445000 # 
#[2,]  19.6220   4  4.9055000 #
#[3,]   5.6140  12  0.4678333 # 
#[4,] 106.0695  19  5.5826053 #

Ex4.3Res[["F"]]
#            F  F(0.05)      p-value
#[1,] 57.59423 3.490295 2.137640e-07 # HIGHLY SIGNIFICANT; F >> qf(0.95,3,12)
#[2,] 10.48557 3.259167 6.866409e-04 # HIGHLY SIGNIFICANT; F >> qf(0.95,4,12)

# (3) 알칼리 농도변화에 따른 품질 특성의 95% 신뢰구간을 구하고 이를 도시하라.
Ex4.3Res[["Means: A"]]
#         LL.a   xi.     UL.a
#[1,] 10.47353 11.14 11.80647 # 6%
#[2,]  9.27353  9.94 10.60647 # 7%
#[3,]  7.93353  8.60  9.26647 # 8%
#[4,]  5.07353  5.74  6.40647 # 9%

library(gplots)
plotCI(Ex4.3Res[[3]][,2], uiw=(Ex4.3Res[[3]][,2]-Ex4.3Res[[3]][,1])/t.crt, type="b", xaxt="n")#, ylim=c(83, 95)) # 83.5,84.5
axis(side=1, at=1:4, cex=0.7)

# (4) 6% A1과 9% A4간 품질특성차를 95% 신뢰구간으로 구간추정하라.
Ex4.3Res[["Pairwise Difference of A"]]
#     Ai Aj   PE        LL       UL Zero    Tukey LL Tukey UL Zero2
#[1,]  1  2 1.20 0.2574693 2.142531    1 -0.08431428 2.484314     0
#[2,]  1  3 2.54 1.5974693 3.482531    1  1.25568572 3.824314     1
#[3,]  1  4 5.40 4.4574693 6.342531    1  4.11568572 6.684314     1 #
#[4,]  2  3 1.34 0.3974693 2.282531    1  0.05568572 2.624314     1
#[5,]  2  4 4.20 3.2574693 5.142531    1  2.91568572 5.484314     1
#[6,]  3  4 2.86 1.9174693 3.802531    1  1.57568572 4.144314     1
