#' @rdname normality.data.frame
#' @name normality
#' @usage normality(.data, ...)
#' 
NULL


#' @rdname plot_normality.data.frame
#' @name plot_normality
#' @usage plot_normality(.data, ...)
#' 
NULL


#' Performs the Shapiro-Wilk test of normality
#'
#' @description The normality() performs Shapiro-Wilk test of normality of numerical values.
#'
#' @details This function is useful when used with the \code{\link{group_by}}
#' function of the dplyr package. If you want to test by level of the categorical
#' data you are interested in, rather than the whole observation,
#' you can use group_tf as the group_by function.
#' This function is computed \code{\link{shapiro.test}} function.
#'
#' @section Normality test information:
#' The information derived from the numerical data test is as follows.
#'
#' \itemize{
#' \item statistic : the value of the Shapiro-Wilk statistic.
#' \item p_value : an approximate p-value for the test. This is said in
#' Roystion(1995) to be adequate for p_value < 0.1.
#' \item sample : the number of samples to perform the test.
#' The number of observations supported by the stats::shapiro.test function is 3 to 5000.
#' }
#'
#' @param .data a data.frame or a \code{\link{tbl_df}}.
#' @param ... one or more unquoted expressions separated by commas.
#' You can treat variable names like they are positions.
#' Positive values select variables; negative values to drop variables.
#' If the first expression is negative, normality() will automatically start with all variables.
#' These arguments are automatically quoted and evaluated in a context where column names
#' represent column positions.
#' They support unquoting and splicing.
#' @param sample the number of samples to perform the test.
#'
#' See vignette("EDA") for an introduction to these concepts.
#'
#' @return An object of the same class as .data.
#' @seealso \code{\link{normality.tbl_dbi}}, \code{\link{diagnose_numeric.data.frame}}, 
#' \code{\link{describe.data.frame}}, \code{\link{plot_normality.data.frame}}.
#' @examples
#' \donttest{
#' # Normality test of numerical variables
#' normality(heartfailure)
#' 
#' # Select the variable to describe
#' normality(heartfailure, platelets, sodium)
#' normality(heartfailure, -platelets, -sodium)
#' normality(heartfailure, 1)
#' normality(heartfailure, platelets, sodium, sample = 200)
#' 
#' # death_eventing dplyr::grouped_dt
#' library(dplyr)
#' 
#' gdata <- group_by(heartfailure, smoking, death_event)
#' normality(gdata, "platelets")
#' normality(gdata, sample = 250)
#' 
#' # death_eventing pipes ---------------------------------
#' # Normality test of all numerical variables
#' heartfailure %>%
#'   normality()
#' 
#' # Positive values select variables
#' heartfailure %>%
#'   normality(platelets, sodium)
#' 
#' # Positions values select variables
#' heartfailure %>%
#'   normality(1)
#' 
#' # death_eventing pipes & dplyr -------------------------
#' # Test all numerical variables by 'smoking' and 'death_event',
#' # and extract only those with 'smoking' variable level is "No".
#' heartfailure %>%
#'   group_by(smoking, death_event) %>%
#'   normality() %>%
#'   filter(smoking == "No")
#' 
#' # extract only those with 'sex' variable level is "Male",
#' # and test 'platelets' by 'smoking' and 'death_event'
#' heartfailure %>%
#'   filter(sex == "Male") %>%
#'   group_by(smoking, death_event) %>%
#'   normality(platelets)
#' 
#' # Test log(platelets) variables by 'smoking' and 'death_event',
#' # and extract only p.value greater than 0.01.
#' heartfailure %>%
#'   mutate(platelets_income = log(platelets)) %>%
#'   group_by(smoking, death_event) %>%
#'   normality(platelets_income) %>%
#'   filter(p_value > 0.01)
#' }
#' 
#' @name normality.data.frame
#' @usage 
#' ## S3 method for class 'data.frame'
#' normality(.data, ..., sample = 5000)
#' 
NULL


#' @rdname normality.data.frame
#' @name normality.grouped_df
#' @usage 
#' ## S3 method for class 'grouped_df'
#' normality(.data, ..., sample = 5000)
#' 
NULL


#' Plot distribution information of numerical data
#'
#' @description The plot_normality() visualize distribution information
#' for normality test of the numerical data.
#'
#' @details The scope of the visualization is the provide a distribution information.
#' Since the plot is drawn for each variable, if you specify more than
#' one variable in the ... argument, the specified number of plots are drawn.
#'
#' The argument values that left and right can have are as follows.:
#' 
#' \itemize{
#'   \item "log" : log transformation. log(x)
#'   \item "log+1" : log transformation. log(x + 1). Used for values that contain 0.
#'   \item "log+a" : log transformation. log(x + 1 - min(x)). Used for values that contain 0.   
#'   \item "sqrt" : square root transformation.
#'   \item "1/x" : 1 / x transformation
#'   \item "x^2" : x square transformation
#'   \item "x^3" : x^3 square transformation
#'   \item "Box-Cox" : Box-Box transformation
#'   \item "Yeo-Johnson" : Yeo-Johnson transformation
#' }
#' 
#' @section Distribution information:
#' The plot derived from the numerical data visualization is as follows.
#'
#' \itemize{
#'   \item histogram by original data
#'   \item q-q plot by original data
#'   \item histogram by log transfer data
#'   \item histogram by square root transfer data
#' }
#'
#' @param .data a data.frame or a \code{\link{tbl_df}}.
#' @param ... one or more unquoted expressions separated by commas.
#' You can treat variable names like they are positions.
#' Positive values select variables; negative values to drop variables.
#' If the first expression is negative, plot_normality() will automatically
#' start with all variables.
#' These arguments are automatically quoted and evaluated in a context where column names
#' represent column positions.
#' They support unquoting and splicing.
#' 
#' See vignette("EDA") for an introduction to these concepts.
#' @param left character. Specifies the data transformation method to draw the histogram in the 
#' lower left corner. The default is "log".
#' @param right character. Specifies the data transformation method to draw the histogram in the 
#' lower right corner. The default is "sqrt".
#' @param col a color to be used to fill the bars. The default is "steelblue".
#' @param typographic logical. Whether to apply focuses on typographic elements to ggplot2 visualization. 
#' The default is TRUE. if TRUE provides a base theme that focuses on typographic elements using hrbrthemes package.
#' 
#' @seealso \code{\link{plot_normality.tbl_dbi}}, \code{\link{plot_outlier.data.frame}}.
#' @examples
#' \donttest{
#' # Visualization of all numerical variables
#' heartfailure2 <- heartfailure[, c("creatinine", "platelets", "sodium", "sex", "smoking")]
#' plot_normality(heartfailure2)
#'
#' # Select the variable to plot
#' plot_normality(heartfailure2, platelets, sodium)
#' plot_normality(heartfailure2, -platelets, -sodium, col = "gray")
#' plot_normality(heartfailure2, 1)
#'
#' # Change the method of transformation
#' plot_normality(heartfailure2, platelets, right = "1/x")
#' 
#' if (requireNamespace("forecast", quietly = TRUE)) {
#'   plot_normality(heartfailure2, platelets, left = "Box-Cox", right = "Yeo-Johnson")
#' } else {
#'   cat("If you want to use this feature, you need to install the rpart package.\n")
#' }
#' # Not allow typographic elements
#' plot_normality(heartfailure2, platelets, typographic = FALSE)
#' 
#' # Using dplyr::grouped_df
#' library(dplyr)
#'
#' gdata <- group_by(heartfailure2, sex, smoking)
#' plot_normality(gdata)
#' plot_normality(gdata, "creatinine")
#'
#' # Using pipes ---------------------------------
#' # Visualization of all numerical variables
#' heartfailure2 %>%
#'  plot_normality()
#'
#' # Positive values select variables
#' heartfailure2 %>%
#' plot_normality(platelets, sodium)
#'
#' # Positions values select variables
#' # heartfailure2 %>%
#' #  plot_normality(1)
#'
#' # Using pipes & dplyr -------------------------
#' # Plot 'creatinine' variable by 'sex' and 'smoking'
#' heartfailure2 %>%
#'  group_by(sex, smoking) %>%
#'  plot_normality(creatinine)
#'
#' # extract only those with 'sex' variable level is "Male",
#' # and plot 'platelets' by 'smoking'
#' if (requireNamespace("forecast", quietly = TRUE)) {
#'   heartfailure2 %>%
#'    filter(sex == "Male") %>%
#'    group_by(smoking) %>%
#'    plot_normality(platelets, right = "Box-Cox")
#' } else {
#'   cat("If you want to use this feature, you need to install the rpart package.\n")
#' }
#' }
#' @name plot_normality.data.frame
#' @usage 
#' ## S3 method for class 'data.frame'
#' plot_normality(
#'   .data,
#'   ...,
#'   left = c("log", "sqrt", "log+1", "log+a", "1/x", "x^2", "x^3", "Box-Cox",
#'     "Yeo-Johnson"),
#'   right = c("sqrt", "log", "log+1", "log+a", "1/x", "x^2", "x^3", "Box-Cox",
#'     "Yeo-Johnson"),
#'   col = "steelblue",
#'   typographic = TRUE
#' )
#' 
NULL

#' @rdname plot_normality.data.frame
#' @name plot_normality.grouped_df
#' @usage 
#' ## S3 method for class 'grouped_df'
#' plot_normality(
#'   .data,
#'   ...,
#'   left = c("log", "sqrt", "log+1", "log+a", "1/x", "x^2", "x^3", "Box-Cox",
#'     "Yeo-Johnson"),
#'   right = c("sqrt", "log", "log+1", "log+a", "1/x", "x^2", "x^3", "Box-Cox",
#'     "Yeo-Johnson"),
#'   col = "steelblue",
#'   typographic = TRUE
#' )
#' 
NULL


#' Transform a numeric vector
#'
#' @description The get_transform() gets transformation of numeric variable.
#'
#' @param x numeric. numeric for transform
#' @param method character. transformation method of numeric variable
#' @return numeric. transformed numeric vector.
#' 
#' @details The supported transformation method is follow.: 
#' \itemize{
#'   \item "log" : log transformation. log(x)
#'   \item "log+1" : log transformation. log(x + 1). Used for values that contain 0.
#'   \item "log+a" : log transformation. log(x + 1 - min(x)). Used for values that contain 0.   
#'   \item "sqrt" : square root transformation.
#'   \item "1/x" : 1 / x transformation
#'   \item "x^2" : x square transformation
#'   \item "x^3" : x^3 square transformation
#'   \item "Box-Cox" : Box-Box transformation
#'   \item "Yeo-Johnson" : Yeo-Johnson transformation
#' }
#' 
#' @seealso \code{\link{plot_normality}}.
#' @examples
#' \dontrun{
#' # log+a transform 
#' get_transform(iris$Sepal.Length, "log+a")
#'
#' if (requireNamespace("forecast", quietly = TRUE)) {
#'   # Box-Cox transform 
#'   get_transform(iris$Sepal.Length, "Box-Cox")
#' 
#'   # Yeo-Johnson transform 
#'   get_transform(iris$Sepal.Length, "Yeo-Johnson")
#' } else {
#'   cat("If you want to use this feature, you need to install the forecast package.\n")
#' }
#' }
#' 
#' @name get_transform
#' @usage 
#' get_transform(
#'   x,
#'   method = c("log", "sqrt", "log+1", "log+a", "1/x", "x^2", "x^3", "Box-Cox",
#'     "Yeo-Johnson")
#' )
#' 
NULL

