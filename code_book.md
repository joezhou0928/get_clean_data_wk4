# A code book for run_analysis.R
## Path variables
x_train_path: The path to x_train.txt
x_test_path: The path to x_test_path.txt
sub_train_path: The path to subject_train.txt
sub_test_path: The path to subject_test.txt
feature_map_path: The path to features.txt
y_train_path: The path to y_train.txt
y_test_path: The path to y_test.txt
actv_lbls_path: The path to activity_labels.txt
## Initial data variables
x_train: Data read from x_train.txt
x_test: Data read from x_test.txt
sub_train: Data read from subject_train.txt
sub_test: Data read from subject_test.txt
y_train: Data read from y_train.txt
y_test: Data read from y_test.txt
## Variables for mapping
feature_map: Data read from features.txt containing the mapping relationship between feature indices and their names
actv_lbls: Mapping relationship between activity codes and activity names
## Variables for selected columns
mean_vars: The names for mean variables
std_vars: The names for standard deviation variables
## Final data variables
all_train: All data combining x_train and y_train
all_test: All data combining x_test and y_test
all_data: All data combining all_train and all_test
summarised_data: Average of each variable for each activity and each subject

