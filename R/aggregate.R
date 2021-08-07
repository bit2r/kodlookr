#' @rdname plot_bar_category.data.frame
#' @name plot_bar_category
#' @usage plot_bar_category(.data, ...)
NULL

#' Plot bar chart of categorical variables 
#'
#' @description The plot_bar_category() to visualizes the distribution of 
#' categorical data by level or relationship to specific numerical data by level.
#'
#' @details The distribution of categorical variables can be understood by 
#' comparing the frequency of each level. The frequency table helps with this. 
#' As a visualization method, a bar graph can help you understand 
#' the distribution of categorical data more easily than a frequency table.
#'
#' @param .data a data.frame or a \code{\link{tbl_df}} or a \code{\link{grouped_df}}.
#' @param \dots one or more unquoted expressions separated by commas.
#' You can treat variable names like they are positions.
#' Positive values select variables; negative values to drop variables.
#' If the first expression is negative, plot_bar_category() will automatically
#' start with all variables.
#' These arguments are automatically quoted and evaluated in a context where
#' column names represent column positions.
#' They support unquoting and splicing.
#' @param top an integer. Specifies the upper top rank to extract.
#' Default is 10.
#' @param add_character logical. Decide whether to include text variables in the
#' diagnosis of categorical data. The default value is TRUE, which also includes character variables.
#' @param title character. a main title for the plot.
#' @param each logical. Specifies whether to draw multiple plots on one screen. 
#' The default is FALSE, which draws multiple plots on one screen.
#' @param typographic logical. Whether to apply focuses on typographic elements to ggplot2 visualization. 
#' The default is TRUE. if TRUE provides a base theme that focuses on typographic elements using hrbrthemes package.
#' 
#' @examples
#' # Generate data for the example
#' heartfailure2 <- heartfailure
#' heartfailure2[sample(seq(NROW(heartfailure2)), 20), "platelets"] <- NA
#' heartfailure2[sample(seq(NROW(heartfailure2)), 5), "smoking"] <- NA
#' 
#' set.seed(123)
#' heartfailure2$test <- sample(LETTERS[1:15], 299, replace = TRUE)
#' heartfailure2$test[1:30] <- NA
#' 
#' # Visualization of all numerical variables
#' plot_bar_category(heartfailure2)
#' 
#' # Select the variable to diagnose
#' plot_bar_category(heartfailure2, "test", "smoking")
#' plot_bar_category(heartfailure2, -test, -smoking)
#' 
#' # Visualize the each plots
#' plot_bar_category(heartfailure2, each = TRUE)
#' 
#' # Not allow typographic argument
#' plot_bar_category(heartfailure2, typographic = FALSE)
#' 
#' # Using pipes ---------------------------------
#' library(dplyr)
#' 
#' # Plot of all categorical variables
#' heartfailure2 %>%
#'   plot_bar_category()
#' 
#' # Visualize just 7 levels of top frequency
#' heartfailure2 %>%
#'   plot_bar_category(top = 7)
#'   
#' # Visualize only factor, not character
#' heartfailure2 %>%
#'   plot_bar_category(add_character = FALSE) 
#' 
#' # Using groupd_df  ------------------------------
#' heartfailure2 %>% 
#'   group_by(death_event) %>% 
#'   plot_bar_category(top = 5)
#'   
#' heartfailure2 %>% 
#'   group_by(death_event) %>% 
#'   plot_bar_category(each = TRUE, top = 5)  
#'   
#' @rdname plot_bar_category.data.frame 
#' @name plot_bar_category.data.frame
#' @usage 
#' ## S3 method for class 'data.frame'
#' plot_bar_category(
#'   .data, ..., 
#'   top = 10, 
#'   add_character = TRUE,
#'   title = "Frequency by levels of category", 
#'   each = FALSE, 
#'   typographic = TRUE
#' )
#'
NULL


#' @rdname plot_bar_category.data.frame
#' @name plot_bar_category.grouped_df
#' @usage 
#' ## S3 method for class 'grouped_df'
#' plot_bar_category(
#'   .data, ..., 
#'   top = 10, 
#'   add_character = TRUE,
#'   title = "Frequency by levels of category", 
#'   each = FALSE, 
#'   typographic = TRUE
#' )
NULL


##----------------------------------------------------------------------------------

#' @rdname plot_qq_numeric.data.frame
#' @name plot_qq_numeric
#' @usage plot_qq_numeric(.data, ...)
NULL


#' Plot Q-Q plot of numerical variables 
#'
#' @description The plot_qq_numeric() to visualizes the Q-Q plot of numeric data or 
#' relationship to specific categorical data.
#' 
#' @details The The Q-Q plot helps determine whether the distribution of a numeric variable 
#' is normally distributed. plot_qq_numeric() shows Q-Q plots of several numeric variables 
#' on one screen. This function can also display a Q-Q plot for each level of a specific 
#' categorical variable.
#'
#' @param .data data.frame or a \code{\link{tbl_df}} or a \code{\link{grouped_df}}.
#' @param \dots one or more unquoted expressions separated by commas.
#' You can treat variable names like they are positions.
#' Positive values select variables; negative values to drop variables.
#' If the first expression is negative, plot_qq_numeric() will automatically
#' start with all variables.
#' These arguments are automatically quoted and evaluated in a context where
#' column names represent column positions.
#' They support unquoting and splicing.
#'
#' @param col_point character. a color of points in Q-Q plot.
#' @param col_line character. a color of line in Q-Q plot.
#' @param title character. a main title for the plot. 
#' @param each logical. Specifies whether to draw multiple plots on one screen. 
#' The default is FALSE, which draws multiple plots on one screen.
#' @param typographic logical. Whether to apply focuses on typographic elements to ggplot2 visualization. 
#' The default is TRUE. if TRUE provides a base theme that focuses on typographic elements using hrbrthemes package.
#' @examples
#' # Visualization of all numerical variables
#' plot_qq_numeric(heartfailure)
#' 
#' # Select the variable to diagnose
#' plot_qq_numeric(heartfailure, "age", "time")
#' plot_qq_numeric(heartfailure, -age, -time)
#' 
#' # Not allow the typographic elements
#' plot_qq_numeric(heartfailure, "age", typographic = FALSE)
#' 
#' # Using pipes ---------------------------------
#' library(dplyr)
#' 
#' # Plot of all numerical variables
#' heartfailure %>%
#'   plot_qq_numeric()
#' 
#' # Using groupd_df  ------------------------------
#' heartfailure %>% 
#'   group_by(smoking) %>% 
#'   plot_qq_numeric()
#' 
#' heartfailure %>% 
#'   group_by(smoking) %>% 
#'   plot_qq_numeric(each = TRUE)  
#' 
#' @rdname plot_qq_numeric.data.frame 
#' @name plot_qq_numeric.data.frame
#' @usage 
#' ## S3 method for class 'data.frame'
#' plot_qq_numeric(
#'   .data,
#'   ...,
#'   col_point = "steelblue",
#'   col_line = "black",
#'   title = "Q-Q plot by numerical variables",
#'   each = FALSE,
#'   typographic = TRUE
#' )
#' 
NULL


#' @rdname plot_qq_numeric.data.frame
#' @name plot_qq_numeric.grouped_df
#' @usage 
#' ## S3 method for class 'grouped_df'
#' plot_qq_numeric(
#'   .data,
#'   ...,
#'   col_point = "steelblue",
#'   col_line = "black",
#'   title = "Q-Q plot by numerical variables",
#'   each = FALSE,
#'   typographic = TRUE
#' )
NULL


##----------------------------------------------------------------------------------

#' @rdname plot_box_numeric.data.frame
#' @name plot_box_numeric
#' @usage plot_box_numeric(.data, ...)
NULL


#' Plot Box-Plot of numerical variables 
#'
#' @description The plot_box_numeric() to visualizes the box plot of numeric data or 
#' relationship to specific categorical data.
#' 
#' @details The box plot helps determine whether the distribution of a numeric variable. 
#' plot_box_numeric() shows box plots of several numeric variables 
#' on one screen. This function can also display a box plot for each level of a specific 
#' categorical variable.
#'
#' @param .data data.frame or a \code{\link{tbl_df}} or a \code{\link{grouped_df}}.
#' @param \dots one or more unquoted expressions separated by commas.
#' You can treat variable names like they are positions.
#' Positive values select variables; negative values to drop variables.
#' If the first expression is negative, plot_box_numeric() will automatically
#' start with all variables.
#' These arguments are automatically quoted and evaluated in a context where
#' column names represent column positions.
#' They support unquoting and splicing.
#'
#' @param title character. a main title for the plot. 
#' @param each logical. Specifies whether to draw multiple plots on one screen. 
#' The default is FALSE, which draws multiple plots on one screen.
#' @param typographic logical. Whether to apply focuses on typographic elements to ggplot2 visualization. 
#' The default is TRUE. if TRUE provides a base theme that focuses on typographic elements using hrbrthemes package.
#' @examples
#' # Visualization of all numerical variables
#' plot_box_numeric(heartfailure)
#'
#' # Select the variable to diagnose
#' plot_box_numeric(heartfailure, "age", "time")
#' plot_box_numeric(heartfailure, -age, -time)
#'
#' # Visualize the each plots
#' plot_box_numeric(heartfailure, "age", "time", each = TRUE)
#' 
#' # Not allow the typographic elements
#' plot_box_numeric(heartfailure, typographic = FALSE)
#' 
#' # Using pipes ---------------------------------
#' library(dplyr)
#'
#' # Plot of all numerical variables
#' heartfailure %>%
#'   plot_box_numeric()
#'   
#' # Using groupd_df  ------------------------------
#' heartfailure %>% 
#'   group_by(smoking) %>% 
#'   plot_box_numeric()
#'   
#' heartfailure %>% 
#'   group_by(smoking) %>% 
#'   plot_box_numeric(each = TRUE)  
#'   
#' @rdname plot_box_numeric.data.frame 
#' @name plot_box_numeric.data.frame
#' @usage 
#' ## S3 method for class 'data.frame'
#' plot_box_numeric(
#'   .data,
#'   ...,
#'   title = "Distribution by numerical variables",
#'   each = FALSE,
#'   typographic = TRUE
#' )
NULL



#' @rdname plot_box_numeric.data.frame
#' @name plot_box_numeric.grouped_df
#' @usage 
#' ## S3 method for class 'grouped_df'
#' plot_box_numeric(
#'   .data,
#'   ...,
#'   title = "Distribution by numerical variables",
#'   each = FALSE,
#'   typographic = TRUE
#' )
#' 
NULL


##----------------------------------------------------------------------------------

#' @rdname plot_hist_numeric.data.frame
#' @name plot_hist_numeric
#' @usage plot_hist_numeric(.data, ...)
NULL


#' Plot histogram of numerical variables 
#'
#' @description The plot_hist_numeric() to visualizes the histogram of numeric data or 
#' relationship to specific categorical data.
#' 
#' @details The histogram helps determine whether the distribution of a numeric variable. 
#' plot_hist_numeric() shows box plots of several numeric variables 
#' on one screen. This function can also display a histogram for each level of a specific 
#' categorical variable.
#' The bin-width is set to the Freedman-Diaconis rule (2 * IQR(x) / length(x)^(1/3))
#'
#' @param .data data.frame or a \code{\link{tbl_df}} or a \code{\link{grouped_df}}.
#' @param \dots one or more unquoted expressions separated by commas.
#' You can treat variable names like they are positions.
#' Positive values select variables; negative values to drop variables.
#' If the first expression is negative, plot_hist_numeric() will automatically
#' start with all variables.
#' These arguments are automatically quoted and evaluated in a context where
#' column names represent column positions.
#' They support unquoting and splicing.
#'
#' @param title character. a main title for the plot. 
#' @param each logical. Specifies whether to draw multiple plots on one screen. 
#' The default is FALSE, which draws multiple plots on one screen.
#' @param typographic logical. Whether to apply focuses on typographic elements to ggplot2 visualization. 
#' The default is TRUE. if TRUE provides a base theme that focuses on typographic elements using hrbrthemes package.
#' @examples
#' # Visualization of all numerical variables
#' plot_hist_numeric(heartfailure)
#'
#' # Select the variable to diagnose
#' plot_hist_numeric(heartfailure, "age", "time")
#' plot_hist_numeric(heartfailure, -age, -time)
#'
#' # Visualize the each plots
#' plot_hist_numeric(heartfailure, "age", "time", each = TRUE)
#' 
#' # Not allow the typographic elements
#' plot_hist_numeric(heartfailure, typographic = FALSE)
#' 
#' # Using pipes ---------------------------------
#' library(dplyr)
#'
#' # Plot of all numerical variables
#' heartfailure %>%
#'   plot_hist_numeric()
#'   
#' # Using groupd_df  ------------------------------
#' heartfailure %>% 
#'   group_by(smoking) %>% 
#'   plot_hist_numeric()
#'   
#' heartfailure %>% 
#'   group_by(smoking) %>% 
#'   plot_hist_numeric(each = TRUE)  
#'   
#' @rdname plot_hist_numeric.data.frame 
#' @name plot_hist_numeric.data.frame
#' @usage 
#' ## S3 method for class 'data.frame'
#' plot_hist_numeric(
#'   .data,
#'   ...,
#'   title = "Distribution by numerical variables",
#'   each = FALSE,
#'   typographic = TRUE
#' )
#' 
NULL


#' @rdname plot_hist_numeric.data.frame
#' @name plot_hist_numeric.grouped_df
#' @usage 
#' ## S3 method for class 'grouped_df'
#' plot_hist_numeric(
#'   .data,
#'   ...,
#'   title = "Distribution by numerical variables",
#'   each = FALSE,
#'   typographic = TRUE
#' )
#' 
NULL
