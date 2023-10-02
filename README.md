# randomized-evaluation-data-management-and-quality-assessment-using-STATA
Randomized Evaluation Data Management and Quality Assessment using STATA
1. Importing – A high-frequency check. 
    a) Data with administrative variables with 3 different files in CSV format (data admin 1, data admin 2, and data admin 3). Imported, saved as .dta, checked, and randomly removed ID duplicates for all 3 datasets. 
    b) the main dataset is called data.dta – merged with the other 3 admin datasets.

2. Quality Checks - Checked the quality of the data. It's an indicator of whether there have been problems in the administration of the survey. 
    a) Showed in a table the total number of surveys completed for each enumerator.
    b) Calculated the average and median values of time spent surveying, considering only completed surveys. 
    c) For each surveyor in the dataset, displayed the output of the average length of time spent surveying, again for only completed surveys. 
    d) Created a new variable counting missing data per ID of variables coming from the admin datasets (variable name ends with _admin) and showed the results in a table.
    e) Checked if there is any variable where all the values are missing, or survey items nobody answered.

3. Cleaning – After collecting all of the data, cleaned it up so that it is ready to be used for analysis. 
    a) Removed personally identifiable information (PII). This variable is named in numeric format. 
    b) For analysis purposes, used the gender of the respondent as a 0-1 dummy variable. Created a new variable called female and assigned the 0-1 values according to sex.
    c) Checked all the remaining variables
