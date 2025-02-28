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


```python
# encode categorical variables, drop unrelated or duplicated features 

df1 = pd.get_dummies(df, columns=[‘trt’, ‘strat’]) 

# dropped duplicated columns

df1 = df1.drop([‘treat’,’str2′], axis=1)
```

### Feature scaling and feature selection
Most of our input variables are binary and categorical, and the output variable is also binary. Hence, we selected the chi-squared statistical test for feature selection.

**Trt_0** appears to have a greater impact on the results, though its association is only moderate, making it inconclusive. On the other hand, **Trt_3** shows little effect on the outcomes.

For logistic regression, we will apply feature scaling. While logistic regression is theoretically resistant to feature scaling, it can improve convergence speed and overall performance in practice.

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

We will perform classification using logistic regression and apply **L1 (Lasso)** regularization to penalize less important features, enhancing model sparsity and interpretability.

Additionally, we will implement feature scaling to improve model performance. While logistic regression and neural networks are theoretically insensitive to feature scaling, it can significantly enhance convergence speed and overall efficiency in practice.

<br>

```python
# Feature scaling
from sklearn.preprocessing import StandardScaler

# Initialize the StandardScaler
scaler = StandardScaler()

# Fit the scaler on the training data and transform both the training and testing data
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)
```

<br>

```python

from sklearn.linear_model import LogisticRegression

log_reg = LogisticRegression(penalty='l1', solver='liblinear', max_iter=1000) 
log_reg.fit(X_train_scaled, y_train)

# Make predictions
y_pred = log_reg.predict(X_test_scaled)

# Evaluate the model
accuracy = accuracy_score(y_test, y_pred)
print("Accuracy:", accuracy)
print(confusion_matrix(y_test, y_pred))
print("Classification Report:")
print(classification_report(y_test, y_pred))
```
<br>

### Logistic Regression Evaluation

![image.png](/AIDS_treatments/Images/aids7.png)

<br>

### Investigate the coefficient of the treatment

```python
import pandas as pd

# Retrieve the coefficient values
coefficients = log_reg.coef_[0]

# Create a DataFrame with feature names and coefficients
coeff_df = pd.DataFrame({'Feature': X_train.columns, 'Coefficient': coefficients})

# Sort the DataFrame by the absolute value of the coefficients in descending order
coeff_df['Absolute Coefficient'] = coeff_df['Coefficient'].abs()
coeff_df = coeff_df.sort_values(by='Absolute Coefficient', ascending=False)

# Print the coefficients in a DataFrame
print(coeff_df)
```

![image.png](/AIDS_treatments/Images/aids8.png)

<p> The top five features with the highest coefficients contribute to the logistic regression model. While our goal is to identify the most effective treatment, the low coefficient values make it challenging to determine which treatment is the best.

<br>

<br>

## Random Forest Classifier

<p> Since Logistic Regression does not provide a clear determination of which treatment is superior, we opted for a more robust model: Random Forest.

<p> The Random Forest classifier includes several hyperparameters that require tuning for optimal performance. To achieve this, we employed GridSearchCV to identify the best parameter combinations.

```python
from sklearn.model_selection import GridSearchCV


param_grid = {
    'n_estimators': [150,200],   # Number of trees in the forest
    'max_depth': [None, 10, 20],       # Maximum depth of the trees
    'min_samples_split': [2],   # Minimum number of samples required to split an internal node
    'min_samples_leaf': [1]      # Minimum number of samples required to be at a leaf node
}
```

**Best Parameters**: {'max_depth': 10, 'min_samples_leaf': 1, 'min_samples_split': 2, 'n_estimators': 200}  

<br>

```python
# Create a RandomForestClassifier
rf_classifier = RandomForestClassifier(random_state=42)

# Create a GridSearchCV object
grid_search = GridSearchCV(estimator=rf_classifier, param_grid=param_grid, cv=5, scoring='accuracy', n_jobs=-1)

# Perform grid search on the training data
grid_search.fit(X_train_scaled, y_train)

# Print the best parameters found by grid search
print("Best Parameters:", grid_search.best_params_)

# Print the best cross-validation score found by grid search
print("Best Cross-Validation Score:", grid_search.best_score_)

# Get the best model
best_classifier = grid_search.best_estimator_

# Make predictions on the test set using the best model
y_pred = best_classifier.predict(X_test_scaled)

# Evaluate the best model
accuracy = accuracy_score(y_test, y_pred)
print("Accuracy:", accuracy)
print("Classification Report:")
print(classification_report(y_test, y_pred))
```

**Best Cross-Validation Score**: 0.8953881301894192  
**Accuracy**: 0.8691588785046729

<br>

### Random Forest Evaluation

![image.png](/AIDS_treatments/Images/aids9.png)

The model achieved an accuracy of **0.87**, slightly outperforming logistic regression above. A classification report revealed similar overall performance to logistic regression, with the model excelling in predicting class 0, showing high precision, recall, and F1 scores. However, its performance in identifying class 1 (failure) remains limited. Next, we will analyze the impact of different treatments by evaluating feature importance scores.

<br>

### Feature importance

Unlike Logistic Regression, which relies on coefficient scores, Random Forest evaluates feature importance to determine the impact of different variables. The model’s strong predictive performance is largely influenced by factors such as time to failure or censoring and post-treatment white blood cell count (cd420).

The treatment options (trt_0, trt_1, trt_2) show relatively low and similar importance, with none standing out as a key predictor. We also trained a Naïve Bayes model, but its performance was comparable to that of Random Forest and Logistic Regression, so we chose not to include it.

![image.png](/AIDS_treatments/Images/aids10.png)

Rather than testing additional models, we are now considering whether treatment effectiveness varies across different age groups. Our next step will be to conduct a subgroup analysis based on patient age.

<br>

## Subgroup Analysis

First, we divided the patients into five distinct age groups.

```python
# Define age groups based on specified ranges
def get_age_group(age):
    if age <= 18:
        return '0-18'
    elif 19 <= age <= 30:
        return '19-30'
    elif 31 <= age <= 40:
        return '31-40'
    elif 41 <= age <= 50:
        return '41-50'
    else:
        return 'above 50'

# Apply age group function to create a new column 'age_group' and drop the age column
X['age_group'] = X['age'].apply(get_age_group)
X = X.drop(['age'], axis=1)   
X['age_group']
```

<br>

We ran the Random Forest model for each age group to investigate the feature importance within these different segments.

```python
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score

age_groups = ['age_group_0-18', 'age_group_19-30', 'age_group_31-40', 'age_group_41-50', 'age_group_above_50']

# Train and evaluate Random Forest for each age group
for age_group in age_groups:
    # Filter data for the current age group
    subset_X = X[X[age_group] == 1]  
    subset_y = y[X[age_group] == 1]
    
    X_train, X_test, y_train, y_test = train_test_split(subset_X, subset_y, test_size=0.2, random_state=42)
    clf = RandomForestClassifier(random_state=42)
    clf.fit(X_train, y_train)
    
    # Evaluate the model
    y_pred = clf.predict(X_test)
    accuracy = accuracy_score(y_test, y_pred)
    
    print(f"Age Group: {age_group}")
    print(f"Accuracy: {accuracy}")

    # Print feature importance scores in descending order
    print(f"Feature Importance (Descending Order):")
    feature_importance = clf.feature_importances_
    feature_importance_sorted = sorted(zip(X_train.columns, feature_importance), key=lambda x: x[1], reverse=True)
    for feature, importance in feature_importance_sorted:
        print(f"{feature}: {importance}")
    print("\n")
```
<br>

### Result

![image.png](/AIDS_treatments/Images/aids11.png)

While we cannot determine which treatment is superior, we found that age is positively correlated with the model’s accuracy. As the age group increases, the model predicts the censoring indicator (cid) more accurately. This insight presents an opportunity for further improvement by incorporating additional features like white blood cell count, we may uncover deeper patterns and enhance our analysis.

<br>

## References

- AIDS clinical trials group study 175. UCI Machine Learning Repository. (n.d.). https://www.archive.ics.uci.edu/dataset/890/aids+clinical+trials+group+study+175  
- World Health Organization. (n.d.). HIV data and statistics. World Health Organization. https://www.who.int/teams/global-hiv-hepatitis-and-stis-programmes/hiv/strategic-information/hiv-data-and-statistics 