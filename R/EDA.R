#' @rdname eda_report.data.frame
#' @name eda_report
#' @usage eda_report(.data, ...)
#' 
NULL


#' Reporting the information of EDA
#'
#' @description The eda_report() report the information of exploratory
#' data analysis for object inheriting from data.frame.
#'
#' @details Generate generalized EDA report automatically.
#' You can choose to output as pdf and html files.
#' This feature is useful for EDA of data with many variables, rather than data with fewer variables.
#' For pdf output, Korean Gothic font must be installed in Korean operating system.
#' 
#' @section Reported information:
#' The EDA process will report the following information:
#'
#' \itemize{
#'   \item Introduction
#'   \itemize{
#'     \item Information of Dataset
#'     \item Information of Variables
#'     \item About EDA Report
#'   }
#'   \item Univariate Analysis
#'   \itemize{
#'     \item Descriptive Statistics
#'     \item Normality Test of Numerical Variables
#'     \itemize{
#'       \item Statistics and Visualization of (Sample) Data
#'     }
#'   }
#'   \item Relationship Between Variables
#'   \itemize{
#'     \item Correlation Coefficient
#'     \itemize{
#'       \item Correlation Coefficient by Variable Combination
#'       \item Correlation Plot of Numerical Variables
#'     }
#'   }
#'   \item Target based Analysis
#'   \itemize{
#'     \item Grouped Descriptive Statistics
#'     \itemize{
#'       \item Grouped Numerical Variables
#'       \item Grouped Categorical Variables
#'     }
#'     \item Grouped Relationship Between Variables
#'     \itemize{
#'       \item Grouped Correlation Coefficient
#'       \item Grouped Correlation Plot of Numerical Variables
#'     }
#'   }
#' }
#'
#' See vignette("EDA") for an introduction to these concepts.
#'
#' @param .data a data.frame or a \code{\link{tbl_df}}.
#' @param target target variable.
#' @param output_format character. report output type. Choose either "pdf" and "html".
#' "pdf" create pdf file by knitr::knit().
#' "html" create html file by rmarkdown::render().
#' @param output_file character. name of generated file. default is NULL.
#' @param output_dir character. name of directory to generate report file. default is tempdir().
#' @param font_family character. font family name for figure in pdf.
#' @param browse logical. choose whether to output the report results to the browser.
#' @param ... arguments to be passed to methods.
#' 
#' @examples
#' if (FALSE) {
#' library(dplyr)
#' 
#' ## target variable is categorical variable ----------------------------------
#' # reporting the EDA information
#' # create pdf file. file name is EDA_Report.pdf
#' eda_report(heartfailure, death_event)
#' 
#' # create pdf file. file name is EDA_heartfailure.pdf
#' eda_report(heartfailure, "death_event", output_file = "EDA_heartfailure.pdf")
#' 
#' # create pdf file. file name is EDA_heartfailure.pdf and not browse
#' eda_report(heartfailure, "death_event", output_dir = ".", 
#'     output_file = "EDA_heartfailure.pdf", browse = FALSE)
#' 
#' # create html file. file name is EDA_Report.html
#' eda_report(heartfailure, "death_event", output_format = "html")
#' 
#' # create html file. file name is EDA_heartfailure.html
#' eda_report(heartfailure, death_event, output_format = "html", 
#'    output_file = "EDA_heartfailure.html")
#'
#' ## target variable is numerical variable ------------------------------------
#' # reporting the EDA information
#' eda_report(heartfailure, sodium)
#' 
#' # create pdf file. file name is EDA2.pdf
#' eda_report(heartfailure, "sodium", output_file = "EDA2.pdf")
#' 
#' # create html file. file name is EDA_Report.html
#' eda_report(heartfailure, "sodium", output_format = "html")
#' 
#' # create html file. file name is EDA2.html
#' eda_report(heartfailure, sodium, output_format = "html", output_file = "EDA2.html")
#'
#' ## target variable is null
#' # reporting the EDA information
#' eda_report(heartfailure)
#' 
#' # create pdf file. file name is EDA2.pdf
#' eda_report(heartfailure, output_file = "EDA2.pdf")
#' 
#' # create html file. file name is EDA_Report.html
#' eda_report(heartfailure, output_format = "html")
#' 
#' # create html file. file name is EDA2.html
#' eda_report(heartfailure, output_format = "html", output_file = "EDA2.html")
#' }
#'
#' @name eda_report.data.frame
#' @usage 
#' ## S3 method for class 'data.frame'
#' eda_report(
#'   .data,
#'   target = NULL,
#'   output_format = c("pdf", "html"),
#'   output_file = NULL,
#'   output_dir = tempdir(),
#'   font_family = NULL,
#'   browse = TRUE,
#'   ...
#' )
#' 
NULL
