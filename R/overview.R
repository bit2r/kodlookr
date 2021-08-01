#' Describe overview of data
#'
#' @description
#' Inquire basic information to understand the data in general.
#'
#' @details
#' overview() creates an overview class.
#' The `overview` class includes general information such as the size of the data, the degree of missing values, 
#' and the data types of variables.
#'
#' @param .data a data.frame or a \code{\link{tbl_df}}.
#' @return An object of overview class. 
#' The overview class contains data.frame and two attributes. data.frame has the following 3 variables.:
#' data.frame is as follow.:
#' \itemize{
#'   \item division : division of information.
#'   \itemize{
#'     \item size : indicators of related to data capacity 
#'     \item duplicated : indicators of related to duplicated value 
#'     \item missing : indicators of related to missing value 
#'     \item data_type : indicators of related to data type 
#'   }
#'   \item metrics : name of metrics.
#'   \itemize{
#'     \item observations : number of observations (number of rows)
#'     \item variables : number of variables (number of columns)
#'     \item values : number of values (number of cells. rows * columns)
#'     \item memory size : an estimate of the memory that is being used to store an R object.
#'     \item duplicate observation: number of duplicate cases(observations).
#'     \item complete observation : number of complete cases(observations). i.e., have no missing values.
#'     \item missing observation : number of observations that has missing values.
#'     \item missing variables : number of variables that has missing values.
#'     \item missing values : number of values(cells) that has missing values.
#'     \item numerics : number of variables that is data type is numeric.
#'     \item integers : number of variables that is data type is integer.
#'     \item factors : number of variables that is data type is factor.
#'     \item characters : number of variables that is data type is character.
#'     \item Dates : number of variables that is data type is Date.
#'     \item POSIXcts : number of variables that is data type is POSIXct.
#'     \item others : number of variables that is not above.
#'   }
#'   \item value : value of metrics.
#' }
#' 
#' Attributes of overview class is as follows.:
#' \itemize{
#'   \item duplicated : the index of duplicated observations.
#'   \item na_col : the data type of predictor to replace missing value.
#'   \item info_class : data.frame. variable name and class name that describe the data type of variables.
#'   \itemize{
#'     \item data.frame has a two variables.
#'     \itemize{
#'       \item variable : variable names
#'       \item class : data type
#'     }
#'   }
#' }
#' @seealso \code{\link{summary.overview}}, \code{\link{plot.overview}}.
#' @examples
#' \donttest{
#' ov <- overview(jobchange)
#' ov
#' 
#' summary(ov)
#' 
#' # plot(ov)
#' }
#' 
#' @name overview
#' @usage overview(.data)
#' 
NULL


#' Summarizing overview information
#'
#' @description print and summary method for "overview" class.
#' @param object an object of class "overview", usually, a result of a call to overview().
#' @param html logical. whether to send summary results to html. The default is FALSE, 
#' which prints to the R console.
#' @param ... further arguments passed to or from other methods.
#' @details
#' summary.overview() tries to be smart about formatting 14 information of overview.
#' @seealso \code{\link{overview}}, \code{\link{plot.overview}}.
#' @examples
#' \donttest{
#' ov <- overview(jobchange)
#' ov
#' 
#' summary(ov)
#' }
#' 
#' @name summary.overview
#' @usage summary.overview(object, html = FALSE, ...)
#' 
NULL


#' Visualize Information for an "overview" Object
#'
#' @description
#' Visualize a plot by attribute of `overview` class.
#' Visualize the data type, number of observations, and number of missing values for each variable.
#'
#' @param x an object of class "overview", usually, a result of a call to overview().
#' @param order_type character. method of order of bars(variables).
#' @param ... further arguments to be passed from or to other methods.
#' @seealso \code{\link{overview}}, \code{\link{summary.overview}}.
#' @examples
#' \donttest{
#' ov <- overview(jobchange)
#' ov
#' 
#' summary(ov)
#' 
#' plot(ov)
#'
#' # sort by name of variables
#' plot(ov, order_type = "name")
#' 
#' # sort by data type of variables
#' plot(ov, order_type = "type")
#' }
#' 
#' @name plot.overview
#' @usage plot.overview(x, order_type = c("none", "name", "type"), ...)
#' 
NULL
