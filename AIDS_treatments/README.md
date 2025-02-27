# AIDS treatment study

![image.png](/AIDS_treatments/Images/aids1.png)

## Introduction

<p> In this project, we analyzed the AIDS Clinical Trials Group Study 175 dataset, which contains healthcare statistics, medical histories, and treatment details of patients diagnosed with AIDS. Originally published in 1996, this dataset forms the basis of our predictive analysis. Our goal is to determine whether each patient survived or passed away within a specified time frame. The key predictive variable in our study is the censoring indicator (cid), a binary variable representing patient outcomes—1 for failure (death) and 0 for censoring (survival beyond the study period).

<br>

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

<br>

## Demographics Overview

![image.png](/AIDS_treatments/Images/aids2.png)

## Treatment

Trt: treatment indicator <br>
- 0 = ZDV only
- 1 = ZDV + ddI
- 2 = ZDV + Zal
- 3 = ddI only

![image.png](/AIDS_treatments/Images/aids3.png)

<br>

## Data Processing

### Dropped duplicated columns and encoded categorical variables

![image.png](/AIDS_treatments/Images/aids4.png)

### Feature scaling and feature selection
<p> Most of our input variables are binary and categorical, and the output variable is also binary. Hence, we selected the chi-squared statistical test for feature selection.

<p> Trt_0 appears to have a greater impact on the results, though its association is only moderate, making it inconclusive. On the other hand, Trt_3 shows little effect on the outcomes.

<p> For logistic regression, we will apply feature scaling. While logistic regression is theoretically resistant to feature scaling, it can improve convergence speed and overall performance in practice.

![image.png](/AIDS_treatments/Images/aids5.png)

**Other features**
- **Strong Association**: time

- **Moderate Association**: preanti, cd420, cd40, cd80

- **Moderate to Weak Association**: cd820, symptom, trt_0

- **Weak Association**: age, strat_1, strat_3, z30

- **Very Weak Association**: offtrt, karnof, trt_1, race, drugs, trt_2, oprior

- **Negligible Association**: (Drop) homo, wtkg, gender, trt_3, hemo, strat_2, zprior

<br>

## Logistic Regression Classification

<p> We will perform classification using logistic regression and apply **L1 (Lasso)** regularization to penalize less important features, enhancing model sparsity and interpretability.

<p> Additionally, we will implement feature scaling to improve model performance. While logistic regression and neural networks are theoretically insensitive to feature scaling, it can significantly enhance convergence speed and overall efficiency in practice.

<br>

![image.png](/AIDS_treatments/Images/aids6.png)


### Logistic Regression Evaluation

![image.png](/AIDS_treatments/Images/aids7.png)

<br>

![image.png](/AIDS_treatments/Images/aids8.png)

<p> The top five features with the highest coefficients contribute to the logistic regression model. While our goal is to identify the most effective treatment, the low coefficient values make it challenging to determine which treatment is the best.

<br>

## Random Forest Model