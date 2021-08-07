#' Data Transformations
#'
#' @description
#' Performs variable transformation for standardization and resolving skewness
#' of numerical variables.
#'
#' @details
#' transform() creates an transform class.
#' The `transform` class includes original data, transformed data,
#' and method of transformation.
#'
#' See vignette("transformation") for an introduction to these concepts.
#'
#' @param x numeric vector for transformation.
#' @param method method of transformations.
#' @return An object of transform class.
#' Attributes of transform class is as follows.
#' \itemize{
#'   \item method : method of transformation data.
#'   \itemize{
#'     \item Standardization
#'       \itemize{
#'         \item "zscore" : z-score transformation. (x - mu) / sigma
#'         \item "minmax" : minmax transformation. (x - min) / (max - min)
#'       }
#'     \item Resolving Skewness
#'     \itemize{
#'       \item "log" : log transformation. log(x)
#'       \item "log+1" : log transformation. log(x + 1). Used for values that contain 0.
#'       \item "sqrt" : square root transformation.
#'       \item "1/x" : 1 / x transformation
#'       \item "x^2" : x square transformation
#'       \item "x^3" : x^3 square transformation
#'       \item "Box-Cox" : Box-Box transformation
#'       \item "Yeo-Johnson" : Yeo-Johnson transformation
#'     }
#'   }
#' }
#' @seealso \code{\link{summary.transform}}, \code{\link{plot.transform}}.
#' @examples
#' # Standardization ------------------------------
#' creatinine_minmax <- transform(heartfailure$creatinine, method = "minmax")
#' creatinine_minmax
#' summary(creatinine_minmax)
#' plot(creatinine_minmax)
#'
#' # Resolving Skewness  --------------------------
#' creatinine_log <- transform(heartfailure$creatinine, method = "log")
#' creatinine_log
#' summary(creatinine_log)
#' 
#' # plot(creatinine_log)
#'
#' # plot(creatinine_log, typographic = FALSE)
#' 
#' # Using dplyr ----------------------------------
#' library(dplyr)
#'
#' heartfailure %>%
#'   mutate(creatinine_log = transform(creatinine, method = "log+1")) %>%
#'   lm(sodium ~ creatinine_log, data = .)
#'   
#' @name transform
#' @usage 
#' transform(
#'   x,
#'   method = c("zscore", "minmax", "log", "log+1", "sqrt", "1/x", "x^2", "x^3",
#'     "Box-Cox", "Yeo-Johnson")
#' )
#' 
NULL


#' Summarizing transformation information
#'
#' @description print and summary method for "transform" class.
#' @param object an object of class "transform", usually, a result of a call to transform().
#' @param ... further arguments passed to or from other methods.
#' @details
#' summary.transform compares the distribution of data before and after data transformation.
#'
#' @seealso \code{\link{transform}}, \code{\link{plot.transform}}.
#' @examples
#' # Standardization ------------------------------
#' creatinine_minmax <- transform(heartfailure$creatinine, method = "minmax")
#' creatinine_minmax
#' summary(creatinine_minmax)
#' 
#' # plot(creatinine_minmax)
#'
#' # Resolving Skewness  --------------------------
#' creatinine_log <- transform(heartfailure$creatinine, method = "log")
#' creatinine_log
#' summary(creatinine_log)
#' 
#' # plot(creatinine_log)
#' 
#' # plot(creatinine_log, typographic = FALSE)
#' 
#' @name summary.transform
#' @usage 
#' ## S3 method for class 'transform'
#' summary(object, ...)
#' 
NULL


#' Visualize Information for an "transform" Object
#'
#' @description
#' Visualize two kinds of plot by attribute of `transform` class.
#' The transformation of a numerical variable is a density plot.
#'
#' @param x an object of class "transform", usually, a result of a call to transform().
#' @param typographic logical. Whether to apply focuses on typographic elements to ggplot2 visualization. 
#' The default is TRUE. if TRUE provides a base theme that focuses on typographic elements using hrbrthemes package.
#' @param ... arguments to be passed to methods, such as graphical parameters (see par).
#' @seealso \code{\link{transform}}, \code{\link{summary.transform}}.
#' @examples
#' # Standardization ------------------------------
#' creatinine_minmax <- transform(heartfailure$creatinine, method = "minmax")
#' creatinine_minmax
#' summary(creatinine_minmax)
#' 
#' plot(creatinine_minmax)
#'
#' # Resolving Skewness  --------------------------
#' creatinine_log <- transform(heartfailure$creatinine, method = "log")
#' creatinine_log
#' summary(creatinine_log)
#' 
#' plot(creatinine_log)
#' 
#' plot(creatinine_log, typographic = FALSE)
#' 
#' @name plot.transform
#' @usage 
#' ## S3 method for class 'transform'
#' plot(x, typographic = TRUE, ...)
#' 
NULL


#' Reporting the information of transformation
#'
#' @description The transformation_report() report the information of transform
#' numerical variables for object inheriting from data.frame.
#'
#' @details Generate transformation reports automatically.
#' You can choose to output to pdf and html files.
#' This is useful for Binning a data frame with a large number of variables
#' than data with a small number of variables.
#' For pdf output, Korean Gothic font must be installed in Korean operating system.
#' 
#' @section Reported information:
#' The transformation process will report the following information:
#'
#' \itemize{
#'   \item Imputation
#'   \itemize{
#'     \item Missing Values
#'     \itemize{
#'       \item * Variable names including missing value
#'     }
#'     \item Outliers
#'     \itemize{
#'       \item * Variable names including outliers
#'     }
#'   }
#'   \item Resolving Skewness
#'   \itemize{
#'     \item Skewed variables information
#'     \itemize{
#'       \item * Variable names with an absolute value of skewness greater than or equal to 0.5
#'     }
#'   }
#'   \item Binning
#'   \itemize{
#'     \item Numerical Variables for Binning
#'     \item Binning
#'     \itemize{
#'       \item Numeric variable names
#'     }
#'     \item Optimal Binning
#'     \itemize{
#'       \item Numeric variable names
#'     }
#'   }
#' }
#'
#' See vignette("transformation") for an introduction to these concepts.
#'
#' @param .data a data.frame or a \code{\link{tbl_df}}.
#' @param target target variable. If the target variable is not specified,
#' the method of using the target variable information is not performed when
#' the missing value is imputed. and Optimal binning is not performed if the
#' target variable is not a binary class.
#' @param output_format report output type. Choose either "pdf" and "html".
#' "pdf" create pdf file by knitr::knit().
#' "html" create html file by rmarkdown::render().
#' @param output_file name of generated file. default is NULL.
#' @param output_dir name of directory to generate report file. default is tempdir().
#' @param font_family character. font family name for figure in pdf.
#' @param browse logical. choose whether to output the report results to the browser.
#'
#' @examples
#' \dontrun{
#' # reporting the Binning information -------------------------
#' # create pdf file. file name is Transformation_Report.pdf & No target variable
#' transformation_report(heartfailure)
#' 
#' # create pdf file. file name is Transformation_Report.pdf
#' transformation_report(heartfailure, death_event)
#' 
#' # create pdf file. file name is Transformation_heartfailure.pdf
#' transformation_report(heartfailure, "death_event", 
#'                       output_file = "Transformation_heartfailure.pdf")
#' 
#' # create html file. file name is Transformation_Report.html
#' transformation_report(heartfailure, "death_event", output_format = "html")
#' 
#' # create html file. file name is Transformation_heartfailure.html
#' transformation_report(heartfailure, death_event, output_format = "html", 
#'                       output_file = "Transformation_heartfailure.html")
#' }
#'
#' @name transformation_report
#' @usage 
#' transformation_report(
#'   .data,
#'   target = NULL,
#'   output_format = c("pdf", "html"),
#'   output_file = NULL,
#'   output_dir = tempdir(),
#'   font_family = NULL,
#'   browse = TRUE
#' )
#' 
NULL
