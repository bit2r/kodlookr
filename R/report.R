#' @rdname diagnose_web_report.data.frame
#' @name diagnose_web_report
#' @usage diagnose_web_report(.data, ...)
#' 
NULL


#' @rdname diagnose_paged_report.data.frame
#' @name diagnose_paged_report
#' @usage diagnose_paged_report(.data, ...)
#' 
NULL


#' @rdname eda_web_report.data.frame
#' @name eda_web_report
#' @usage eda_web_report(.data, ...)
#' 
NULL


#' @rdname eda_paged_report.data.frame
#' @name eda_paged_report
#' @usage eda_paged_report(.data, ...)
#' 
NULL


#' Reporting the information of data diagnosis with html
#'
#' @description The diagnose_web_report() report the information for diagnosing
#' the quality of the data.
#'
#' @details Generate generalized data diagnostic reports automatically.
#' This is useful for diagnosing a data frame with a large number of variables
#' than data with a small number of variables.
#' 
#' @section Reported information:
#' Reported from the data diagnosis is as follows.
#'
#' \itemize{
#'   \item Overview
#'   \itemize{
#'     \item Data Structures 
#'     \itemize{
#'       \item Data Structures
#'       \item Data Types
#'       \item Job Informations
#'     }
#'     \item Warnings
#'     \item Variables
#'   }
#'   \item Missing Values
#'   \itemize{
#'     \item List of Missing Values
#'     \item Visualization
#'   }   
#'   \item Unique Values
#'   \itemize{
#'     \item Categorical Variables
#'     \item Numerical Variables
#'   }
#'   \item Outliers
#'   \item Samples
#'   \itemize{
#'     \item Duplicated
#'     \item Heads
#'     \item Tails
#'   }
#' }
#'
#' @seealso \code{\link{diagnose_web_report.tbl_dbi}}.
#'
#' @param .data a data.frame or a \code{\link{tbl_df}}.
#' @param output_file name of generated file. default is NULL.
#' @param output_dir name of directory to generate report file. default is tempdir().
#' @param browse logical. choose whether to output the report results to the browser.
#' @param title character. title of report. default is "Data Diagnosis Report".
#' @param subtitle character. subtitle of report. default is name of data.
#' @param author character. author of report. default is "dlookr".
#' @param title_color character. color of title. default is "gray".
#' @param thres_uniq_cat numeric. threshold to use for "Unique Values - 
#' Categorical Variables". default is 0.5.
#' @param thres_uniq_num numeric. threshold to use for "Unique Values - 
#' Numerical Variables". default is 5.
#' @param create_date Date or POSIXct, character. The date on which the report is generated. 
#' The default value is the result of Sys.time().
#' @param logo_img character. name of logo image file on top left.
#' @param theme character. name of theme for report. support "orange" and "blue". 
#' default is "orange".
#' @param sample_percent numeric. Sample percent of data for performing Diagnosis. 
#' It has a value between (0, 100]. 100 means all data, and 5 means 5\% of sample data.
#' This is useful for data with a large number of observations.
#' @param is_tbl_dbi logical. whether .data is a tbl_dbi object.
#' @param ... arguments to be passed to methods.
#'
#' @examples
#' \dontrun{
#' # create dataset
#' heartfailure2 <- dlookr::heartfailure
#' heartfailure2[sample(seq(NROW(heartfailure2)), 20), "sodium"] <- NA
#' heartfailure2[sample(seq(NROW(heartfailure2)), 5), "smoking"] <- NA
#' heartfailure2[sample(seq(NROW(heartfailure2)), 2), "time"] <- 0
#' heartfailure2[sample(seq(NROW(heartfailure2)), 1), "creatinine"] <- -0.3
#'  
#' # create pdf file. file name is Diagnosis_Report.html
#' diagnose_web_report(heartfailure2)
#' 
#' # file name is Diagn.html. and change logo image
#' logo <- file.path(system.file(package = "dlookr"), "report", "R_logo_html.svg")
#' diagnose_web_report(heartfailure2, logo_img = logo, title_color = "black",
#'   output_file = "Diagn.html")
#'
#' # file name is ./Diagn_heartfailure.html, "blue" theme and not browse
#' diagnose_web_report(heartfailure2, output_dir = ".", author = "Choonghyun Ryu",
#'   output_file = "Diagn_heartfailure.html", theme = "blue", browse = FALSE)
#' }
#' 
#' @name diagnose_web_report.data.frame
#' @usage 
#' ## S3 method for class 'data.frame'
#' diagnose_web_report(
#'   .data,
#'   output_file = NULL,
#'   output_dir = tempdir(),
#'   browse = TRUE,
#'   title = "Data Diagnosis",
#'   subtitle = deparse(substitute(.data)),
#'   author = "dlookr",
#'   title_color = "gray",
#'   thres_uniq_cat = 0.5,
#'   thres_uniq_num = 5,
#'   logo_img = NULL,
#'   create_date = Sys.time(),
#'   theme = c("orange", "blue"),
#'   sample_percent = 100,
#'   is_tbl_dbi = FALSE,
#'   ...
#' )
#' 
NULL


#' Reporting the information of data diagnosis
#'
#' @description The diagnose_paged_report() paged report the information 
#' for diagnosing the quality of the data.
#'
#' @details Generate generalized data diagnostic reports automatically.
#' You can choose to output to pdf and html files.
#' This is useful for diagnosing a data frame with a large number of variables
#' than data with a small number of variables.
#' 
#' Create an  PDF through the Chrome DevTools Protocol. If you want to create PDF, 
#' Google Chrome or Microsoft Edge (or Chromium on Linux) must be installed prior to using this function.
#' If not installed, you must use output_format = "html".
#' 
#' @section Reported information:
#' Reported from the data diagnosis is as follows.
#'
#' \itemize{
#'   \item Overview
#'   \itemize{
#'     \item Data Structures 
#'     \item Job Informations
#'     \item Warnings
#'     \item Variables
#'   } 
#'   \item Missing Values
#'   \itemize{
#'     \item List of Missing Values
#'     \item Visualization
#'   } 
#'   \item Unique Values
#'   \itemize{
#'     \item Categorical Variables
#'     \item Numerical Variables
#'   } 
#'   \item Categorical Variable Diagnosis
#'   \itemize{
#'      \item Top Ranks
#'   }
#'   \item Numerical Variable Diagnosis
#'   \itemize{
#'     \item Distribution
#'     \itemize{
#'       \item Zero Values
#'       \item Minus Values
#'     }
#'     \item Outliers
#'     \itemize{
#'       \item List of Outliers
#'       \item Individual Outliers
#'     }
#'   }
#' }
#'
#' @param .data a data.frame or a \code{\link{tbl_df}}.
#' @param output_format report output type. Choose either "pdf" and "html".
#' "pdf" create pdf file by rmarkdown::render() and pagedown::chrome_print(). so, 
#' you needed Chrome web browser on computer.  
#' "html" create html file by rmarkdown::render().
#' @param output_file name of generated file. default is NULL.
#' @param output_dir name of directory to generate report file. default is tempdir().
#' @param browse logical. choose whether to output the report results to the browser.
#' @param title character. title of report. default is "Data Diagnosis Report".
#' @param subtitle character. subtitle of report. default is name of data.
#' @param author character. author of report. default is "dlookr".
#' @param abstract_title character. abstract title of report. default is 
#' "Report Overview".
#' @param abstract character. abstract of report. 
#' @param title_color character. color of title. default is "white".
#' @param subtitle_color character. color of subtitle. default is "gold".
#' @param thres_uniq_cat numeric. threshold to use for "Unique Values - 
#' Categorical Variables". default is 0.5.
#' @param thres_uniq_num numeric. threshold to use for "Unique Values - 
#' Numerical Variables". default is 5.
#' @param create_date Date or POSIXct, character. The date on which the report is generated. 
#' The default value is the result of Sys.time().
#' @param flag_content_missing logical. whether to output "Missing Value" information. 
#' the default value is TRUE, and the information is displayed.
#' @param flag_content_zero logical. whether to output "Zero Values" information. 
#' the default value is TRUE, and the information is displayed.
#' @param flag_content_minus logical. whether to output "Minus Values" information. 
#' the default value is TRUE, and the information is displayed.
#' @param cover_img character. name of cover image. 
#' @param logo_img character. name of logo image file on top right.
#' @param theme character. name of theme for report. support "orange" and "blue". 
#' default is "orange".
#' @param sample_percent numeric. Sample percent of data for performing Diagnosis. 
#' It has a value between (0, 100]. 100 means all data, and 5 means 5\% of sample data.
#' This is useful for data with a large number of observations.
#' @param is_tbl_dbi logical. whether .data is a tbl_dbi object.
#' @param ... arguments to be passed to methods.
#' 
#' @seealso \code{\link{diagnose_paged_report.tbl_dbi}}.
#' @examples
#' \dontrun{
#' # create dataset
#' heartfailure2 <- dlookr::heartfailure
#' heartfailure2[sample(seq(NROW(heartfailure2)), 20), "sodium"] <- NA
#' heartfailure2[sample(seq(NROW(heartfailure2)), 5), "smoking"] <- NA
#' heartfailure2[sample(seq(NROW(heartfailure2)), 2), "time"] <- 0
#' heartfailure2[sample(seq(NROW(heartfailure2)), 1), "creatinine"] <- -0.3
#'  
#' # create pdf file. file name is Diagnosis_Paged_Report.pdf
#' diagnose_paged_report(heartfailure2)
#' 
#' # create pdf file. file name is Diagn.pdf. and change cover image
#' cover <- file.path(system.file(package = "dlookr"), "report", "cover2.jpg")
#' diagnose_paged_report(heartfailure2, cover_img = cover, title_color = "gray",
#'  output_file = "Diagn.pdf")
#'
#' # create pdf file. file name is ./Diagn.pdf and not browse
#' cover <- file.path(system.file(package = "dlookr"), "report", "cover3.jpg")
#' diagnose_paged_report(heartfailure2, output_dir = ".", cover_img = cover, 
#'   flag_content_missing = FALSE, output_file = "Diagn.pdf", browse = FALSE)
#' 
#' # create pdf file. file name is Diagnosis_Paged_Report.html
#' diagnose_paged_report(heartfailure2, output_format = "html")
#' }
#' 
#' @name diagnose_paged_report.data.frame
#' @usage 
#' ## S3 method for class 'data.frame'
#' diagnose_paged_report(
#'   .data,
#'   output_format = c("pdf", "html"),
#'   output_file = NULL,
#'   output_dir = tempdir(),
#'   browse = TRUE,
#'   title = "Data Diagnosis Report",
#'   subtitle = deparse(substitute(.data)),
#'   author = "dlookr",
#'   abstract_title = "Report Overview",
#'   abstract = NULL,
#'   title_color = "white",
#'   subtitle_color = "gold",
#'   thres_uniq_cat = 0.5,
#'   thres_uniq_num = 5,
#'   flag_content_zero = TRUE,
#'   flag_content_minus = TRUE,
#'   flag_content_missing = TRUE,
#'   cover_img = NULL,
#'   create_date = Sys.time(),
#'   logo_img = NULL,
#'   theme = c("orange", "blue"),
#'   sample_percent = 100,
#'   is_tbl_dbi = FALSE,
#'   ...
#' )
#' 
NULL


#' Reporting the information of EDA with html
#'
#' @description The eda_web_report() report the information of exploratory 
#' data analysis for object inheriting from data.frame.
#'
#' @details Generate generalized EDA report automatically.
#' This feature is useful for EDA of data with many variables, rather than data with fewer variables.
#' 
#' @section Reported information:
#' Reported from the EDA is as follows.
#'
#' \itemize{
#'   \item Overview
#'   \itemize{
#'     \item Data Structures 
#'     \item Data Types
#'     \item Job Informations
#'   }
#'   \item Univariate Analysis
#'   \itemize{
#'     \item Descriptive Statistics
#'     \item Normality Test
#'   }   
#'   \item Bivariate Analysis
#'   \itemize{
#'     \item Compare Numerical Variables
#'     \item Compare Categorical Variables
#'   }
#'   \item Multivariate Analysis
#'   \itemize{
#'     \item Correlation Analysis
#'     \itemize{
#'       \item Correlation Matrix
#'       \item Correlation Plot
#'     }
#'   }
#'   \item Target based Analysis
#'   \itemize{
#'     \item Grouped Numerical Variables
#'     \item Grouped Categorical Variables
#'     \item Grouped Correlation
#'   }
#' }
#'
#' @param .data a data.frame or a \code{\link{tbl_df}}.
#' @param target character. target variable.
#' @param output_file name of generated file. default is NULL.
#' @param output_dir name of directory to generate report file. default is tempdir().
#' @param browse logical. choose whether to output the report results to the browser.
#' @param title character. title of report. default is "EDA".
#' @param subtitle character. subtitle of report. default is name of data.
#' @param author character. author of report. default is "dlookr".
#' @param title_color character. color of title. default is "gray".
#' @param create_date Date or POSIXct, character. The date on which the report is generated. 
#' The default value is the result of Sys.time().
#' @param logo_img character. name of logo image file on top left.
#' @param theme character. name of theme for report. support "orange" and "blue". 
#' default is "orange".
#' @param sample_percent numeric. Sample percent of data for performing EDA. 
#' It has a value between (0, 100]. 100 means all data, and 5 means 5\% of sample data.
#' This is useful for data with a large number of observations.
#' @param is_tbl_dbi logical. whether .data is a tbl_dbi object.
#' @param ... arguments to be passed to methods.
#'
#' @seealso \code{\link{eda_web_report.tbl_dbi}}.
#' @examples
#' \dontrun{
#' # create the dataset
#' heartfailure2 <- dlookr::heartfailure
#' heartfailure2[sample(seq(NROW(heartfailure2)), 20), "sodium"] <- NA
#' heartfailure2[sample(seq(NROW(heartfailure2)), 5), "smoking"] <- NA
#' 
#' # create html file. file name is EDA_Report.html
#' eda_web_report(heartfailure2)
#' 
#' # file name is EDA.html. and change logo image
#' logo <- file.path(system.file(package = "dlookr"), "report", "R_logo_html.svg")
#' eda_web_report(heartfailure2, logo_img = logo, title_color = "black",
#'   output_file = "EDA.html")
#'
#' # file name is ./EDA_heartfailure.html, "blue" theme and not browse
#' eda_web_report(heartfailure2, target = "death_event", output_dir = ".", 
#'   author = "Choonghyun Ryu", output_file = "EDA_heartfailure.html", 
#'   theme = "blue", browse = FALSE)
#' }
#' 
#' @name eda_web_report.data.frame
#' @usage 
#' ## S3 method for class 'data.frame'
#' eda_web_report(
#'   .data,
#'   target = NULL,
#'   output_file = NULL,
#'   output_dir = tempdir(),
#'   browse = TRUE,
#'   title = "EDA",
#'   subtitle = deparse(substitute(.data)),
#'   author = "dlookr",
#'   title_color = "gray",
#'   logo_img = NULL,
#'   create_date = Sys.time(),
#'   theme = c("orange", "blue"),
#'   sample_percent = 100,
#'   is_tbl_dbi = FALSE,
#'   ...
#' )
#' 
NULL


#' Reporting the information of EDA
#'
#' @description The eda_paged_report() paged report the information for EDA.
#'
#' @details Generate generalized EDA report automatically. 
#' You can choose to output to pdf and html files.
#' This feature is useful for EDA of data with many variables, 
#' rather than data with fewer variables.
#' 
#' Create an  PDF through the Chrome DevTools Protocol. If you want to create PDF, 
#' Google Chrome or Microsoft Edge (or Chromium on Linux) must be installed prior to using this function.
#' If not installed, you must use output_format = "html".
#' 
#' @section Reported information:
#' The EDA process will report the following information:
#'
#' \itemize{
#'   \item Overview
#'   \itemize{
#'     \item Data Structures 
#'     \item Job Informations
#'   } 
#'   \item Univariate Analysis
#'   \itemize{
#'     \item Descriptive Statistics
#'     \itemize{
#'       \item Numerical Variables
#'       \item Categorical Variables
#'     }
#'     \item Normality Test
#'   } 
#'   \item Bivariate Analysis
#'   \itemize{
#'     \item Compare Numerical Variables
#'     \item Compare Categorical Variables
#'   } 
#'   \item Multivariate Analysis
#'   \itemize{
#'     \item Correlation Analysis
#'     \itemize{
#'       \item Correlation Coefficient Matrix
#'       \item Correlation Plot
#'     }
#'   }
#'   \item Target based Analysis
#'   \itemize{
#'     \item Grouped Numerical Variables
#'     \item Grouped Categorical Variables
#'     \item Grouped Correlation
#'   }
#' }
#'
#' @param .data a data.frame or a \code{\link{tbl_df}}.
#' @param target character. target variable.
#' @param output_format report output type. Choose either "pdf" and "html".
#' "pdf" create pdf file by rmarkdown::render() and pagedown::chrome_print(). so, 
#' you needed Chrome web browser on computer.  
#' "html" create html file by rmarkdown::render().
#' @param output_file name of generated file. default is NULL.
#' @param output_dir name of directory to generate report file. default is tempdir().
#' @param browse logical. choose whether to output the report results to the browser.
#' @param title character. title of report. default is "Data Diagnosis Report".
#' @param subtitle character. subtitle of report. default is name of data.
#' @param author character. author of report. default is "dlookr".
#' @param abstract_title character. abstract title of report. default is 
#' "Report Overview".
#' @param abstract character. abstract of report. 
#' @param title_color character. color of title. default is "black".
#' @param subtitle_color character. color of subtitle. default is "blue".
#' @param create_date Date or POSIXct, character. The date on which the report is generated. 
#' The default value is the result of Sys.time().
#' @param cover_img character. name of cover image. 
#' @param logo_img character. name of logo image file on top right.
#' @param theme character. name of theme for report. support "orange" and "blue". 
#' default is "orange".
#' @param sample_percent numeric. Sample percent of data for performing Diagnosis. 
#' It has a value between (0, 100]. 100 means all data, and 5 means 5\% of sample data.
#' This is useful for data with a large number of observations.
#' @param is_tbl_dbi logical. whether .data is a tbl_dbi object.
#' @param ... arguments to be passed to methods.
#' 
#' @seealso \code{\link{eda_paged_report.tbl_dbi}}.
#' @examples
#' \dontrun{
#' # create the dataset
#' heartfailure2 <- dlookr::heartfailure
#' heartfailure2[sample(seq(NROW(heartfailure2)), 20), "sodium"] <- NA
#' heartfailure2[sample(seq(NROW(heartfailure2)), 5), "smoking"] <- NA
#' 
#' # create pdf file. file name is EDA_Paged_Report.pdf
#' eda_paged_report(heartfailure2, sample_percent = 80)
#' 
#' # create pdf file. file name is EDA.pdf. and change cover image
#' cover <- file.path(system.file(package = "dlookr"), "report", "cover1.jpg")
#' eda_paged_report(heartfailure2, cover_img = cover, title_color = "gray",
#'   output_file = "EDA.pdf")
#'
#' # create pdf file. file name is ./EDA.pdf and not browse
#' cover <- file.path(system.file(package = "dlookr"), "report", "cover3.jpg")
#' eda_paged_report(heartfailure2, output_dir = ".", cover_img = cover, 
#'   flag_content_missing = FALSE, output_file = "EDA.pdf", browse = FALSE)
#' 
#' # create pdf file. file name is EDA_Paged_Report.html
#' # eda_paged_report(heartfailure2, target = "death_event", output_format = "html")
#' }
#' 
#' @name eda_paged_report.data.frame
#' @usage 
#'## S3 method for class 'data.frame'
#'eda_paged_report(
#'  .data,
#'  target = NULL,
#'  output_format = c("pdf", "html"),
#'  output_file = NULL,
#'  output_dir = tempdir(),
#'  browse = TRUE,
#'  title = "EDA Report",
#'  subtitle = deparse(substitute(.data)),
#'  author = "dlookr",
#'  abstract_title = "Report Overview",
#'  abstract = NULL,
#'  title_color = "black",
#'  subtitle_color = "blue",
#'  cover_img = NULL,
#'  create_date = Sys.time(),
#'  logo_img = NULL,
#'  theme = c("orange", "blue"),
#'  sample_percent = 100,
#'  is_tbl_dbi = FALSE,
#'  ...
#' )
#' 
NULL


#' Reporting the information of transformation with html
#'
#' @description The transformation_web_report() report the information of 
#' transform numerical variables for object inheriting from data.frame.
#'
#' @details Generate transformation reports automatically. 
#' This is useful for Binning a data frame with a large number of variables 
#' than data with a small number of variables.
#' 
#' @section Reported information:
#' The transformation process will report the following information:
#'
#' \itemize{
#'   \item Overview
#'   \itemize{
#'     \item Data Structures 
#'     \item Data Types
#'     \item Job Informations
#'   }
#'   \item Imputation
#'   \itemize{
#'     \item Missing Values
#'     \item Outliers
#'   }   
#'   \item Resolving Skewness
#'   \item Binning
#'   \item Optimal Binning
#' }
#'
#' @param .data a data.frame or a \code{\link{tbl_df}}.
#' @param target character. target variable.
#' @param output_file name of generated file. default is NULL.
#' @param output_dir name of directory to generate report file. default is tempdir().
#' @param browse logical. choose whether to output the report results to the browser.
#' @param title character. title of report. default is "EDA Report".
#' @param subtitle character. subtitle of report. default is name of data.
#' @param author character. author of report. default is "dlookr".
#' @param title_color character. color of title. default is "gray".
#' @param create_date Date or POSIXct, character. The date on which the report is generated. 
#' The default value is the result of Sys.time().
#' @param logo_img character. name of logo image file on top left.
#' @param theme character. name of theme for report. support "orange" and "blue". 
#' default is "orange".
#' @param sample_percent numeric. Sample percent of data for performing EDA. 
#' It has a value between (0, 100]. 100 means all data, and 5 means 5\% of sample data.
#' This is useful for data with a large number of observations.
#' @param ... arguments to be passed to methods.
#'
#' @examples
#' \dontrun{
#' # create html file. file name is Transformation_Report.html
#' transformation_web_report(heartfailure)
#' 
#' # file name is Transformation.html. and change logo image
#' logo <- file.path(system.file(package = "dlookr"), "report", "R_logo_html.svg")
#' transformation_web_report(heartfailure, logo_img = logo, title_color = "black",
#'   output_file = "Transformation.html")
#'
#' # file name is ./Transformation.html, "blue" theme and not browse
#' transformation_web_report(heartfailure, output_dir = ".", target = "death_event", 
#'   author = "Choonghyun Ryu", output_file = "Transformation.html", 
#'   theme = "blue", browse = FALSE)
#' }
#' 
#' @name transformation_web_report
#' @usage 
#' transformation_web_report(
#'   .data,
#'   target = NULL,
#'   output_file = NULL,
#'   output_dir = tempdir(),
#'   browse = TRUE,
#'   title = "Transformation",
#'   subtitle = deparse(substitute(.data)),
#'   author = "dlookr",
#'   title_color = "gray",
#'   logo_img = NULL,
#'   create_date = Sys.time(),
#'   theme = c("orange", "blue"),
#'   sample_percent = 100,
#'   ...
#' )
#' 
NULL


#' Reporting the information of transformation
#'
#' @description The eda_paged_report() paged report the information for data transformatiom.
#'
#' @details Generate transformation reports automatically. 
#' You can choose to output to pdf and html files.
#' This is useful for Binning a data frame with a large number of variables 
#' than data with a small number of variables.
#' 
#' Create an  PDF through the Chrome DevTools Protocol. If you want to create PDF, 
#' Google Chrome or Microsoft Edge (or Chromium on Linux) must be installed prior to using this function.
#' If not installed, you must use output_format = "html".
#' 
#' @section Reported information:
#' TThe transformation process will report the following information:
#'
#' \itemize{
#'   \item Overview
#'   \itemize{
#'     \item Data Structures 
#'     \item Job Informations
#'   } 
#'   \item Imputation
#'   \itemize{
#'     \item Missing Values
#'     \item Outliers
#'   } 
#'   \item Resolving Skewness
#'   \item Binning
#'   \item Optimal Binning
#' }
#'
#' @param .data a data.frame or a \code{\link{tbl_df}}.
#' @param target character. target variable.
#' @param output_format report output type. Choose either "pdf" and "html".
#' "pdf" create pdf file by rmarkdown::render() and pagedown::chrome_print(). so, 
#' you needed Chrome web browser on computer.  
#' "html" create html file by rmarkdown::render().
#' @param output_file name of generated file. default is NULL.
#' @param output_dir name of directory to generate report file. default is tempdir().
#' @param browse logical. choose whether to output the report results to the browser.
#' @param title character. title of report. default is "Data Diagnosis Report".
#' @param subtitle character. subtitle of report. default is name of data.
#' @param author character. author of report. default is "dlookr".
#' @param abstract_title character. abstract title of report. default is 
#' "Report Overview".
#' @param abstract character. abstract of report. 
#' @param title_color character. color of title. default is "white".
#' @param subtitle_color character. color of subtitle. default is "tomato1".
#' @param create_date Date or POSIXct, character. The date on which the report is generated. 
#' The default value is the result of Sys.time().
#' @param cover_img character. name of cover image. 
#' @param logo_img character. name of logo image file on top right.
#' @param theme character. name of theme for report. support "orange" and "blue". 
#' default is "orange".
#' @param sample_percent numeric. Sample percent of data for performing Diagnosis. 
#' It has a value between (0, 100]. 100 means all data, and 5 means 5\% of sample data.
#' This is useful for data with a large number of observations.
#' @param ... arguments to be passed to methods.
#' 
#' @examples
#' \dontrun{
#' # create pdf file. file name is Transformation_Paged_Report.pdf
#' transformation_paged_report(heartfailure, sample_percent = 80)
#' 
#' # create pdf file. file name is Transformation_heartfailure. and change cover image
#' cover <- file.path(system.file(package = "dlookr"), "report", "cover2.jpg")
#' transformation_paged_report(heartfailure, cover_img = cover, title_color = "gray",
#'   output_file = "Transformation_heartfailure")
#'
#' # create pdf file. file name is ./Transformation.pdf and not browse
#' cover <- file.path(system.file(package = "dlookr"), "report", "cover1.jpg")
#' transformation_paged_report(heartfailure, output_dir = ".", cover_img = cover, 
#'   flag_content_missing = FALSE, output_file = "Transformation.pdf", browse = FALSE)
#' 
#' # create pdf file. file name is Transformation_Paged_Report.html
#' transformation_paged_report(heartfailure, target = "death_event", output_format = "html")
#' }
#' 
#' @name transformation_paged_report
#' @usage 
#' transformation_paged_report(
#'   .data,
#'   target = NULL,
#'   output_format = c("pdf", "html"),
#'   output_file = NULL,
#'   output_dir = tempdir(),
#'   browse = TRUE,
#'   title = "Transformation Report",
#'   subtitle = deparse(substitute(.data)),
#'   author = "dlookr",
#'   abstract_title = "Report Overview",
#'   abstract = NULL,
#'   title_color = "white",
#'   subtitle_color = "tomato1",
#'   cover_img = NULL,
#'   create_date = Sys.time(),
#'   logo_img = NULL,
#'   theme = c("orange", "blue"),
#'   sample_percent = 100,
#'   ...
#' )
#' 
NULL
