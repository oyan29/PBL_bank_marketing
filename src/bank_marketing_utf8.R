## Basic Step Statistics Project Based Learning
## Bank Marketing

# ワーキングディレクトリを設定してください
#   Sessions -> Set Working Directory -> Choose folder

# 学習用のCSVデータを読み込み
bank_marketing_train <- read.csv("bank_marketing_train.csv")

#############################################
###############   データ探索  ###############
#############################################
library(ggplot2)

# データカラムを確認
colnames(bank_marketing_train)

# データの要約統計量を確認
summary(bank_marketing_train)

# データ可視化
#install.packages('esquisse')
esquisse::esquisser(bank_marketing_train)

#未成約が多いデータであることがわかる。
prop.table(table(bank_marketing_train$y))


#############################################
## 分析1: ターゲットユーザーのペルソナ解釈 ##
#############################################
# install.packages('precrec')
library(precrec)

# 年代カテゴリを作成する
train <- bank_marketing_train
train$generation <- trunc(train$age / 10) # 小数点部分を切り捨て
# カテゴリ変数に変換
train$generation<-as.factor(train$generation)

######################################################################
# 以下のペルソナに効きそうなカテゴリを対象とする。
# | age        | 年齢
# | job        | 職業
# | marital    | 婚姻状況
# | default    | クレジットの支払遅延
# | education  | 最終学歴
# | housing    | 不動産ローンの有無
# | loan       | 個人ローンの有無
# | previous   | 以前のキャンペーン結果
# ロジスティック回帰
model1<-glm(y~age+job+marital+default+education+housing+loan+previous
            ,data = train
            ,family = "binomial"
)

# サマリ
summary(model1)

# 回帰係数
model1$coefficients

# 回帰係数から指数を取り出す(オッズ比)
exp(model1$coefficients)

# オッズ比可視化
par(cex.axis=0.5,las=1,mar=c(3, 7, 1, 1))
barplot(sort(exp(model1$coefficients)), horiz=T, cex.names=0.8, cex.axis=0.5, main = "Odds Ratio")
abline(v=1)
######################################################################
######################################################################
# 以下のペルソナに効きそうなカテゴリを対象とする。
# | generation | 年代（新カテゴリ）
# | previous   | 以前のキャンペーン結果
# ロジスティック回帰
model1<-glm(y~generation+previous
            ,data = train
            ,family = "binomial"
)

# サマリ
summary(model1)

# 回帰係数
model1$coefficients

# 回帰係数から指数を取り出す(オッズ比)
exp(model1$coefficients)

# オッズ比可視化
par(cex.axis=0.5,las=1,mar=c(3, 7, 1, 1))
barplot(sort(exp(model1$coefficients)), horiz=T, cex.names=0.8, cex.axis=0.6, main = "Odds Ratio")
abline(v=1)
######################################################################

#################################################
## 分析2: アタックリストのための予測モデル作成 ##
#################################################

# 収益計算のための変数を作成
sales <- 5000  # 売上
cost <- 500    # コスト

##### 学習データとテストデータに分割
#####train_idx<-sample(c(1:dim(train)[1]), size = dim(train)[1]*0.7)
#####train_train <- train[train_idx, ]
#####train_test <- train[-train_idx, ]

#################################################
# 全てを突っ込む場合
#################################################
# ロジスティック回帰
model1 <- glm(y~., data=train, family='binomial')
summary(model1)
# 回帰係数
model1$coefficients
# 回帰係数から指数を取り出す(オッズ比)
exp(model1$coefficients)
# 予測(n%の確率で成約)
y_pred <- predict(model1, data=train, type='response')
y_pred
# 予測値の平均
y_mean <- mean(y_pred) # 0.1124941
y_mean
# 予測値をフラグに変換
y_pred_flag <- ifelse( y_pred > y_mean, 1, 0 )
y_pred_flag
# 混同行列
table(y_pred_flag, train$y)
# y_pred_flag    no   yes
#           0 25432   514
#           1  4516  3282
#################################################

#################################################
# "退職者"かつ"60才以上"かつ"以前に成約"
#################################################
# 退職者を抽出
train2 <- train[train$job=="retired",]
# さらに60才以上を抽出
train2 <- train2[train2$age>60,]
# さらに以前のキャンペーン結果が成約を抽出
train2 <- train2[train2$previous==1,]
# Jobが退職者のみとなったので単一因子の列は除外する
train2 <- train2[, colnames(train2) != "job"]

# ロジスティック回帰
model2 <- glm(y~., data=train2, family='binomial')
summary(model2)
# 回帰係数
model2$coefficients
# 回帰係数から指数を取り出す(オッズ比)
exp(model2$coefficients)
# 予測(n%の確率で成約)
y_pred <- predict(model2, data=train2, type='response')
y_pred
# 予測値の平均
y_mean <- mean(y_pred) # 0.4899329
y_mean
# 予測値をフラグに変換
y_pred_flag <- ifelse( y_pred > y_mean, 1, 0 )
y_pred_flag
# 混同行列
table(y_pred_flag, train2$y)
# y_pred_flag  no  yes
#           0  63   14
#           1  13   59
#################################################

# 学習用のCSVデータを読み込み
bank_marketing_test <- read.csv("bank_marketing_test.csv")

# 年代カテゴリを作成する
train <- bank_marketing_test
train$generation <- trunc(train$age / 10) # 小数点部分を切り捨て
# カテゴリ変数に変換
train$generation<-as.factor(train$generation)
#################################################
# "退職者"かつ"60才以上"かつ"以前に成約"
#################################################
# 退職者を抽出
train2 <- train[train$job=="retired",]
# さらに60才以上を抽出
train2 <- train2[train2$age>60,]
# さらに以前のキャンペーン結果が成約を抽出
train2 <- train2[train2$previous==1,]
# Jobが退職者のみとなったので単一因子の列は除外する
train2 <- train2[, colnames(train2) != "job"]

# ロジスティック回帰
model2 <- glm(y~., data=train2, family='binomial')
summary(model2)
# 回帰係数
model2$coefficients
# 回帰係数から指数を取り出す(オッズ比)
exp(model2$coefficients)
# 予測(n%の確率で成約)
y_pred <- predict(model2, data=train2, type='response')
y_pred
# 予測値の平均
y_mean <- mean(y_pred) # 0.4615385
y_mean
# 予測値をフラグに変換
y_pred_flag <- ifelse( y_pred > y_mean, 1, 0 )
y_pred_flag
# 混同行列
table(y_pred_flag, train2$y)
# y_pred_flag   no   yes
#            0  14     0
#            1  0     12
#################################################