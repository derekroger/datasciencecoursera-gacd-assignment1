# Getting and Cleaning Data - Peer review assignment
## Derek Brown

### 1. Set parameters

The script first sets a few useful constants, such as the names of data folders to traverse to read data, the name of the directory where the data resides, and a few empty vectors.

### 2. Read in data

A loop reads in the three types of data - accelerometer measurements, manually labelled activities (represented by integers 1-6) and subject (person) IDs.

### 3. Give names to data

Useful column names are given to the data. For the measurements, a feature file is provided with the names of all 561 variables, which is used to assign the column names.

### 4. Extract measurements

Only the mean and standard deviation measurements (not meanFreq()) were retained as per the assignment instructions by using a regular expression match on the column names.

### 5. Combine data

The three datasets, including the subset of measurements, are combined

### 6. Activity names

A reference table was read in to give descriptive activity names to the integer values (1-6) that correspond to walking, laying, etc. This was then appended to the measurements data. The integer value was then removed as it was superfluous.

### 7. Tidy data set

A tidy dataset was created by first “melting” the combined dataset into one observation for every subject, activity and variable. An average was then taken for each combination of these factors and the data then “pivoted” such that each column was a different measurement and each row represented a subject and activity.