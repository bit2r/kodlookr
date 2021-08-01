#' @rdname univar_category.data.frame
#' @name univar_category
#' @usage univar_category(.data, ...)
#' 
NULL


#' @rdname univar_numeric.data.frame
#' @name univar_numeric
#' @usage univar_numeric(.data, ...)
#' 
NULL


#'  Statistic of univariate categorical variables
#'
#' @description The univar_category() calculates statistic of categorical variables that is frequency table
#'
#' @details 
#' univar_category() calculates the frequency table of categorical variables. 
#' If a specific variable name is not specified, frequency tables for all categorical variables included in the data are calculated.
#' The univar_category class returned by univar_category() is useful because it can draw chisqure tests and bar plots as well as frequency tables of individual variables.
#' and return univar_category class that based list object.
#'
#' @return An object of the class as individual variables based list.
#' The information to examine the relationship between categorical variables is as follows each components.
#'
#' \itemize{
#' \item variable : factor. The level of the variable. 'variable' is the name of the variable.
#' \item n : integer. frequency by variable.
#' \item rate : double. relative frequency.
#' }
#'
#' @section Attributes of return object:
#' Attributes of compare_category class is as follows.
#' \itemize{
#' \item variables : character. List of variables selected for calculate frequency.
#' }
#' 
#' @param .data a data.frame or a \code{\link{tbl_df}}.
#' @param ... one or more unquoted expressions separated by commas.
#' You can treat variable names like they are positions.
#' Positive values select variables; negative values to drop variables.
#' These arguments are automatically quoted and evaluated in a context where column names
#' represent column positions.
#' They support unquoting and splicing.
#'
#' @seealso \code{\link{summary.univar_category}}, 
#' \code{\link{print.univar_category}}, \code{\link{plot.univar_category}}.
#' @examples
#' library(dplyr)
#' 
#' # Calculates the all categorical variables
#' all_var <- univar_category(heartfailure)
#' 
#' # Print univar_category class object
#' all_var
#' 
#' # Calculates the only smoking variable
#' all_var %>% 
#'   "["(names(all_var) %in% "smoking")
#' 
#' smoking <- univar_category(heartfailure, smoking)
#' 
#' # Print univar_category class object
#' smoking
#' 
#' # Filtering the case of smoking included NA 
#' smoking %>%
#'   "[["(1) %>% 
#'   filter(!is.na(smoking))
#' 
#' # Summary the all case : Return a invisible copy of an object.
#' stat <- summary(all_var)
#' 
#' # Summary by returned object
#' stat
#' 
#' # plot all variables
#' # plot(all_var)
#' 
#' # plot smoking
#' # plot(smoking)
#' 
#' # plot all variables by prompt
#' # plot(all_var, prompt = TRUE)
#' 
#' @name univar_category.data.frame
#' @usage 
#' ## S3 method for class 'data.frame'
#' univar_category(.data, ...)
#' 
NULL


#'  Statistic of univariate numerical variables
#'
#' @description The univar_numeric() calculates statistic of numerical variables that is frequency table
#'
#' @details 
#' univar_numeric() calculates the popular statistics of  numerical variables. 
#' If a specific variable name is not specified, statistics for all categorical numerical included in the data are calculated.
#' The statistics obtained by univar_numeric() are part of those obtained by describe(). 
#' Therefore, it is recommended to use describe() to simply calculate statistics. 
#' However, if you want to visualize the distribution of individual variables, you should use univar_numeric().
#'
#' @return An object of the class as individual variables based list.
#' A component named "statistics" is a tibble object with the following statistics.:
#' \itemize{
#' \item variable : factor. The level of the variable. 'variable' is the name of the variable.
#' \item n : number of observations excluding missing values
#' \item na : number of missing values
#' \item mean : arithmetic average
#' \item sd : standard deviation
#' \item se_mean : standrd error mean. sd/sqrt(n)
#' \item IQR : interquartile range (Q3-Q1)
#' \item skewness : skewness
#' \item kurtosis : kurtosis
#' \item median : median. 50\% percentile
#' }
#'
#' @section Attributes of return object:
#' Attributes of compare_category class is as follows.
#' \itemize{
#' \item raw : a data.frame or a \code{\link{tbl_df}}. Data containing variables to be compared. 
#' Save it for visualization with plot.univar_numeric().
#' \item variables : character. List of variables selected for calculate statistics.
#' }
#' 
#' @param .data a data.frame or a \code{\link{tbl_df}}.
#' @param ... one or more unquoted expressions separated by commas.
#' You can treat variable names like they are positions.
#' Positive values select variables; negative values to drop variables.
#' These arguments are automatically quoted and evaluated in a context where column names
#' represent column positions.
#' They support unquoting and splicing.
#'
#' @seealso \code{\link{summary.univar_numeric}}, 
#' \code{\link{print.univar_numeric}}, \code{\link{plot.univar_numeric}}.
#' @examples
#' # Calculates the all categorical variables
#' all_var <- univar_numeric(heartfailure)
#' 
#' # Print univar_numeric class object
#' all_var
#' 
#' # Calculates the platelets, sodium variable
#' univar_numeric(heartfailure, platelets, sodium)
#' 
#' # Summary the all case : Return a invisible copy of an object.
#' stat <- summary(all_var)
#' 
#' # Summary by returned object
#' stat
#' 
#' # Statistics of numerical variables normalized by Min-Max method
#' summary(all_var, stand = "minmax")
#' 
#' # Statistics of numerical variables standardized by Z-score method
#' summary(all_var, stand = "zscore")
#' 
#' # one plot with all variables
#' # plot(all_var)
#' 
#' # one plot with all normalized variables by Min-Max method
#' # plot(all_var, stand = "minmax")
#' 
#' # one plot with all variables
#' # plot(all_var, stand = "none")
#' 
#' # one plot with all robust standardized variables 
#' # plot(all_var, viz = "boxplot")
#' 
#' # one plot with all standardized variables by Z-score method 
#' # plot(all_var, viz = "boxplot", stand = "zscore")
#' 
#' # individual boxplot by variables
#' # plot(all_var, indiv = TRUE, "boxplot")
#' 
#' # individual histogram by variables
#' # plot(all_var, indiv = TRUE, "hist")
#' 
#' # individual histogram by robust standardized variable 
#' # plot(all_var, indiv = TRUE, "hist", stand = "robust")
#' 
#' # plot all variables by prompt
#' # plot(all_var, indiv = TRUE, "hist", prompt = TRUE)
#' 
#' @name univar_numeric.data.frame
#' @usage 
#' ## S3 method for class 'data.frame'
#' univar_numeric(.data, ...)
#' 
NULL


#' Summarizing univar_category information
#'
#' @description print and summary method for "univar_category" class.
#' @param object an object of class "univar_category", usually, a result of a call to univar_category().
#' @param na.rm logical. Specifies whether to include NA when performing a chi-square test. 
#' The default is TRUE, where NA is removed and aggregated.
#' @param ... further arguments passed to or from other methods.
#' @details
#' print.univar_category() displays only the information of variables included in univar_category. 
#' The "variables" attribute is not displayed.
#'
#' @return An object of the class as individual variables based list.
#' The information to examine the relationship between categorical variables is as follows each components.
#'
#' \itemize{
#' \item variable : factor. The level of the variable. 'variable' is the name of the variable.
#' \item statistic : numeric. the value the chi-squared test statistic.
#' \item p.value : numeric. the p-value for the test.
#' \item df : integer. the degrees of freedom of the chi-squared test.
#' }
#' 
#' @seealso \code{\link{plot.univar_category}}.
#' @examples
#' library(dplyr)
#' 
#' # Calculates the all categorical variables
#' all_var <- univar_category(heartfailure)
#' 
#' # Print univar_category class object
#' all_var
#' 
#' # Calculates the only smoking variable
#' all_var %>% 
#'   "["(names(all_var) %in% "smoking")
#' 
#' smoking <- univar_category(heartfailure, smoking)
#' 
#' # Print univar_category class object
#' smoking
#' 
#' # Filtering the case of smoking included NA 
#' smoking %>%
#'   "[["(1) %>% 
#'   filter(!is.na(smoking))
#' 
#' # Summary the all case : Return a invisible copy of an object.
#' stat <- summary(all_var)
#' 
#' # Summary by returned object
#' stat
#' 
#' @name summary.univar_category
#' @usage 
#' ## S3 method for class 'univar_category'
#' summary(object, na.rm = TRUE, ...)
#' 
NULL


#' Summarizing univar_numeric information
#'
#' @description print and summary method for "univar_numeric" class.
#' @param object an object of class "univar_numeric", usually, a result of a call to univar_numeric().
#' @param stand character Describe how to standardize the original data. 
#' "robust" normalizes the raw data through transformation calculated by IQR and median.
#' "minmax" normalizes the original data using minmax transformation.
#' "zscore" standardizes the original data using z-Score transformation.
#' The default is "robust".
#' @param ... further arguments passed to or from other methods.
#' @details
#' print.univar_numeric() displays only the information of variables included in univar_numeric 
#' The "variables" attribute is not displayed.
#'
#' @return An object of the class as indivisual variabes based list.
#' The statistics returned by summary.univar_numeric() are different from the statistics returned by univar_numeric().
#' univar_numeric() is the statistics for the original data, but summary. univar_numeric() is the statistics for the standardized data.
#' A component named "statistics" is a tibble object with the following statistics.:
#' \itemize{
#' \item variable : factor. The level of the variable. 'variable' is the name of the variable.
#' \item n : number of observations excluding missing values
#' \item na : number of missing values
#' \item mean : arithmetic average
#' \item sd : standard deviation
#' \item se_mean : standard error mean. sd/sqrt(n)
#' \item IQR : interquartile range (Q3-Q1)
#' \item skewness : skewness
#' \item kurtosis : kurtosis
#' \item median : median. 50\% percentile
#' }
#' 
#' @seealso \code{\link{plot.univar_numeric}}.
#' @examples
#' # Calculates the all categorical variables
#' all_var <- univar_numeric(heartfailure)
#' 
#' # Print univar_numeric class object
#' all_var
#' 
#' # Calculates the platelets, sodium variable
#' univar_numeric(heartfailure, platelets, sodium)
#' 
#' # Summary the all case : Return a invisible copy of an object.
#' stat <- summary(all_var)
#' 
#' # Summary by returned object
#' stat
#' 
#' # Statistics of numerical variables normalized by Min-Max method
#' summary(all_var, stand = "minmax")
#' 
#' # Statistics of numerical variables standardized by Z-score method
#' summary(all_var, stand = "zscore")
#' 
#' @name summary.univar_numeric
#' @usage 
#' ## S3 method for class 'univar_numeric'
#' summary(object, stand = c("robust", "minmax", "zscore"), ...)
#' 
NULL


#' @param x an object of class "univar_category", usually, a result of a call to univar_category().
#' @param ... further arguments passed to or from other methods.
#' @rdname summary.univar_category
#' @name print.univar_category
#' @usage 
#' ## S3 method for class 'univar_category'
#' print(x, ...)
#' 
NULL


#' @param x an object of class "univar_numeric", usually, a result of a call to univar_numeric().
#' @param ... further arguments passed to or from other methods.
#' @rdname summary.univar_numeric
#' @name print.univar_numeric
#' @usage 
#' ## S3 method for class 'univar_numeric'
#' print(x, ...)
#' 
NULL



#' Visualize Information for an "univar_category" Object
#'
#' @description
#' Visualize mosaics plot by attribute of univar_category class.
#'
#' @param x an object of class "univar_category", usually, a result of a call to univar_category().
#' @param prompt logical. The default value is FALSE. If there are multiple visualizations to be output, 
#' if this argument value is TRUE, a prompt is output each time. 
#' @param na.rm logical. Specifies whether to include NA when plotting bar plot. 
#' The default is FALSE, so plot NA.  
#' @param typographic logical. Whether to apply focuses on typographic elements to ggplot2 visualization. 
#' The default is TRUE. if TRUE provides a base theme that focuses on typographic elements using hrbrthemes package.
#' @param ... arguments to be passed to methods, such as graphical parameters (see par).
#' However, it does not support all parameters.
#' @seealso \code{\link{univar_category}}, \code{\link{print.univar_category}}, \code{\link{summary.univar_category}}.
#' @examples
#' library(dplyr)
#' 
#' # Calculates the all categorical variables
#' all_var <- univar_category(heartfailure)
#' 
#' # Print univar_category class object
#' all_var
#' 
#' smoking <- univar_category(heartfailure, smoking)
#' 
#' # Print univar_category class object
#' smoking
#' 
#' # plot all variables
#' plot(all_var)
#' 
#' # plot smoking
#' plot(smoking)
#' 
#' @name plot.univar_category
#' @usage 
#' ## S3 method for class 'univar_category'
#' plot(x, na.rm = TRUE, prompt = FALSE, typographic = TRUE, ...)
#' 
NULL


#' Visualize Information for an "univar_numeric" Object
#'
#' @description
#' Visualize boxplots and histogram by attribute of univar_numeric class.
#'
#' @param x an object of class "univar_numeric", usually, a result of a call to univar_numeric().
#' @param indiv logical. Select whether to display information of all variables in one plot when there are multiple selected numeric variables. 
#' In case of FALSE, all variable information is displayed in one plot. 
#' If TRUE, the information of the individual variables is output to the individual plots. 
#' The default is FALSE. If only one variable is selected, TRUE is applied.
#' @param viz character. Describe what to plot visualization. "hist" draws a histogram and "boxplot" draws a boxplot. The default is "hist".
#' @param stand character. Describe how to standardize the original data. 
#' "robust" normalizes the raw data through transformation calculated by IQR and median.
#' "minmax" normalizes the original data using minmax transformation.
#' "zscore" standardizes the original data using z-Score transformation.
#' "none" does not perform data transformation.
#' he default is "none" if indiv is TRUE, and "robust" if FALSE.
#' @param prompt logical. The default value is FALSE. If there are multiple visualizations to be output, 
#' if this argument value is TRUE, a prompt is output each time. 
#' @param typographic logical. Whether to apply focuses on typographic elements to ggplot2 visualization. 
#' The default is TRUE. if TRUE provides a base theme that focuses on typographic elements using hrbrthemes package. 
#' @param ... arguments to be passed to methods, such as graphical parameters (see par).
#' However, it does not support.
#' @seealso \code{\link{univar_numeric}}, \code{\link{print.univar_numeric}}, \code{\link{summary.univar_numeric}}.
#' @examples
#' # Calculates the all categorical variables
#' all_var <- univar_numeric(heartfailure)
#' 
#' # Print univar_numeric class object
#' all_var
#' 
#' # Calculates the platelets, sodium variable
#' univar_numeric(heartfailure, platelets, sodium)
#' 
#' # Summary the all case : Return a invisible copy of an object.
#' stat <- summary(all_var)
#' 
#' # Summary by returned object
#' stat
#' 
#' # one plot with all variables
#' plot(all_var)
#' 
#' # one plot with all normalized variables by Min-Max method
#' # plot(all_var, stand = "minmax")
#' 
#' # one plot with all variables
#' # plot(all_var, stand = "none")
#' 
#' # one plot with all robust standardized variables 
#' plot(all_var, viz = "boxplot")
#' 
#' # one plot with all standardized variables by Z-score method 
#' # plot(all_var, viz = "boxplot", stand = "zscore")
#' 
#' # individual boxplot by variables
#' # plot(all_var, indiv = TRUE, "boxplot")
#' 
#' # individual histogram by variables
#' plot(all_var, indiv = TRUE, "hist")
#' 
#' # individual histogram by robust standardized variable 
#' # plot(all_var, indiv = TRUE, "hist", stand = "robust")
#' 
#' # plot all variables by prompt
#' # plot(all_var, indiv = TRUE, "hist", prompt = TRUE)
#' 
#' @name plot.univar_numeric
#' @usage 
#' ## S3 method for class 'univar_numeric'
#' plot(
#'   x,
#'   indiv = FALSE,
#'   viz = c("hist", "boxplot"),
#'   stand = ifelse(rep(indiv, 4), c("none", "robust", "minmax", "zscore"), 
#'     c("robust", "minmax", "zscore", "none")),
#'   prompt = FALSE,
#'   typographic = TRUE,
#'   ...
#' )
#' 
NULL
