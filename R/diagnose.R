#' @rdname diagnose.data.frame
#' @name diagnose
#' @usage diagnose(.data, ...)
NULL


#' Diagnose data quality of variables
#'
#' @description The diagnose() produces information for diagnosing
#' the quality of the variables of data.frame or tbl_df.
#'
#' @details The scope of data quality diagnosis is information on missing values
#' and unique value information. Data quality diagnosis can determine variables
#' that require missing value processing. Also, the unique value information can
#' determine the variable to be removed from the data analysis.
#'
#' @section Diagnostic information:
#' The information derived from the data diagnosis is as follows.:
#'
#' \itemize{
#' \item variables : variable names
#' \item types : data type of the variable
#' or to select a variable to be corrected or removed through data diagnosis.
#'   \itemize{
#'     \item integer, numeric, factor, ordered, character, etc.
#'   }
#' \item missing_count : number of missing values
#' \item missing_percent : percentage of missing values
#' \item unique_count : number of unique values
#' \item unique_rate : ratio of unique values. unique_count / number of observation
#' }
#'
#' See vignette("diagonosis") for an introduction to these concepts.
#'
#' @param .data a data.frame or a \code{\link{tbl_df}}.
#' @param ... one or more unquoted expressions separated by commas.
#' You can treat variable names like they are positions.
#' Positive values select variables; negative values to drop variables.
#' If the first expression is negative, diagnose() will automatically start with all variables.
#' These arguments are automatically quoted and evaluated in a context where column names
#' represent column positions.
#' They support unquoting and splicing.
#'
#' @return An object of tbl_df.
#' @seealso \code{\link{diagnose.tbl_dbi}}, \code{\link{diagnose_category.data.frame}}, \code{\link{diagnose_numeric.data.frame}}.
#' @examples
#' # Diagnosis of all variables
#' diagnose(jobchange)
#' 
#' # Select the variable to diagnose
#' diagnose(jobchange, gender, experience, training_hours)
#' diagnose(jobchange, -gender, -experience, -training_hours)
#' diagnose(jobchange, "gender", "experience", "training_hours")
#' diagnose(jobchange, 4, 9, 13)
#' 
#' # Using pipes ---------------------------------
#' library(dplyr)
#' 
#' # Diagnosis of all variables
#' jobchange %>%
#'   diagnose()
#' # Positive values select variables
#' jobchange %>%
#'   diagnose(gender, experience, training_hours)
#' # Negative values to drop variables
#' jobchange %>%
#'   diagnose(-gender, -experience, -training_hours)
#' # Positions values select variables
#' jobchange %>%
#'   diagnose(4, 9, 13)
#' # Positions values select variables
#' jobchange %>%
#'   diagnose(-8, -9, -10)
#'   
#' # Using pipes & dplyr -------------------------
#' # Diagnosis of missing variables
#' jobchange %>%
#'   diagnose() %>%
#'   filter(missing_count > 0)
#'
#' @name diagnose.data.frame
#' @usage 
#' ## S3 method for class 'data.frame'
#' diagnose(.data, ...)
NULL


#' @rdname diagnose_category.data.frame
#' @name diagnose_category
#' @usage diagnose_category(.data, ...)
#' 
NULL


#' Diagnose data quality of categorical variables
#'
#' @description The diagnose_category() produces information for
#' diagnosing the quality of the variables of data.frame or tbl_df.
#'
#' @details The scope of the diagnosis is the occupancy status of the levels
#' in categorical data. If a certain level of occupancy is close to 100%,
#' then the removal of this variable in the forecast model will have to be
#' considered. Also, if the occupancy of all levels is close to 0%, this
#' variable is likely to be an identifier.
#'
#' @section Categorical diagnostic information:
#' The information derived from the categorical data diagnosis is as follows.
#'
#' \itemize{
#' \item variables : variable names
#' \item levels: level names
#' \item N : number of observation
#' \item freq : number of observation at the levels
#' \item ratio : percentage of observation at the levels
#' \item rank : rank of occupancy ratio of levels
#' }
#'
#' See vignette("diagonosis") for an introduction to these concepts.
#'
#' @param .data a data.frame or a \code{\link{tbl_df}}.
#' @param ... one or more unquoted expressions separated by commas.
#' You can treat variable names like they are positions.
#' Positive values select variables; negative values to drop variables.
#' If the first expression is negative, diagnose_category() will automatically
#' start with all variables.
#' These arguments are automatically quoted and evaluated in a context where
#' column names represent column positions.
#' They support unquoting and splicing.
#'
#' @param top an integer. Specifies the upper top rows or rank to extract.
#' Default is 10.
#' @param type a character string specifying how result are extracted.
#' "rank" that extract top n ranks by decreasing frequency. 
#' In this case, if there are ties in rank, more rows than the number specified 
#' by the top argument are returned.
#' Default is "n" extract only top n rows by decreasing frequency. 
#' If there are too many rows to be returned because there are too many ties, 
#' you can adjust the returned rows appropriately by using "n".
#' @param add_character logical. Decide whether to include text variables in the
#' diagnosis of categorical data. The default value is TRUE, which also includes character variables.
#' @param add_date ogical. Decide whether to include Date and POSIXct variables in the
#' diagnosis of categorical data. The default value is TRUE, which also includes character variables.
#' @return an object of tbl_df.
#' @seealso \code{\link{diagnose_category.tbl_dbi}}, \code{\link{diagnose.data.frame}}, 
#' \code{\link{diagnose_numeric.data.frame}}, \code{\link{diagnose_outlier.data.frame}}.
#' @examples
#' # Diagnosis of categorical variables
#' diagnose_category(jobchange)
#' 
#' # Select the variable to diagnose
#' # diagnose_category(jobchange, education_level, company_type)
#' # diagnose_category(jobchange, -education_level, -company_type)
#' # diagnose_category(jobchange, "education_level", "company_type")
#' # diagnose_category(jobchange, 7)
#' 
#' # Using pipes ---------------------------------
#' library(dplyr)
#' 
#' # Diagnosis of all categorical variables
#' jobchange %>%
#'   diagnose_category()
#'
#' # Positive values select variables
#' jobchange %>%
#'  diagnose_category(company_type, job_chnge)
#'  
#' # Negative values to drop variables
#' jobchange %>%
#'   diagnose_category(-company_type, -job_chnge)
#'   
#' # Positions values select variables
#' # jobchange %>%
#' #   diagnose_category(7)
#'   
#' # Positions values select variables
#' # jobchange %>%
#' #   diagnose_category(-7)
#'   
#' # Top rank levels with top argument
#' jobchange %>%
#'   diagnose_category(top = 2)
#'   
#' # Using pipes & dplyr -------------------------
#' # Extraction of level that is more than 60% of categorical data
#' jobchange %>%
#'   diagnose_category()  %>%
#'   filter(ratio >= 60)
#'
#' # All observations of enrollee_id have a rank of 1. 
#' # Because it is a unique identifier. Therefore, if you select up to the top rank 3, 
#' # all records are displayed. It will probably fill your screen.
#' 
#' # extract rows that less than equal rank 3
#' # default of type argument is "n"
#' jobchange %>% 
#'   diagnose_category(enrollee_id, top = 3)
#'
#' # extract rows that less than equal rank 3
#' jobchange %>% 
#'   diagnose_category(enrollee_id, top = 3, type = "rank")
#'  
#' # extract only 3 rows
#' jobchange %>% 
#'   diagnose_category(enrollee_id, top = 3, type = "n")
#'  
#' @name diagnose_category.data.frame
#' @usage 
#' ## S3 method for class 'data.frame'
#' diagnose_category(
#'   .data,
#'   ...,
#'   top = 10,
#'   type = c("rank", "n")[2],
#'   add_character = TRUE,
#'   add_date = TRUE
#' )
#' 
NULL


#' @rdname diagnose_numeric.data.frame
#' @name diagnose_numeric
#' @usage diagnose_numeric(.data, ...)
#' 
NULL


#' Diagnose data quality of numerical variables
#'
#' @description The diagnose_numeric() produces information
#' for diagnosing the quality of the numerical data.
#'
#' @details The scope of the diagnosis is the calculate a statistic that can be
#' used to understand the distribution of numerical data.
#' min, Q1, mean, median, Q3, max can be used to estimate the distribution
#' of data. If the number of zero or minus is large, it is necessary to suspect
#' the error of the data. If the number of outliers is large, a strategy of
#' eliminating or replacing outliers is needed.
#'
#' @section Numerical diagnostic information:
#' The information derived from the numerical data diagnosis is as follows.
#'
#' \itemize{
#' \item variables : variable names
#' \item min : minimum
#' \item Q1 : 25 percentile
#' \item mean : arithmetic average
#' \item median : median. 50 percentile
#' \item Q3 : 75 percentile
#' \item max : maximum
#' \item zero : count of zero values
#' \item minus : count of minus values
#' \item outlier : count of outliers
#' }
#'
#' See vignette("diagonosis") for an introduction to these concepts.
#'
#' @param .data a data.frame or a \code{\link{tbl_df}}.
#' @param ... one or more unquoted expressions separated by commas.
#' You can treat variable names like they are positions.
#' Positive values select variables; negative values to drop variables.
#' If the first expression is negative, diagnose_numeric() will automatically
#' start with all variables.
#' These arguments are automatically quoted and evaluated in a context where column names
#' represent column positions.
#' They support unquoting and splicing.
#'
#' @return an object of tbl_df.
#' @seealso \code{\link{diagnose_numeric.tbl_dbi}}, \code{\link{diagnose.data.frame}}, \code{\link{diagnose_category.data.frame}}, \code{\link{diagnose_outlier.data.frame}}.
#' @examples
#' # Diagnosis of numerical variables
#' diagnose_numeric(heartfailure)
#' 
#' # Select the variable to diagnose
#' diagnose_numeric(heartfailure, cpk_enzyme, sodium)
#' diagnose_numeric(heartfailure, -cpk_enzyme, -sodium)
#' diagnose_numeric(heartfailure, "cpk_enzyme", "sodium")
#' diagnose_numeric(heartfailure, 5)
#' 
#' # Using pipes ---------------------------------
#' library(dplyr)
#' 
#' # Diagnosis of all numerical variables
#' heartfailure %>%
#'   diagnose_numeric()
#' # Positive values select variables
#' heartfailure %>%
#'   diagnose_numeric(cpk_enzyme, sodium)
#' # Negative values to drop variables
#' heartfailure %>%
#'   diagnose_numeric(-cpk_enzyme, -sodium)
#' # Positions values select variables
#' heartfailure %>%
#'   diagnose_numeric(5)
#' # Positions values select variables
#' heartfailure %>%
#'   diagnose_numeric(-1, -5)
#'
#' # Using pipes & dplyr -------------------------
#' # List of variables containing outliers
#' heartfailure %>%
#'   diagnose_numeric()  %>%
#'   filter(outlier > 0)
#'   
#' @name diagnose_numeric.data.frame
#' @usage 
#' ## S3 method for class 'data.frame'
#' diagnose_numeric(.data, ...)
#' 
NULL


#' @rdname diagnose_outlier.data.frame
#' @name diagnose_outlier
#' @usage diagnose_outlier(.data, ...)
#' 
NULL


#' Diagnose outlier of numerical variables
#'
#' @description The diagnose_outlier() produces outlier information
#' for diagnosing the quality of the numerical data.
#'
#' @details The scope of the diagnosis is the provide a outlier information.
#' If the number of outliers is small and the difference between the averages
#' including outliers and the averages not including them is large,
#' it is necessary to eliminate or replace the outliers.
#'
#' @section Outlier Diagnostic information:
#' The information derived from the numerical data diagnosis is as follows.
#'
#' \itemize{
#' \item variables : variable names
#' \item outliers_cnt : number of outliers
#' \item outliers_ratio : percent of outliers
#' \item outliers_mean : arithmetic average of outliers
#' \item with_mean : arithmetic average of with outliers
#' \item without_mean : arithmetic average of without outliers
#' }
#'
#' See vignette("diagonosis") for an introduction to these concepts.
#'
#' @param .data a data.frame or a \code{\link{tbl_df}}.
#' @param ... one or more unquoted expressions separated by commas.
#' You can treat variable names like they are positions.
#' Positive values select variables; negative values to drop variables.
#' If the first expression is negative, diagnose_outlier() will automatically
#' start with all variables.
#' These arguments are automatically quoted and evaluated in a context
#' where column names represent column positions.
#' They support unquoting and splicing.
#'
#' @return an object of tbl_df.
#' @seealso \code{\link{diagnose_outlier.tbl_dbi}}, \code{\link{diagnose.data.frame}}, 
#' \code{\link{diagnose_category.data.frame}}, \code{\link{diagnose_numeric.data.frame}}.
#' @examples
#' # Diagnosis of numerical variables
#' diagnose_outlier(heartfailure)
#' 
#' # Select the variable to diagnose
#' diagnose_outlier(heartfailure, cpk_enzyme, sodium)
#' diagnose_outlier(heartfailure, -cpk_enzyme, -sodium)
#' diagnose_outlier(heartfailure, "cpk_enzyme", "sodium")
#' diagnose_outlier(heartfailure, 5)
#' 
#' # Using pipes ---------------------------------
#' library(dplyr)
#' 
#' # Diagnosis of all numerical variables
#' heartfailure %>%
#'   diagnose_outlier()
#' # Positive values select variables
#' heartfailure %>%
#'   diagnose_outlier(cpk_enzyme, sodium)
#' # Negative values to drop variables
#' heartfailure %>%
#'   diagnose_outlier(-cpk_enzyme, -sodium)
#' # Positions values select variables
#' heartfailure %>%
#'   diagnose_outlier(5)
#' # Positions values select variables
#' heartfailure %>%
#'   diagnose_outlier(-1, -5)
#' 
#' # Using pipes & dplyr -------------------------
#' # outlier_ratio is more than 1%
#' heartfailure %>%
#'   diagnose_outlier()  %>%
#'   filter(outliers_ratio > 1)
#'   
#' @name diagnose_outlier.data.frame
#' @usage 
#' ## S3 method for class 'data.frame'
#' diagnose_outlier(.data, ...)
#' 
NULL


#' @rdname plot_outlier.data.frame
#' @name plot_outlier
#' @usage plot_outlier(.data, ...)
#' 
NULL


#' Plot outlier information of numerical data diagnosis
#'
#' @description The plot_outlier() visualize outlier information
#' for diagnosing the quality of the numerical data.
#'
#' @details The scope of the diagnosis is the provide a outlier information.
#' Since the plot is drawn for each variable, if you specify more than
#' one variable in the ... argument, the specified number of plots are drawn.
#'
#' @section Outlier diagnostic information:
#' The plot derived from the numerical data diagnosis is as follows.
#'
#' \itemize{
#' \item With outliers box plot
#' \item Without outliers box plot
#' \item With outliers histogram
#' \item Without outliers histogram
#' }
#'
#' See vignette("diagonosis") for an introduction to these concepts.
#'
#' @param .data a data.frame or a \code{\link{tbl_df}}.
#' @param ... one or more unquoted expressions separated by commas.
#' You can treat variable names like they are positions.
#' Positive values select variables; negative values to drop variables.
#' If the first expression is negative, plot_outlier() will automatically start
#' with all variables.
#' These arguments are automatically quoted and evaluated in a context
#' where column names represent column positions.
#' They support unquoting and splicing.
#' @param col a color to be used to fill the bars. The default is "steelblue".
#' @param typographic logical. Whether to apply focuses on typographic elements to ggplot2 visualization. 
#' The default is TRUE. if TRUE provides a base theme that focuses on typographic elements using hrbrthemes package.
#' @seealso \code{\link{plot_outlier.tbl_dbi}}, \code{\link{diagnose_outlier.data.frame}}.
#' @examples
#' # Visualization of all numerical variables
#' plot_outlier(heartfailure)
#' 
#' # Select the variable to diagnose
#' plot_outlier(heartfailure, cpk_enzyme, sodium)
#' plot_outlier(heartfailure, -cpk_enzyme, -sodium)
#' plot_outlier(heartfailure, "cpk_enzyme", "sodium")
#' plot_outlier(heartfailure, 7)
#' 
#' # Using the col argument
#' plot_outlier(heartfailure, cpk_enzyme, col = "gray")
#' 
#' # Not allow typographic argument
#' plot_outlier(heartfailure, cpk_enzyme, typographic = FALSE)
#' 
#' # Using pipes ---------------------------------
#' library(dplyr)
#' 
#' # Visualization of all numerical variables
#' heartfailure %>%
#'   plot_outlier()
#' 
#' # Positive values select variables
#' heartfailure %>%
#'   plot_outlier(cpk_enzyme, sodium)
#'   
#' # Negative values to drop variables
#' heartfailure %>%
#'   plot_outlier(-cpk_enzyme, -sodium)
#' 
#' # Positions values select variables
#' heartfailure %>%
#'   plot_outlier(7)
#' 
#' # Positions values select variables
#' heartfailure %>%
#'    plot_outlier(-1, -5)
#' 
#' # Using pipes & dplyr -------------------------
#' # Visualization of numerical variables with a ratio of
#' # outliers greater than 5%
#' # heartfailure %>%
#' #   plot_outlier(heartfailure %>%
#' #      diagnose_outlier() %>%
#' #      filter(outliers_ratio > 5) %>%
#' #      select(variables) %>%
#' #      pull())
#' 
#' @name plot_outlier.data.frame
#' @usage 
#' ## S3 method for class 'data.frame'
#' plot_outlier(.data, ..., col = "steelblue", typographic = TRUE)
#' 
NULL


#' Plot outlier information of target_df 
#'
#' @description The plot_outlier() visualize outlier information
#' for diagnosing the quality of the numerical data with target_df class.
#'
#' @details The scope of the diagnosis is the provide a outlier information.
#' Since the plot is drawn for each variable, if you specify more than
#' one variable in the ... argument, the specified number of plots are drawn.
#'
#' @section Outlier diagnostic information:
#' The plot derived from the numerical data diagnosis is as follows.
#'
#' \itemize{
#' \item With outliers box plot by target variable
#' \item Without outliers box plot by target variable
#' \item With outliers density plot by target variable
#' \item Without outliers density plot by target variable
#' }
#'
#' @param .data a target_df. reference \code{\link{target_by}}.
#' @param ... one or more unquoted expressions separated by commas.
#' You can treat variable names like they are positions.
#' Positive values select variables; negative values to drop variables.
#' If the first expression is negative, plot_outlier() will automatically start
#' with all variables.
#' These arguments are automatically quoted and evaluated in a context
#' where column names represent column positions.
#' They support unquoting and splicing.
#' @param typographic logical. Whether to apply focuses on typographic elements to ggplot2 visualization. 
#' The default is TRUE. if TRUE provides a base theme that focuses on typographic elements using hrbrthemes package.
#' @seealso \code{\link{plot_outlier.data.frame}}.
#' @examples
#' # the target variable is a categorical variable
#' categ <- target_by(heartfailure, death_event)
#' 
#' plot_outlier(categ, sodium)
#' plot_outlier(categ, sodium, typographic = FALSE)
#' 
#' # death_eventing dplyr
#' library(dplyr)
#' heartfailure %>% 
#'   target_by(death_event) %>% 
#'   plot_outlier(sodium, cpk_enzyme)
#' 
#' # death_eventing DBMS tables ----------------------------------
#' # connect DBMS
#' con_sqlite <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")
#' 
#' # copy heartfailure to the DBMS with a table named TB_HEARTFAILURE
#' copy_to(con_sqlite, heartfailure, name = "TB_HEARTFAILURE", overwrite = TRUE)
#' 
#' # If the target variable is a categorical variable
#' categ <- target_by(con_sqlite %>% tbl("TB_HEARTFAILURE") , death_event)
#' 
#' plot_outlier(categ, sodium)
#' 
#' @name plot_outlier.target_df
#' @usage 
#' ## S3 method for class 'target_df'
#' plot_outlier(.data, ..., typographic = TRUE)
#' 
NULL


#' @rdname diagnose_report.data.frame
#' @name diagnose_report
#' @usage diagnose_report(.data, output_format, output_file, output_dir, ...)
#' 
NULL


#' Reporting the information of data diagnosis
#'
#' @description The diagnose_report() report the information for diagnosing
#' the quality of the data.
#'
#' @details Generate generalized data diagnostic reports automatically.
#' You can choose to output to pdf and html files.
#' This is useful for diagnosing a data frame with a large number of variables
#' than data with a small number of variables.
#' For pdf output, Korean Gothic font must be installed in Korean operating system.
#'
#' @section Reported information:
#' Reported from the data diagnosis is as follows.
#'
#' \itemize{
#'   \item Diagnose Data
#'   \itemize{
#'     \item Overview of Diagnosis
#'     \itemize{
#'       \item List of all variables quality
#'       \item Diagnosis of missing data
#'       \item Diagnosis of unique data(Text and Category)
#'       \item Diagnosis of unique data(Numerical)
#'     }
#'     \item Detailed data diagnosis
#'     \itemize{
#'       \item Diagnosis of categorical variables
#'       \item Diagnosis of numerical variables
#'       \item List of numerical diagnosis (zero)
#'       \item List of numerical diagnosis (minus)
#'     }
#'   }
#'   \item Diagnose Outliers
#'   \itemize{
#'     \item Overview of Diagnosis
#'     \itemize{
#'       \item Diagnosis of numerical variable outliers
#'       \item Detailed outliers diagnosis
#'     }
#'   }
#' }
#'
#' See vignette("diagonosis") for an introduction to these concepts.
#'
#' @param .data a data.frame or a \code{\link{tbl_df}}.
#' @param output_format report output type. Choose either "pdf" and "html".
#' "pdf" create pdf file by knitr::knit().
#' "html" create html file by rmarkdown::render().
#' @param output_file name of generated file. default is NULL.
#' @param output_dir name of directory to generate report file. default is tempdir().
#' @param font_family character. font family name for figure in pdf.
#' @param browse logical. choose whether to output the report results to the browser.
#' @param ... arguments to be passed to methods.
#'
#' @examples
#' \dontrun{
#' # reporting the diagnosis information -------------------------
#' # create pdf file. file name is DataDiagnosis_Report.pdf
#' diagnose_report(heartfailure)
#' # create pdf file. file name is Diagn.pdf
#' diagnose_report(heartfailure, output_file = "Diagn.pdf")
#' # create pdf file. file name is ./Diagn.pdf and not browse
#' # diagnose_report(heartfailure, output_dir = ".", output_file = "Diagn.pdf", 
#' #   browse = FALSE)
#' # create html file. file name is Diagnosis_Report.html
#' diagnose_report(heartfailure, output_format = "html")
#' # create html file. file name is Diagn.html
#' diagnose_report(heartfailure, output_format = "html", output_file = "Diagn.html")
#' }
#'
#' @name diagnose_report.data.frame
#' @usage 
#' ## S3 method for class 'data.frame'
#' diagnose_report(
#'   .data,
#'   output_format = c("pdf", "html"),
#'   output_file = NULL,
#'   output_dir = tempdir(),
#'   font_family = NULL,
#'   browse = TRUE,
#'   ...
#' )
#' 
NULL
