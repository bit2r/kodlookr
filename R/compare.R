#' @rdname compare_category.data.frame
#' @name compare_category.data.frame
#' @usage compare_category(.data, ...)
NULL


#' @rdname compare_numeric.data.frame
#' @name compare_numeric.data.frame
#' @usage compare_numeric(.data, ...)
NULL


#' Compare categorical variables
#'
#' @description The compare_category() compute information to examine the relationship 
#' between categorical variables.
#'
#' @details 
#' It is important to understand the relationship between categorical variables in EDA.
#' compare_category() compares relations by pair combination of all categorical variables. 
#' and return compare_category class that based list object.
#'
#' @return An object of the class as compare based list.
#' The information to examine the relationship between categorical variables is as follows each components.
#'
#' \itemize{
#' \item var1 : factor. The level of the first variable to compare. 'var1' is the name of the first variable to be compared.
#' \item var2 : factor. The level of the second variable to compare. 'var2' is the name of the second variable to be compared.
#' \item n : integer. frequency by var1 and var2.
#' \item rate : double. relative frequency.
#' \item first_rate : double. relative frequency in first variable.
#' \item second_rate : double. relative frequency in second variable.
#' }
#'
#' @section Attributes of return object:
#' Attributes of compare_category class is as follows.
#' \itemize{
#' \item variables : character. List of variables selected for comparison.
#' \item combination : matrix. It consists of pairs of variables to compare.
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
#' @seealso \code{\link{summary.compare_category}}, \code{\link{print.compare_category}}, \code{\link{plot.compare_category}}.
#' @examples
#' # Generate data for the example
#' heartfailure2 <- heartfailure
#' heartfailure2[sample(seq(NROW(heartfailure2)), 5), "smoking"] <- NA
#' 
#' library(dplyr)
#' 
#' # Compare the all categorical variables
#' all_var <- compare_category(heartfailure2)
#' 
#' # Print compare_numeric class objects
#' all_var
#' 
#' # Compare the categorical variables that case of joint the death_event variable
#' all_var %>% 
#'   "["(grep("death_event", names(all_var)))
#' 
#' # Compare the two categorical variables
#' two_var <- compare_category(heartfailure2, smoking, death_event)
#' 
#' # Print compare_category class objects
#' two_var
#' 
#' # Filtering the case of smoking included NA 
#' two_var %>%
#'   "[["(1) %>% 
#'   filter(!is.na(smoking))
#' 
#' # Summary the all case : Return a invisible copy of an object.
#' stat <- summary(all_var)
#' 
#' # Summary by returned objects
#' stat
#' 
#' # component of table 
#' stat$table
#' 
#' # component of chi-square test 
#' stat$chisq
#' 
#' # component of chi-square test 
#' summary(all_var, "chisq")
#' 
#' # component of chi-square test (first, third case)
#' summary(all_var, "chisq", pos = c(1, 3))
#' 
#' # component of relative frequency table 
#' summary(all_var, "relative")
#' 
#' # component of table without missing values 
#' summary(all_var, "table", na.rm = TRUE)
#' 
#' # component of table include marginal value 
#' margin <- summary(all_var, "table", marginal = TRUE)
#' margin
#' 
#' # component of chi-square test 
#' summary(two_var, method = "chisq")
#' 
#' # verbose is FALSE 
#' summary(all_var, "chisq", verbose = FALSE)
#' 
#' #' # Using pipes & dplyr -------------------------
#' # If you want to use dplyr, set verbose to FALSE
#' summary(all_var, "chisq", verbose = FALSE) %>% 
#'   filter(p.value < 0.26)
#' 
#' # Extract component from list by index
#' summary(all_var, "table", na.rm = TRUE, verbose = FALSE) %>% 
#'   "[["(1)
#' 
#' # Extract component from list by name
#' summary(all_var, "table", na.rm = TRUE, verbose = FALSE) %>% 
#'   "[["("smoking vs death_event")
#' 
#' # plot all pair of variables
#' plot(all_var)
#' 
#' # plot a pair of variables
#' plot(two_var)
#' 
#' # plot all pair of variables by prompt
#' plot(all_var, prompt = TRUE)
#' 
#' # plot a pair of variables
#' plot(two_var, las = 1)
#' 
#' @name compare_category.data.frame
#' @usage 
#' ## S3 method for class 'data.frame'
#' compare_category(.data, ...)
NULL


#' Compare numerical variables
#'
#' @description The compare_numeric() compute information to examine the relationship 
#' between numerical variables.
#'
#' @details 
#' It is important to understand the relationship between numerical variables in EDA.
#' compare_numeric() compares relations by pair combination of all numerical variables. 
#' and return compare_numeric class that based list object.
#'
#' @return An object of the class as compare based list.
#' The information to examine the relationship between numerical variables is as follows each components.
#' - correlation component : Pearson's correlation coefficient.
#' \itemize{
#' \item var1 : factor. The level of the first variable to compare. 'var1' is the name of the first variable to be compared.
#' \item var2 : factor. The level of the second variable to compare. 'var2' is the name of the second variable to be compared.
#' \item coef_corr : double. Pearson's correlation coefficient.
#' }
#' 
#' - linear component : linear model summaries
#' \itemize{
#' \item var1 : factor. The level of the first variable to compare. 'var1' is the name of the first variable to be compared.
#' \item var2 : factor.The level of the second variable to compare. 'var2' is the name of the second variable to be compared.
#' \item r.squared : double. The percent of variance explained by the model.
#' \item adj.r.squared : double. r.squared adjusted based on the degrees of freedom.
#' \item sigma : double. The square root of the estimated residual variance.
#' \item statistic : double. F-statistic.
#' \item p.value : double. p-value from the F test, describing whether the full regression is significant.
#' \item df : integer degrees of freedom.
#' \item logLik : double. the log-likelihood of data under the model.
#' \item AIC : double. the Akaike Information Criterion.
#' \item BIC : double. the Bayesian Information Criterion.
#' \item deviance : double. deviance.
#' \item df.residual : integer residual degrees of freedom.
#' }
#'
#' @section Attributes of return object:
#' Attributes of compare_numeric class is as follows.
#' \itemize{
#' \item raw : a data.frame or a \code{\link{tbl_df}}. Data containing variables to be compared. Save it for visualization with plot.compare_numeric().
#' \item variables : character. List of variables selected for comparison. 
#' \item combination : matrix. It consists of pairs of variables to compare.
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
#' @seealso \code{\link{correlate}}, \code{\link{summary.compare_numeric}}, \code{\link{print.compare_numeric}}, \code{\link{plot.compare_numeric}}.
#' @examples
#' # Generate data for the example
#' heartfailure2 <- heartfailure[, c("platelets", "creatinine", "sodium")]
#'
#' library(dplyr)
#' # Compare the all numerical variables
#' all_var <- compare_numeric(heartfailure2)
#' 
#' # Print compare_numeric class object
#' all_var
#' 
#' # Compare the correlation that case of joint the sodium variable
#' all_var %>% 
#'   "$"(correlation) %>% 
#'   filter(var1 == "sodium" | var2 == "sodium") %>% 
#'   arrange(desc(abs(coef_corr)))
#'   
#' # Compare the correlation that case of abs(coef_corr) > 0.1
#' all_var %>% 
#'   "$"(correlation) %>% 
#'   filter(abs(coef_corr) > 0.1)
#'   
#' # Compare the linear model that case of joint the sodium variable  
#' all_var %>% 
#'   "$"(linear) %>% 
#'   filter(var1 == "sodium" | var2 == "sodium") %>% 
#'   arrange(desc(r.squared))
#'   
#' # Compare the two numerical variables
#' two_var <- compare_numeric(heartfailure2, sodium, creatinine)
#' 
#' # Print compare_numeric class objects
#' two_var
#'   
#' # Summary the all case : Return a invisible copy of an object.
#' stat <- summary(all_var)
#' 
#' # Just correlation
#' summary(all_var, method = "correlation")
#' 
#' # Just correlation condition by r > 0.1
#' summary(all_var, method = "correlation", thres_corr = 0.1)
#' 
#' # linear model summaries condition by R^2 > 0.05
#' summary(all_var, thres_rs = 0.05)
#' 
#' # verbose is FALSE 
#' summary(all_var, verbose = FALSE)
#'   
#' # plot all pair of variables
#' plot(all_var)
#' 
#' # plot a pair of variables
#' plot(two_var)
#' 
#' # plot all pair of variables by prompt
#' plot(all_var, prompt = TRUE)
#' 
#' # plot a pair of variables not focuses on typographic elements
#' plot(two_var, typographic = FALSE)
#' 
#' @name compare_numeric.data.frame
#' @usage 
#' ## S3 method for class 'data.frame'
#' compare_numeric(.data, ...)
#' 
NULL


#' Summarizing compare_category information
#'
#' @description print and summary method for "compare_category" class.
#' @param object an object of class "compare_category", usually, a result of a call to compare_category().
#' @param method character. Specifies the type of information to be aggregated. "table" create contingency table, 
#' "relative" create relative contingency table, and "chisq" create information of chi-square test. 
#' and "all" aggregates all information. The default is "all"
#' @param pos integer. Specifies the pair of variables to be summarized by index. 
#' The default is NULL, which aggregates all variable pairs.
#' @param na.rm logical. Specifies whether to include NA when counting the contingency tables or performing a chi-square test. 
#' The default is TRUE, where NA is removed and aggregated.
#' @param marginal logical. Specifies whether to add marginal values to the contingency table.
#' The default value is FALSE, so no marginal value is added.
#' @param verbose logical. Specifies whether to output additional information during the calculation process.
#' The default is to output information as TRUE. In this case, the function returns the value with invisible(). 
#' If FALSE, the value is returned by return().
#' @param ... further arguments passed to or from other methods.
#' @details
#' print.compare_category() displays only the information compared between the variables included in compare_category. 
#' The "type", "variables" and "combination" attributes are not displayed.
#' When using summary.compare_category(), it is advantageous to set the verbose argument to TRUE if the user is only viewing information from the console. 
#' It is also advantageous to specify FALSE if you want to manipulate the results.
#'
#' @seealso \code{\link{plot.compare_category}}.
#' @examples
#' # Generate data for the example
#' heartfailure2 <- heartfailure
#' heartfailure2[sample(seq(NROW(heartfailure2)), 5), "smoking"] <- NA
#' 
#' library(dplyr)
#' 
#' # Compare the all categorical variables
#' all_var <- compare_category(heartfailure2)
#' 
#' # Print compare_category class objects
#' all_var
#' 
#' # Compare the two categorical variables
#' two_var <- compare_category(heartfailure2, smoking, death_event)
#' 
#' # Print compare_category class objects
#' two_var
#' 
#' # Summary the all case : Return a invisible copy of an object.
#' stat <- summary(all_var)
#' 
#' # Summary by returned objects
#' stat
#' 
#' # component of table 
#' stat$table
#' 
#' # component of chi-square test 
#' stat$chisq
#' 
#' # component of chi-square test 
#' summary(all_var, "chisq")
#' 
#' # component of chi-square test (first, third case)
#' summary(all_var, "chisq", pos = c(1, 3))
#' 
#' # component of relative frequency table 
#' summary(all_var, "relative")
#' 
#' # component of table without missing values 
#' summary(all_var, "table", na.rm = TRUE)
#' 
#' # component of table include marginal value 
#' margin <- summary(all_var, "table", marginal = TRUE)
#' margin
#' 
#' # component of chi-square test 
#' summary(two_var, method = "chisq")
#' 
#' # verbose is FALSE 
#' summary(all_var, "chisq", verbose = FALSE)
#' 
#' #' # Using pipes & dplyr -------------------------
#' # If you want to use dplyr, set verbose to FALSE
#' summary(all_var, "chisq", verbose = FALSE) %>% 
#'   filter(p.value < 0.26)
#' 
#' # Extract component from list by index
#' summary(all_var, "table", na.rm = TRUE, verbose = FALSE) %>% 
#'   "[["(1)
#' 
#' # Extract component from list by name
#' summary(all_var, "table", na.rm = TRUE, verbose = FALSE) %>% 
#'   "[["("smoking vs death_event")
#'   
#' @name summary.compare_category
#' @usage 
#' ## S3 method for class 'compare_category'
#' summary(
#'   object,
#'   method = c("all", "table", "relative", "chisq"),
#'   pos = NULL,
#'   na.rm = TRUE,
#'   marginal = FALSE,
#'   verbose = TRUE,
#'   ...
#' )
#' 
NULL


#' Summarizing compare_numeric information
#'
#' @description print and summary method for "compare_numeric" class.
#' @param object an object of class "compare_numeric", usually, a result of a call to compare_numeric().
#' @param method character. Select statistics to be aggregated. 
#' "correlation" calculates the Pearson's correlation coefficient, and "linear" returns the aggregation of the linear model.
#' "all" returns both information. 
#' However, the difference between summary.compare_numeric() and compare_numeric() is that only cases that are greater than the specified threshold are returned.
#' "correlation" returns only cases with a correlation coefficient greater than the thres_corr argument value. 
#' "linear" returns only cases with R^2 greater than the thres_rs argument.
#' @param thres_corr numeric. This is the correlation coefficient threshold of the correlation coefficient information to be returned. 
#' The default is 0.3.
#' @param thres_rs numeric. R^2 threshold of linear model summaries information to return. 
#' The default is 0.1.
#' @param verbose logical. Specifies whether to output additional information during the calculation process.
#' The default is to output information as TRUE. In this case, the function returns the value with invisible(). 
#' If FALSE, the value is returned by return().
#' @param ... further arguments passed to or from other methods.
#' @details
#' print.compare_numeric() displays only the information compared between the variables included in compare_numeric. 
#' When using summary.compare_numeric(), it is advantageous to set the verbose argument to TRUE if the user is only viewing information from the console. 
#' It is also advantageous to specify FALSE if you want to manipulate the results.
#'
#' @return An object of the class as compare based list.
#' The information to examine the relationship between numerical variables is as follows each components.
#' - correlation component : Pearson's correlation coefficient.
#' \itemize{
#' \item var1 : factor. The level of the first variable to compare. 'var1' is the name of the first variable to be compared.
#' \item var2 : factor. The level of the second variable to compare. 'var2' is the name of the second variable to be compared.
#' \item coef_corr : double. Pearson's correlation coefficient.
#' }
#' 
#' - linear component : linear model summaries
#' \itemize{
#' \item var1 : factor. The level of the first variable to compare. 'var1' is the name of the first variable to be compared.
#' \item var2 : factor. The level of the second variable to compare. 'var2' is the name of the second variable to be compared.
#' \item r.squared : double. The percent of variance explained by the model.
#' \item adj.r.squared : double. r.squared adjusted based on the degrees of freedom.
#' \item sigma : double. The square root of the estimated residual variance.
#' \item statistic : double. F-statistic.
#' \item p.value : double. p-value from the F test, describing whether the full regression is significant.
#' \item df : integer degrees of freedom.
#' \item logLik : double. the log-likelihood of data under the model.
#' \item AIC : double. the Akaike Information Criterion.
#' \item BIC : double. the Bayesian Information Criterion.
#' \item deviance : double. deviance.
#' \item df.residual : integer residual degrees of freedom.
#' }
#' 
#' @seealso \code{\link{plot.compare_numeric}}.
#' @examples
#' # Generate data for the example
#' heartfailure2 <- heartfailure[, c("platelets", "creatinine", "sodium")]
#'
#' library(dplyr)
#' # Compare the all numerical variables
#' all_var <- compare_numeric(heartfailure2)
#' 
#' # Print compare_numeric class object
#' all_var
#' 
#' # Compare the correlation that case of joint the sodium variable
#' all_var %>% 
#'   "$"(correlation) %>% 
#'   filter(var1 == "sodium" | var2 == "sodium") %>% 
#'   arrange(desc(abs(coef_corr)))
#'   
#' # Compare the correlation that case of abs(coef_corr) > 0.1
#' all_var %>% 
#'   "$"(correlation) %>% 
#'   filter(abs(coef_corr) > 0.1)
#'   
#' # Compare the linear model that case of joint the sodium variable  
#' all_var %>% 
#'   "$"(linear) %>% 
#'   filter(var1 == "sodium" | var2 == "sodium") %>% 
#'   arrange(desc(r.squared))
#'   
#' # Compare the two numerical variables
#' two_var <- compare_numeric(heartfailure2, sodium, creatinine)
#' 
#' # Print compare_numeric class objects
#' two_var
#'   
#' # Summary the all case : Return a invisible copy of an object.
#' stat <- summary(all_var)
#' 
#' # Just correlation
#' summary(all_var, method = "correlation")
#' 
#' # Just correlation condition by r > 0.1
#' summary(all_var, method = "correlation", thres_corr = 0.1)
#' 
#' # linear model summaries condition by R^2 > 0.05
#' summary(all_var, thres_rs = 0.05)
#' 
#' # verbose is FALSE 
#' summary(all_var, verbose = FALSE)
#'   
#' @name summary.compare_numeric
#' @usage 
#' ## S3 method for class 'compare_numeric'
#' summary(
#'   object,
#'   method = c("all", "correlation", "linear"),
#'   thres_corr = 0.3,
#'   thres_rs = 0.1,
#'   verbose = TRUE,
#'   ...
#' )
#' 
NULL


#' @param x an object of class "compare_category", usually, a result of a call to compare_category().
#' @param ... further arguments passed to or from other methods.
#' @rdname summary.compare_category
#' @name print.compare_category
#' @usage 
#' ## S3 method for class 'compare_category'
#' print(x, ...)
#' 
NULL


#' @param x an object of class "compare_numeric", usually, a result of a call to compare_numeric().
#' @param ... further arguments passed to or from other methods.
#' @rdname summary.compare_numeric
#' @name print.compare_numeric
#' @usage 
#' ## S3 method for class 'compare_numeric'
#' print(x, ...)
#' 
NULL


#' Visualize Information for an "compare_category" Object
#'
#' @description
#' Visualize mosaics plot by attribute of compare_category class.
#'
#' @param x an object of class "compare_category", usually, a result of a call to compare_category().
#' @param prompt logical. The default value is FALSE. If there are multiple visualizations to be output, if this argument value is TRUE, a prompt is output each time. 
#' @param na.rm logical. Specifies whether to include NA when plotting mosaics plot. 
#' The default is FALSE, so plot NA.  
#' @param typographic logical. Whether to apply focuses on typographic elements to ggplot2 visualization. 
#' The default is TRUE. if TRUE provides a base theme that focuses on typographic elements using hrbrthemes package.
#' @param ... arguments to be passed to methods, such as graphical parameters (see par).
#' However, it only support las parameter. las is numeric in {0,1}; the style of axis labels.
#' \itemize{
#'   \item 0 : always parallel to the axis [default],
#'   \item 1 : always horizontal to the axis,
#' }
#'    
#' @seealso \code{\link{compare_category}}, \code{\link{print.compare_category}}, \code{\link{summary.compare_category}}.
#' @examples
#' # Generate data for the example
#' heartfailure2 <- heartfailure
#' heartfailure2[sample(seq(NROW(heartfailure2)), 5), "smoking"] <- NA
#' 
#' library(dplyr)
#' 
#' # Compare the all categorical variables
#' all_var <- compare_category(heartfailure2)
#' 
#' # Print compare_numeric class objects
#' all_var
#' 
#' # Compare the two categorical variables
#' two_var <- compare_category(heartfailure2, smoking, death_event)
#' 
#' # Print compare_category class objects
#' two_var
#' 
#' # plot all pair of variables
#' plot(all_var)
#' 
#' # plot a pair of variables
#' plot(two_var)
#'
#' # plot all pair of variables by prompt
#' plot(all_var, prompt = TRUE)
#'   
#' # plot a pair of variables without NA
#' plot(two_var, na.rm = TRUE)
#' 
#' # plot a pair of variables
#' plot(two_var, las = 1)
#' 
#' # plot a pair of variables not focuses on typographic elements
#' plot(two_var, typographic = FALSE)
#' 
#' @name plot.compare_category
#' @usage 
#' ## S3 method for class 'compare_category'
#' plot(x, prompt = FALSE, na.rm = FALSE, typographic = TRUE, ...)
#' 
NULL


#' Visualize Information for an "compare_numeric" Object
#'
#' @description
#' Visualize scatter plot included box plots by attribute of compare_numeric class.
#'
#' @param x an object of class "compare_numeric", usually, a result of a call to compare_numeric().
#' @param prompt logical. The default value is FALSE. If there are multiple visualizations to be output, 
#' if this argument value is TRUE, a prompt is output each time. 
#' @param typographic logical. Whether to apply focuses on typographic elements to ggplot2 visualization. 
#' The default is TRUE. if TRUE provides a base theme that focuses on typographic elements using hrbrthemes package.
#' @param ... arguments to be passed to methods, such as graphical parameters (see par).
#' However, it does not support.
#' @seealso \code{\link{compare_numeric}}, \code{\link{print.compare_numeric}}, \code{\link{summary.compare_numeric}}.
#' @examples
#' # Generate data for the example
#' heartfailure2 <- heartfailure[, c("platelets", "creatinine", "sodium")]
#'
#' library(dplyr)
#' # Compare the all numerical variables
#' all_var <- compare_numeric(heartfailure2)
#' 
#' # Print compare_numeric class object
#' all_var
#'   
#' # Compare the two numerical variables
#' two_var <- compare_numeric(heartfailure2, sodium, creatinine)
#' 
#' # Print compare_numeric class objects
#' two_var
#'   
#' # plot all pair of variables
#' plot(all_var)
#' 
#' # plot a pair of variables
#' plot(two_var)
#' 
#' # plot all pair of variables by prompt
#' plot(all_var, prompt = TRUE)
#' 
#' # plot a pair of variables not focuses on typographic elements
#' plot(two_var, typographic = FALSE)
#' 
#' @name plot.compare_numeric
#' @usage 
#' ## S3 method for class 'compare_numeric'
#' plot(x, prompt = FALSE, typographic = TRUE, ...)
#' 
NULL
