## Customer-Churn-Analysis
Customer retention is a top priority for telecom companies due to the high cost of acquiring new customers. The goal of this project is to analyze customer behavior and service patterns to identify what drives churn (the voluntary departure of customers) and to build a predictive model that can help the business act proactively.

### Telco Customer Churn Analysis

This project explores and predicts customer churn using the IBM Telco Customer Churn dataset. The aim is to help telecom companies identify customers likely to churn and take proactive retention actions.

### Overview

- **Tools**: Python, MySQL, Pandas, Seaborn, Scikit-learn
- **Techniques**: EDA, Logistic Regression, Feature Importance, Model Optimization
- **Business Objective**: Identify key churn drivers and reduce customer attrition

### Dataset

The dataset includes:
- Customer demographics
- Account details (tenure, contract type, billing)
- Services (phone, internet, tech support)
- Churn label (Yes/No)

### Project Breakdown

| Step | Description |
|------|-------------|
| 1    | Data cleaning and SQL exploration |
| 2    | Exploratory Data Analysis (EDA) |
| 3    | Logistic Regression Model |
| 4    | Model Evaluation and Feature Analysis |
| 5    | Final Report with Recommendations |

### Key Findings

- Customers on month-to-month contracts churn the most.
- Tenure is negatively correlated with churn.
- Lack of tech support and online security increases churn risk.

### Notebooks

- `01_data_cleaning_and_sql_extraction.ipynb`: SQL setup and data prep
- `02_eda_and_visualizations.ipynb`: Exploratory insights with visuals
- `03_logistic_regression_model.ipynb`: Building and training the model
- `04_model_evaluation_and_feature_importance.ipynb`: Performance evaluation and optimization

### Visuals

Sample visualizations are available in the `visuals/` folder.

### Requirements

To install dependencies:
```bash
pip install -r requirements.txt

