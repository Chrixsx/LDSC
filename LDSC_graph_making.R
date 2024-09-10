# Example code to visualize LDSC outputs
# R 4.4.1
# Note: Code should be modified to align with format of matrix storing LDSC output
# Raw data: correlation matrix (corr) and p-value matrix (pval) of LDSC analysis in with first row and first column contain traits names

# Step 1: Tools and files preparation
# Loading library.
library(data.table)
library(corrplot)
library(tidyverse)
library(dplyr)
library(magrittr)
library(ggcorrplot)
library(corrplot)
library(ggplot2)
library(gridExtra)
library(grid)
library(rsvg)

# Save data path (directory) for easy fix in case of moving file location.
ori.path= "/Users/le.c/Library/CloudStorage/OneDrive-TheUniversityofMelbourne/LDSC_project_Sleep_Epi/Combined"

# Input raw data
corr.raw <-  fread(file.path(ori.path,"meeting_rg.txt")) %>% select(-c("V1"))      # Remove the V1 column storing traits name
pval.raw <- fread(file.path(ori.path,"meeting_pvalue.txt")) %>% select(-c("V1")) 

# Desired row name   
name <- c("All Epilepsy", "Genetic generalized epilepsy", "Childhood absence epilepsy", "Juvenile absence epilepsy", "Juvenile myoclonic epilepsy", "Generalized, with tonic-clonic seizures alone", "Focal epilepsy", "FE with hippocampal sclerosis", "FE lesion (-)", "Febril Seizure")
name <- gsub("\\n", " ", name)

#Creating matrix for corr value
if (length(name) == nrow(corr.raw)) {
  corr.df <- as.data.frame(corr.raw)  # Convert data.table to data.frame
  rownames(corr.df) <- name           # Set row names
  corr.matrix <- as.matrix(corr.df)   # Convert to matrix
} else {
  stop("The number of names does not match the number of rows in the data table.")
}
print(corr.matrix)                    # Display the matrix to check

## Creating matrix for p-value
if (length(name) == nrow(corr.raw)) {
  pval.df <- as.data.frame(pval.raw)  # Convert data.table to data.frame
  rownames(pval.df) <- name           # Set row names
  pval.matrix <- as.matrix(pval.df)   # Convert to matrix
} else {
  stop("The number of names does not match the number of rows in the data table.")
}
print(pval.matrix)                    # Display the matrix to check


# Step 2: Finding P-threshold Using Benjamini-Hochberg to control False discovery rate of multiple testing.
pval.vector <-  as.vector(pval.matrix)
sort.pval.vector <-  sort(pval.vector)
alpha <-  0.05
m <-  length(sort.pval.vector)
BH_threshold <-  seq(1,m)*alpha/m
L <-  max(which(sort.pval.vector<= BH_threshold))
sort.pval.vector[L]
cat("Benjamin-Hochberg correction is used to keep FDR at 0.05. corrected pvalue =", sort.pval.vector[L])


# Step 3: Making correlation_plot using ggcorrplot 

corrplot <- ggcorrplot(
  corr.matrix, 
  p.mat = pval.matrix,                              # Include pvalue matrix to display only significant results
  sig.level= sort.pval.vector[L],                   # Using B-H significant threshold to display only significant results
  insig= "blank",                                   # Set insignificant results as blank
  method="circle",                                  # Plot style
  hc.order = FALSE,
  legend.title = "Genetic correlation",
  lab=TRUE, lab_col="blue", lab_size= 3,             # Display correlation r2 to the data point
  ggtheme = theme_linedraw, outline.color = "black",
  colors = c("green", "white", "red"),               # Change legend color low-none-high
) 
corrplot # Display the plot to check


# Step 4: Customize/Annotate the plot 

# Annotate corrplot with square box to split Epilepsy traits into main groups:
annotated_corrplot= corrplot+ 
  annotate("rect", xmin= 1.5, xmax=6.5, ymin=0.5, ymax=11.5, fill= NA, size=0.5, color= "blue" ) +
  annotate("rect", xmin= 6.5, xmax=9.5, ymin=0.5, ymax=11.5, fill= NA, size=0.5, color= "red" )

# Issue with the margin of corplot making it difficult to add text to the plot.
# Solution: creating an white plot then add corrplot to the white plot

# Creating empty_plot
empty_plot= ggplot() + xlim(2,12) +  ylim(3,12) +
  theme_void() + 
  theme(plot.background = element_rect(fill= "white", color="white"))

# Break the corrplot to location vectors
corr_grob= ggplotGrob(annotated_corrplot)  

# Plot the location vectors to the empty white plot
combined_plot= empty_plot + annotation_custom(grob= corr_grob, xmin= 0, xmax=15, ymin=2.5, ymax=10.5) 

# Annotate with text
combined_plot + 
  annotate("text", x= 7.0, y=10.6, label="GGE subtypes") +
  annotate("text", x=8.4, y=10.6, label= "FE subtypes")

# Step 5: Save output
ggsave(file.path(ori.path,"LDSCplot.png"), dpi=1000, width = 11, height = 12)


