#' @rdname correlate.data.frame
#' @name correlate
#' @usage correlate(.data, ...)
NULL


#' @rdname plot_correlate.data.frame
#' @name plot_correlate
#' @usage plot_correlate(.data, ...)
NULL


#' Compute the correlation coefficient between two numerical data
#'
#' @description The correlate() compute Pearson's the correlation
#' coefficient of the numerical data.
#'
#' @details This function is useful when used with the group_by() function of the dplyr package.
#' If you want to compute by level of the categorical data you are interested in,
#' rather than the whole observation, you can use \code{\link{grouped_df}} as the group_by() function.
#' This function is computed stats::cor() function by use = "pairwise.complete.obs" option.
#'
#' @section Correlation coefficient information:
#' The information derived from the numerical data compute is as follows.
#'
#' \itemize{
#' \item var1 : names of numerical variable
#' \item var2 : name of the corresponding numeric variable
#' \item coef_corr : Pearson's correlation coefficient
#' }
#'
#' @param .data a data.frame or a \code{\link{tbl_df}}.
#' @param method a character string indicating which correlation coefficient (or covariance) is 
#' to be computed. One of "pearson" (default), "kendall", or "spearman": can be abbreviated.
#' @param ... one or more unquoted expressions separated by commas.
#' You can treat variable names like they are positions.
#' Positive values select variables; negative values to drop variables.
#' If the first expression is negative, correlate() will automatically start with all variables.
#' These arguments are automatically quoted and evaluated in a context where column names
#' represent column positions.
#' They support unquoting and splicing.
#'
#' See vignette("EDA") for an introduction to these concepts.
#'
#' @seealso \code{\link{cor}}, \code{\link{correlate.tbl_dbi}}.
#' @examples
#' # Correlation coefficients of all numerical variables
#' correlate(heartfailure)
#'
#' # Select the variable to compute
#' correlate(heartfailure, creatinine, sodium)
#' correlate(heartfailure, -creatinine, -sodium)
#' correlate(heartfailure, "creatinine", "sodium")
#' correlate(heartfailure, 1)
#' # Non-parametric correlation coefficient by kendall method
#' correlate(heartfailure, creatinine, method = "kendall")
#'  
#' # Using dplyr::grouped_dt
#' library(dplyr)
#'
#' gdata <- group_by(heartfailure, smoking, death_event)
#' correlate(gdata, "creatinine")
#' correlate(gdata)
#'
#' # Using pipes ---------------------------------
#' # Correlation coefficients of all numerical variables
#' heartfailure %>%
#'   correlate()
#' # Positive values select variables
#' heartfailure %>%
#'   correlate(creatinine, sodium)
#' # Negative values to drop variables
#' heartfailure %>%
#'   correlate(-creatinine, -sodium)
#' # Positions values select variables
#' heartfailure %>%
#'   correlate(1)
#' # Positions values select variables
#' heartfailure %>%
#'   correlate(-1, -3, -5, -7)
#' # Non-parametric correlation coefficient by spearman method
#' heartfailure %>%
#'   correlate(creatinine, sodium, method = "spearman")
#'  
#' # ---------------------------------------------
#' # Correlation coefficient
#' # that eliminates redundant combination of variables
#' heartfailure %>%
#'   correlate() %>%
#'   filter(as.integer(var1) > as.integer(var2))
#'
#' heartfailure %>%
#'   correlate(creatinine, sodium) %>%
#'   filter(as.integer(var1) > as.integer(var2))
#'
#' # Using pipes & dplyr -------------------------
#' # Compute the correlation coefficient of Sales variable by 'smoking'
#' # and 'death_event' variables. And extract only those with absolute
#' # value of correlation coefficient is greater than 0.2
#' heartfailure %>%
#'   group_by(smoking, death_event) %>%
#'   correlate(creatinine) %>%
#'   filter(abs(coef_corr) >= 0.2)
#'
#' # extract only those with 'smoking' variable level is "Yes",
#' # and compute the correlation coefficient of 'Sales' variable
#' # by 'hblood_pressure' and 'death_event' variables.
#' # And the correlation coefficient is negative and smaller than 0.5
#' heartfailure %>%
#'   filter(smoking == "Yes") %>%
#'   group_by(hblood_pressure, death_event) %>%
#'   correlate(creatinine) %>%
#'   filter(coef_corr < 0) %>%
#'   filter(abs(coef_corr) > 0.5)
#'   
#' @name correlate.data.frame
#' @usage 
#' ## S3 method for class 'data.frame'
#' correlate(.data, ..., method = c("pearson", "kendall", "spearman"))
#' 
NULL


#' @rdname correlate.data.frame
#' @name correlate.grouped_df
#' @usage 
#' ## S3 method for class 'grouped_df'
#' correlate(.data, ..., method = c("pearson", "kendall", "spearman"))
#' 
NULL


#' Visualize correlation plot of numerical data
#'
#' @description The plot_correlate() visualize correlation plot
#' for find relationship between two numerical variables.
#'
#' @details The scope of the visualization is the provide a correlation information.
#' Since the plot is drawn for each variable, if you specify more than
#' one variable in the ... argument, the specified number of plots are drawn.
#'
#' @param .data a data.frame or a \code{\link{tbl_df}}.
#' @param method a character string indicating which correlation coefficient (or covariance) is 
#' to be computed. One of "pearson" (default), "kendall", or "spearman": can be abbreviated.
#' @param ... one or more unquoted expressions separated by commas.
#' You can treat variable names like they are positions.
#' Positive values select variables; negative values to drop variables.
#' If the first expression is negative, plot_correlate() will automatically start with all variables.
#' These arguments are automatically quoted and evaluated in a context where column names
#' represent column positions.
#' They support unquoting and splicing.
#'
#' See vignette("EDA") for an introduction to these concepts.
#'
#' @seealso \code{\link{plot_correlate.tbl_dbi}}, \code{\link{plot_outlier.data.frame}}.
#' @examples
#' # Visualize correlation plot of all numerical variables
#' plot_correlate(heartfailure)
#'
#' # Select the variable to compute
#' plot_correlate(heartfailure, creatinine, sodium)
#' plot_correlate(heartfailure, -creatinine, -sodium)
#' plot_correlate(heartfailure, "creatinine", "sodium")
#' plot_correlate(heartfailure, 1)
#' plot_correlate(heartfailure, creatinine, sodium, method = "spearman")
#' 
#' # Using dplyr::grouped_dt
#' library(dplyr)
#'
#' gdata <- group_by(heartfailure, smoking, death_event)
#' plot_correlate(gdata, "creatinine")
#' plot_correlate(gdata)
#'
#' # Using pipes ---------------------------------
#' # Visualize correlation plot of all numerical variables
#' heartfailure %>%
#'   plot_correlate()
#' # Positive values select variables
#' heartfailure %>%
#'   plot_correlate(creatinine, sodium)
#' # Negative values to drop variables
#' heartfailure %>%
#'   plot_correlate(-creatinine, -sodium)
#' # Positions values select variables
#' heartfailure %>%
#'   plot_correlate(1)
#' # Positions values select variables
#' heartfailure %>%
#'   plot_correlate(-1, -3, -5, -7)
#'
#' # Using pipes & dplyr -------------------------
#' # Visualize correlation plot of 'creatinine' variable by 'smoking'
#' # and 'death_event' variables.
#' heartfailure %>%
#' group_by(smoking, death_event) %>%
#' plot_correlate(creatinine)
#'
#' # Extract only those with 'smoking' variable level is "Yes",
#' # and visualize correlation plot of 'creatinine' variable by 'hblood_pressure'
#' # and 'death_event' variables.
#' heartfailure %>%
#'  filter(smoking == "Yes") %>%
#'  group_by(hblood_pressure, death_event) %>%
#'  plot_correlate(creatinine)
#'  
#' @name plot_correlate.data.frame
#' @usage 
#' ## S3 method for class 'data.frame'
#' plot_correlate(.data, ..., method = c("pearson", "kendall", "spearman"))
#' 
NULL


#' @rdname plot_correlate.data.frame
#' @name plot_correlate.grouped_df
#' @usage 
#' ## S3 method for class 'grouped_df'
#' plot_correlate(.data, ..., method = c("pearson", "kendall", "spearman"))
#' 
NULL


