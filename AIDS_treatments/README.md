# AIDS treatment study

![image.png](/AIDS_treatments/Images/aids1.png)

## Introduction

<p> In this project, we analyzed the AIDS Clinical Trials Group Study 175 dataset, which contains healthcare statistics, medical histories, and treatment details of patients diagnosed with AIDS. Originally published in 1996, this dataset forms the basis of our predictive analysis. Our goal is to determine whether each patient survived or passed away within a specified time frame. The key predictive variable in our study is the censoring indicator (cid), a binary variable representing patient outcomes—1 for failure (death) and 0 for censoring (survival beyond the study period).

## Dataset information

Most of the feature datatypes are either Boolean or categorical variables.

2139 entries, 0 to 2138

Data columns (total 24 columns):

| #  | Column  | Non-Null Count | Dtype   |
|----|--------|---------------|--------|
| 0  | time    | 2139 non-null  | int64  |
| 1  | trt     | 2139 non-null  | int64  |
| 2  | age     | 2139 non-null  | int64  |
| 3  | wtkg    | 2139 non-null  | float64 |
| 4  | hemo    | 2139 non-null  | bool   |
| 5  | homo    | 2139 non-null  | bool   |
| 6  | drugs   | 2139 non-null  | bool   |
| 7  | karnof  | 2139 non-null  | int64  |
| 8  | oprior  | 2139 non-null  | bool   |
| 9  | z30     | 2139 non-null  | bool   |
| 10 | zprior  | 2139 non-null  | bool   |
| 11 | preanti | 2139 non-null  | int64  |
| 12 | race    | 2139 non-null  | bool   |
| 13 | gender  | 2139 non-null  | bool   |
| 14 | str2    | 2139 non-null  | int64  |
| 15 | strat   | 2139 non-null  | int64  |
| 16 | symptom | 2139 non-null  | bool   |
| 17 | treat   | 2139 non-null  | int64  |
| 18 | offtrt  | 2139 non-null  | bool   |
| 19 | cd40    | 2139 non-null  | int64  |
| 20 | cd420   | 2139 non-null  | int64  |
| 21 | cd80    | 2139 non-null  | int64  |
| 22 | cd820   | 2139 non-null  | int64  |
| 23 | cid     | 2139 non-null  | int64  |

**Dtypes:**  
- **bool**: 10 columns  
- **float64**: 1 column  
- **int64**: 13 columns  

## Demographics Overview

![image.png](/AIDS_treatments/Images/aids2.png)

## Treatment

Trt: treatment indicator <br>
- 0 = ZDV only
- 1 = ZDV + ddI
- 2 = ZDV + Zal
- 3 = ddI only

![image.png](/AIDS_treatments/Images/aids3.png)

### Data Processing