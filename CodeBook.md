### Code Book for Getting & Cleaning Data  

## Coursera Project  

# Input Data  
**Input data - File variables**  
url - url parth  
filename - url destination zip file name  

**Inputdata - Training data tables**  
subject_train - subject ID  
X_train - values of variables  
y_train - activity ID  

**Inputdata - Test data tables**  
subject_test - subject ID  
X_test - values of variables  
y_test - activity ID  

**Inputdata - Common data tables**  
activity_labels - description of activity variables  
features - description of each variable values  

**Output**  
Coma (,) separated "*.txt" file named "tidy_data.txt".  
This output file will be crated to the current working directory.  

# Computed Data  
merged_X_data - merged table of variables X_train & X_test  
mean_std_data - selected columns from merged_X_data, which has mean (mean()) & standard deviation std()  
subject_data - merged table of subject_train & subject_test  
activity_data - merged table of y_train & y_test  
combined_data - merged table of mean_std_data, subject_data & activity_data  

# Output file  
tidy_data.txt - Contains mean value of all variables against each subject & each activity. And this file is a coma (,) separated file.  

