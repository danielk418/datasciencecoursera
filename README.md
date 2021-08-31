# datasciencecoursera
Uses data from the Human Activity Recognition Using Smartphones Dataset for analysis. It reads in the test and training data observations, along with subjects and the activity labels.
The data of the different data sets is combined into one data set. Then a new data set is created, just keeping the variable names that are associated with averages or standard deviations.
The variable names are then updated to more specific names, and the case is set to lowercase. A data set called tidy_data is then created where certain column headers are converted to values, and then the subject_id and activities variables are grouped to compute the average. 

Codebook for tidy data set

subjectid - An id that designates the person that was involved in collecting the observation data.
activity  - The activity the subjectid (person) was involved in when the observation was made.
avg       - The average of the values based on the given subjectid, per activity. 
