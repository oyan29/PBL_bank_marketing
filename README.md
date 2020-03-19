# PBL_bank_marketing
Practice data analysis with R. Perform banking marketing analysis.
![1286490](https://user-images.githubusercontent.com/3444105/77019941-72940b00-69c5-11ea-99df-48484752c8dd.jpg)

# Overview
## ⚠️ Caution
This is a practice repository.

## Language used
R

# 💩 Source file
## for MAC
src/bank_marketing_utf8.R
* The character code of this file is without UTF-8 BOM.

## for Japanese Windows
Please convert the character code to Shift_JIS.
## for Windows other than Japanese
Please convert the character code to UTF-8 with BOM.

# Dataset
## Description
| カラム名 | 定義 |
| :---: | :---: |
| age            | 年齢 |
| job            | 職業 |
| marital        | 婚姻状況 |
| default        | クレジットの支払遅延 |
| education      | 最終学歴 |
| housing        | 不動産ローンの有無 |
| loan           | 個人ローンの有無 |
| contact        | 連絡デバイス |
| day_of_week    | 最終連絡曜日 |
| duration       | 通話時間(秒) |
| campaign       | キャンペン期間中の接触回数 |
| pdays          | 前回の接触からの経過日数 |
| previous       | 以前のキャンペーン結果 |
| poutcome       | 以前のキャンペーンの接触回数 |
| emp.var.rate   | employment variation rate |
| cons.price.idx | 消費者物価指数 |
| cons.conf.idx  | 消費者信頼感指数 |
| euribor3m      | ３ヶ月間ユーリボー指標金利 |
| nr.employed    | 四半期ごとの就業者数 |
| y              | テレマーケティングの結果 |

## Details
[UCI:Bank Marketing Data Set](https://archive.ics.uci.edu/ml/datasets/bank+marketing#)
## 📃 training data
src/bank_marketing_train.csv
## 📑 test data
src/bank_marketing_test.csv

# ✅ Task
## 📈 Task 1
---
Analyze past telemarketing data to determine the target user's persona.
---
過去のテレマーケティングデータを分析して、  
ターゲットユーザーのペルソナを調べる。
---

## 📊 Task 2
---
I want to create an attack list using a predictive model to maximize future telemarketing revenue (sales-cost).
Create an algorithm that outputs a prediction model.
---
今後のテレマーケティングの収益(売上 - 費用)を最大化させるための、  
予測モデルを用いたアタックリストを作成したい。  
予測モデルを出力するアルゴリズムの作成する。
---

# Analysis results
Summarized in google slide.  
[テレマーケティングの分析](https://docs.google.com/presentation/d/1XOTe0vtXPOcgHAdQlEiVnjTgES54jnAREL0m6kwSyWs/edit?usp=sharing)