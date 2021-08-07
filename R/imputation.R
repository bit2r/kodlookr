#' Impute Missing Values
#'
#' @description
#' Missing values are imputed with some representative values and
#' statistical methods.
#'
#' @details
#' imputate_na() creates an imputation class.
#' The `imputation` class includes missing value position, imputed value,
#' and method of missing value imputation, etc.
#' The `imputation` class compares the imputed value with the original value
#' to help determine whether the imputed value is used in the analysis.
#'
#' See vignette("transformation") for an introduction to these concepts.
#'
#' @param .data a data.frame or a \code{\link{tbl_df}}.
#' @param xvar variable name to replace missing value.
#' @param yvar target variable.
#' @param method method of missing values imputation.
#' @param seed integer. the random seed used in mice. only used "mice" method.
#' @param print_flag logical. If TRUE, mice will print running log on console.
#' Use print_flag=FALSE for silent computation. Used only when method is "mice".
#' @param no_attrs logical. If TRUE, return numerical variable or categorical variable. 
#' else If FALSE, imputation class.
#' @return An object of imputation class. or numerical variable or categorical variable. 
#' if no_attrs is FALSE then return imputation class, else no_attrs is TRUE then return
#' numerical vector or factor.
#' Attributes of imputation class is as follows.
#' \itemize{
#' \item var_type : the data type of predictor to replace missing value.
#' \item method : method of missing value imputation.
#' \itemize{
#'   \item predictor is numerical variable.
#'   \itemize{
#'     \item "mean" : arithmetic mean.
#'     \item "median" : median.
#'     \item "mode" : mode.
#'     \item "knn" : K-nearest neighbors.
#'     \item "rpart" : Recursive Partitioning and Regression Trees.
#'     \item "mice" : Multivariate Imputation by Chained Equations.
#'   }
#'   \item predictor is categorical variable.
#'   \itemize{
#'     \item "mode" : mode.
#'     \item "rpart" : Recursive Partitioning and Regression Trees.
#'     \item "mice" : Multivariate Imputation by Chained Equations.
#'   }
#' }
#' \item na_pos : position of missing value in predictor.
#' \item seed : the random seed used in mice. only used "mice" method.
#' \item type : "missing values". type of imputation.
#' \item message : a message tells you if the result was successful.
#' \item success : Whether the imputation was successful.
#' }
#' @seealso \code{\link{imputate_outlier}}.
#' @examples
#' \donttest{
#' # Generate data for the example
#' heartfailure2 <- heartfailure
#' heartfailure2[sample(seq(NROW(heartfailure2)), 20), "platelets"] <- NA
#' heartfailure2[sample(seq(NROW(heartfailure2)), 5), "smoking"] <- NA
#' 
#' # Replace the missing value of the platelets variable with median
#' imputate_na(heartfailure2, platelets, method = "median")
#' 
#' # Replace the missing value of the platelets variable with rpart
#' # The target variable is death_event.
#' imputate_na(heartfailure2, platelets, death_event, method = "rpart")
#' 
#' # Replace the missing value of the smoking variable with mode
#' imputate_na(heartfailure2, smoking, method = "mode")
#' 
#' # Replace the missing value of the smoking variable with mice
#' # The target variable is death_event.
#' imputate_na(heartfailure2, smoking, death_event, method = "mice")
#' 
#' ## using dplyr -------------------------------------
#' library(dplyr)
#' 
#' # The mean before and after the imputation of the platelets variable
#' heartfailure2 %>%
#'   mutate(platelets_imp = imputate_na(heartfailure2, platelets, death_event, 
#'                                      method = "knn", no_attrs = TRUE)) %>%
#'   group_by(death_event) %>%
#'   summarise(orig = mean(platelets, na.rm = TRUE),
#'             imputation = mean(platelets_imp))
#' 
#' # If the variable of interest is a numerical variable
#' platelets <- imputate_na(heartfailure2, platelets, death_event, method = "rpart")
#' platelets
#' summary(platelets)
#' 
#' # plot(platelets)
#' 
#' # If the variable of interest is a categorical variable
#' smoking <- imputate_na(heartfailure2, smoking, death_event, method = "mice")
#' smoking
#' summary(smoking)
#' 
#' # plot(smoking)
#' }
#' 
#' @name imputate_na
#' @usage imputate_na(.data, xvar, yvar, method, seed, print_flag, no_attrs)
#'
NULL


#' Impute Outliers
#'
#' @description
#' Outliers are imputed with some representative values and statistical methods.
#'
#' @details
#' imputate_outlier() creates an imputation class.
#' The `imputation` class includes missing value position, imputed value,
#' and method of missing value imputation, etc.
#' The `imputation` class compares the imputed value with the original value
#' to help determine whether the imputed value is used in the analysis.
#'
#' See vignette("transformation") for an introduction to these concepts.
#'
#' @param .data a data.frame or a \code{\link{tbl_df}}.
#' @param xvar variable name to replace missing value.
#' @param method method of missing values imputation.
#' @param no_attrs logical. If TRUE, return numerical variable or categorical variable. 
#' else If FALSE, imputation class. 
#' @return An object of imputation class. or numerical variable. 
#' if no_attrs is FALSE then return imputation class, else no_attrs is TRUE then return
#' numerical vector.
#' Attributes of imputation class is as follows.
#' \itemize{
#' \item method : method of missing value imputation.
#' \itemize{
#'   \item predictor is numerical variable
#'   \itemize{
#'     \item "mean" : arithmetic mean
#'     \item "median" : median
#'     \item "mode" : mode
#'     \item "capping" : Impute the upper outliers with 95 percentile,
#'     and Impute the bottom outliers with 5 percentile.
#'   }
#' }
#' \item outlier_pos : position of outliers in predictor.
#' \item outliers : outliers. outliers corresponding to outlier_pos.
#' \item type : "outliers". type of imputation.
#' }
#' @seealso \code{\link{imputate_na}}.
#' @examples
#' # Replace the outliers of the sodium variable with median.
#' imputate_outlier(heartfailure, sodium, method = "median")
#' 
#' # Replace the outliers of the sodium variable with capping.
#' imputate_outlier(heartfailure, sodium, method = "capping")
#' 
#' ## using dplyr -------------------------------------
#' library(dplyr)
#' 
#' # The mean before and after the imputation of the sodium variable
#' heartfailure %>%
#'   mutate(sodium_imp = imputate_outlier(heartfailure, sodium, 
#'                                       method = "capping", no_attrs = TRUE)) %>%
#'   group_by(death_event) %>%
#'   summarise(orig = mean(sodium, na.rm = TRUE),
#'             imputation = mean(sodium_imp, na.rm = TRUE))
#'             
#' # If the variable of interest is a numerical variables
#' sodium <- imputate_outlier(heartfailure, sodium)
#' sodium
#' summary(sodium)
#' 
#' plot(sodium)
#' @name imputate_outlier
#' @usage imputate_outlier(.data, xvar, method, no_attrs)
#' 
NULL


#' Summarizing imputation information
#'
#' @description print and summary method for "imputation" class.
#' @param object an object of class "imputation", usually, a result of a call to imputate_na() or
#' imputate_outlier().
#' @param ... further arguments passed to or from other methods.
#' @details
#' summary.imputation() tries to be smart about formatting two kinds of imputation.
#'
#' @seealso \code{\link{imputate_na}}, \code{\link{imputate_outlier}}, \code{\link{summary.imputation}}.
#' @examples
#' \donttest{
#' # Generate data for the example
#' heartfailure2 <- heartfailure
#' heartfailure2[sample(seq(NROW(heartfailure2)), 20), "platelets"] <- NA
#' heartfailure2[sample(seq(NROW(heartfailure2)), 5), "smoking"] <- NA
#'
#' # Impute missing values -----------------------------
#' # If the variable of interest is a numerical variables
#' platelets <- imputate_na(heartfailure2, platelets, death_event, method = "rpart")
#' platelets
#' summary(platelets)
#' plot(platelets)
#'
#' # If the variable of interest is a categorical variables
#' smoking <- imputate_na(heartfailure2, smoking, death_event, method = "mice")
#' smoking
#' summary(smoking)
#' 
#' # plot(smoking)
#'
#' # Impute outliers ----------------------------------
#' # If the variable of interest is a numerical variable
#' platelets <- imputate_outlier(heartfailure2, platelets, method = "capping")
#' platelets
#' summary(platelets)
#' 
#' # plot(platelets)
#' }
#' @name summary.imputation
#' @usage summary.imputation(object, ...)
#' 
NULL


#' Visualize Information for an "imputation" Object
#'
#' @description
#' Visualize two kinds of plot by attribute of `imputation` class.
#' The imputation of a numerical variable is a density plot,
#' and the imputation of a categorical variable is a bar plot.
#'
#' @param x an object of class "imputation", usually, a result of a call to imputate_na()
#' or imputate_outlier().
#' @param typographic logical. Whether to apply focuses on typographic elements to ggplot2 visualization. 
#' The default is TRUE. if TRUE provides a base theme that focuses on typographic elements using hrbrthemes package.
#' @param ... arguments to be passed to methods, such as graphical parameters (see par).
#' only applies when the model argument is TRUE, and is used for ... of the plot.lm() function.
#' @seealso \code{\link{imputate_na}}, \code{\link{imputate_outlier}}, \code{\link{summary.imputation}}.
#' @examples
#' \donttest{
#' # Generate data for the example
#' heartfailure2 <- heartfailure
#' heartfailure2[sample(seq(NROW(heartfailure2)), 20), "platelets"] <- NA
#' heartfailure2[sample(seq(NROW(heartfailure2)), 5), "smoking"] <- NA
#'
#' # Impute missing values -----------------------------
#' # If the variable of interest is a numerical variables
#' platelets <- imputate_na(heartfailure2, platelets, death_event, method = "rpart")
#' platelets
#' summary(platelets)
#' 
#' plot(platelets)
#'
#' # If the variable of interest is a categorical variables
#' smoking <- imputate_na(heartfailure2, smoking, death_event, method = "mice")
#' smoking
#' summary(smoking)
#' 
#' plot(smoking)
#'
#' # Impute outliers ----------------------------------
#' # If the variable of interest is a numerical variable
#' platelets <- imputate_outlier(heartfailure2, platelets, method = "capping")
#' platelets
#' summary(platelets)
#' 
#' plot(platelets)
#' }
#' @name plot.imputation
#' @usage plot.imputation(x, typographic = TRUE, ...)
#' 
NULL
