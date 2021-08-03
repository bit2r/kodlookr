#' Extracting a class of variables
#'
#' @description The get_class() gets class of variables in data.frame or tbl_df.
#'
#' @param df a data.frame or objects inheriting from data.frame
#' @return a data.frame
#' Variables of data.frame is as follows.
#' \itemize{
#' \item variable : variables name
#' \item class : class of variables
#' }
#' @seealso \code{\link{find_class}}.
#' @examples
#' \dontrun{
#' # data.frame
#' get_class(iris)
#'
#' # tbl_df
#' get_class(ggplot2::diamonds)
#'
#' # with dplyr 
#' library(dplyr)
#' ggplot2::diamonds %>%
#'   get_class() %>% 
#'   filter(class %in% c("integer", "numeric"))
#' }
#' @name get_class
#' @usage get_class(df)
#' 
NULL


#' Extract variable names or indices of a specific class
#'
#' @description The find_class() extracts variable information having a
#' certain class from an object inheriting data.frame.
#'
#' @param df a data.frame or objects inheriting from data.frame
#' @param type character. Defines a group of classes to be searched.
#' "numerical" searches for "numeric" and "integer" classes,
#' "categorical" searches for "factor" and "ordered" classes.
#' "categorical2" adds "character" class to "categorical".
#' "date_categorical" adds result of "categorical2" and "Date", "POSIXct".
#' "date_categorical2" adds result of "categorical" and "Date", "POSIXct".
#' @param index logical. If TRUE is return numeric vector that is variables index.
#' and if FALSE is return character vector that is variables name.
#' default is TRUE.
#'
#' @return character vector or numeric vector.
#' The meaning of vector according to data type is as follows.
#' \itemize{
#' \item character vector : variables name
#' \item numeric vector : variables index
#' }
#' @seealso \code{\link{get_class}}.
#' @examples
#' \dontrun{
#' # data.frame
#' find_class(iris, "numerical")
#' find_class(iris, "numerical", index = FALSE)
#' find_class(iris, "categorical")
#' find_class(iris, "categorical", index = FALSE)
#'
#' # tbl_df
#' find_class(ggplot2::diamonds, "numerical")
#' find_class(ggplot2::diamonds, "numerical", index = FALSE)
#' find_class(ggplot2::diamonds, "categorical")
#' find_class(ggplot2::diamonds, "categorical", index = FALSE)
#'
#' # type is "categorical2"
#' iris2 <- data.frame(iris, char = "chars",
#'                     stringsAsFactors = FALSE)
#' find_class(iris2, "categorical", index = FALSE)
#' find_class(iris2, "categorical2", index = FALSE)
#' }
#' @name find_class
#' @usage 
#' find_class(
#'   df,
#'   type = c("numerical", "categorical", "categorical2", "date_categorical",
#'            "date_categorical2"),
#'   index = TRUE
#' )
#' 
NULL


#' Finding variables including missing values
#'
#' @description
#' Find the variable that contains the missing value in the object
#' that inherits the data.frame or data.frame.
#'
#' @param .data a data.frame or a \code{\link{tbl_df}}.
#' @param index logical. When representing the information of a variable including
#' missing values, specify whether or not the variable is represented by an index.
#' Returns an index if TRUE or a variable names if FALSE.
#' @param rate logical. If TRUE, returns the percentage of missing values
#' in the individual variable.
#' @return Information on variables including missing values.
#' @seealso \code{\link{imputate_na}}, \code{\link{find_outliers}}.
#' @examples
#' \dontrun{
#' find_na(jobchange)
#'
#' find_na(jobchange, index = FALSE)
#'
#' find_na(jobchange, rate = TRUE)
#'
#' ## using dplyr -------------------------------------
#' library(dplyr)
#'
#' # Perform simple data quality diagnosis of variables with missing values.
#' jobchange %>%
#'   select(find_na(.)) %>%
#'   diagnose()
#' }
#' @name find_na
#' @usage find_na(.data, index = TRUE, rate = FALSE)
#' 
NULL


#' Finding variables including outliers
#'
#' @description
#' Find the numerical variable that contains outliers in the object
#' that inherits the data.frame or data.frame.
#'
#' @param .data a data.frame or a \code{\link{tbl_df}}.
#' @param index logical. When representing the information of a variable including
#' outliers, specify whether or not the variable is represented by an index.
#' Returns an index if TRUE or a variable names if FALSE.
#' @param rate logical. If TRUE, returns the percentage of outliers
#' in the individual variable.
#' @return Information on variables including outliers.
#' @seealso \code{\link{find_na}}, \code{\link{imputate_outlier}}.
#' @examples
#' \dontrun{
#' find_outliers(heartfailure)
#'
#' find_outliers(heartfailure, index = FALSE)
#'
#' find_outliers(heartfailure, rate = TRUE)
#'
#' ## using dplyr -------------------------------------
#' library(dplyr)
#'
#' # Perform simple data quality diagnosis of variables with outliers.
#' heartfailure %>%
#'   select(find_outliers(.)) %>%
#'   diagnose()
#' }
#' @name find_outliers
#' @usage find_outliers(.data, index = TRUE, rate = FALSE)
#'
NULL


#' Finding skewed variables
#'
#' @description
#' Find the numerical variable that skewed variable
#' that inherits the data.frame or data.frame.
#'
#' @param .data a data.frame or a \code{\link{tbl_df}}.
#' @param index logical. When representing the information of a skewed variable,
#' specify whether or not the variable is represented by an index.
#' Returns an index if TRUE or a variable names if FALSE.
#' @param value logical. If TRUE, returns the skewness value
#' in the individual variable.
#' @param thres Returns a skewness threshold value that has an absolute skewness
#' greater than thres. The default is NULL to ignore the threshold.
#' but, If value = TRUE, default to 0.5.
#' @return Information on variables including skewness.
#' @seealso \code{\link{find_na}}, \code{\link{find_outliers}}.
#' @examples
#' \dontrun{
#' find_skewness(heartfailure)
#'
#' find_skewness(heartfailure, index = FALSE)
#'
#' find_skewness(heartfailure, thres = 0.1)
#'
#' find_skewness(heartfailure, value = TRUE)
#'
#' find_skewness(heartfailure, value = TRUE, thres = 0.1)
#'
#' ## using dplyr -------------------------------------
#' library(dplyr)
#'
#' # Perform simple data quality diagnosis of skewed variables
#' heartfailure %>%
#'   select(find_skewness(.)) %>%
#'   diagnose()
#' }
#' @name find_skewness
#' @usage find_skewness(.data, index = TRUE, value = FALSE, thres = NULL)
#'
NULL


#' Skewness of the data
#'
#' @description
#' This function calculated skewness of given data.
#'
#' @param x a numeric vector.
#' @param na.rm logical. Determine whether to remove missing values and calculate them. 
#' The default is TRUE.
#' @return numeric. calculated skewness.
#' @seealso \code{\link{kurtosis}}, \code{\link{find_skewness}}.
#' @examples
#' set.seed(123)
#' skewness(rnorm(100))
#' @name skewness
#' @usage skewness(x, na.rm = TRUE)
#' 
NULL


#' Kurtosis of the data
#'
#' @description
#' This function calculated kurtosis of given data.
#'
#' @param x a numeric vector.
#' @param na.rm logical. Determine whether to remove missing values and calculate them. 
#' The default is TRUE.
#' @return numeric. calculated kurtosis
#' @seealso \code{\link{skewness}}.
#' @examples
#' set.seed(123)
#' kurtosis(rnorm(100))
#' @name kurtosis
#' @usage kurtosis(x, na.rm = FALSE)
#' 
NULL


#' Finding Users Machine's OS
#'
#' @description
#' Get the operating system that users machines.
#'
#' @return OS names. "windows" or "osx" or "linux"
#'
#' @examples
#' get_os()
#'
#' @name get_os
#' @usage get_os()
#' 
NULL


#' Calculate the entropy
#'
#' @description
#' Calculate the Shannon's entropy.
#' 
#' @param x a numeric vector.
#'
#' @return numeric. entropy
#'
#' @examples
#' set.seed(123)
#' x <- sample(1:10, 20, replace = TRUE)
#' 
#' entropy(x)
#'
#' @name entropy
#' @usage entropy(x)
#' 
NULL


#' Finding percentile
#'
#' @description
#' Find the percentile of the value specified in numeric vector.
#'
#' @param x numeric. a numeric vector.
#' @param value numeric. a scalar to find percentile value from vector x.
#' @param from numeric. Start interval in logic to find percentile value. default to 0.
#' @param to numeric. End interval in logic to find percentile value. default to 1.
#' @param eps numeric. Threshold value for calculating the approximate value in recursive 
#' calling logic to find the percentile value. (epsilon). default to 1e-06.
#' @return list.
#' Components of list. is as follows.
#' \itemize{
#' \item percentile : numeric. Percentile position of value. It has a value between [0, 100].
#' \item is_outlier : logical. Whether value is an outlier.
#' }
#' @examples
#' \dontrun{
#' carat <- ggplot2::diamonds$carat
#' 
#' quantile(carat)
#' 
#' get_percentile(carat, value = 0.5)
#' get_percentile(carat, value = median(diamonds$carat))
#' get_percentile(carat, value = 1)
#' get_percentile(carat, value = 7)
#' }
#' @name get_percentile
#' @usage get_percentile(x, value, from = 0, to = 1, eps = 1e-06)
#' 
NULL
