README
variablecpufreqvis.R

Author: Jesse Brown - jlb4@clemson.edu
CPSC 4910
DeepGreen - Submer Capstone Project

Functionality: This script addresses p04 and p06 and takes the CSV files from the extracted_metrics command under the utils folder
on the server and has examples of plotting both frequency and temperature.

With the CSV's within the script, import through given command to the path or import into RStudio in enviornment

Implementation: With the formatted output from the extract_metrics script accessing the data is very easy and readable on its own.
Within the script I aggregate the data into frames grouped by node and frequency for easy organization. Then the data is plotted using
ggplot with line graphs, one think to take into account that I am doing is that im shortening the data sets based on the smallest sample size,
this is not needed because when analyzing the data at the variable frequency the times the test will run will vary, so all data points need to be
accounted for, this can simply be changed by changed the aes x variable to the length of the longest data set, all other values that dont exist will
be null and not displayed on the graph. 
This is a simple data visualization to understand our tools and how effective they are at a base level. The implementation can be adjusted for larger
and more complex data collected from the air cooled or eventually the water cooled system. Implementations that were in the works include command line
interfacing to run the R script and visualize data by passing in the csv's but more research and analysis required to achieve as R is not normally
used on the command line. 