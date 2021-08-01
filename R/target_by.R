#' @rdname target_by.data.frame
#' @name target_by
#' @usage target_by(.data, target, ...)
#' 
NULL


#' Target by one variables
#'
#' @description
#' In the data analysis, a target_df class is created to identify the
#' relationship between the target variable and the other variable.
#'
#' @details
#' Data analysis proceeds with the purpose of predicting target variables that
#'  correspond to the facts of interest, or examining associations and
#'  relationships with other variables of interest.
#'  Therefore, it is a major challenge for EDA to examine the relationship
#'  between the target variable and its corresponding variable.
#'  Based on the derived relationships, analysts create scenarios for data analysis.
#'
#'  target_by() inherits the \code{\link{grouped_df}} class and returns a target_df
#'  class containing information about the target variable and the variable.
#'
#' See vignette("EDA") for an introduction to these concepts.
#'
#' @param .data a data.frame or a \code{\link{tbl_df}}.
#' @param target target variable.
#' @param ... arguments to be passed to methods.
#' @return an object of target_df class.
#' Attributes of target_df class is as follows.
#' \itemize{
#' \item type_y : the data type of target variable.
#' }
#' @seealso \code{\link{relate}}.
#' @examples
#' # If the target variable is a categorical variable
#' categ <- target_by(heartfailure, death_event)
#' 
#' # If the variable of interest is a numerical variable
#' cat_num <- relate(categ, sodium)
#' cat_num
#' summary(cat_num)
#' 
#' # plot(cat_num)
#' 
#' # If the variable of interest is a categorical variable
#' cat_cat <- relate(categ, hblood_pressure)
#' cat_cat
#' summary(cat_cat)
#'  
#' # plot(cat_cat)
#' 
#' ##---------------------------------------------------
#' # If the target variable is a numerical variable
#' num <- target_by(heartfailure, creatinine)
#' 
#' # If the variable of interest is a numerical variable
#' num_num <- relate(num, sodium)
#' num_num
#' summary(num_num)
#' 
#' # plot(num_num)
#' 
#' # If the variable of interest is a categorical variable
#' num_cat <- relate(num, smoking)
#' num_cat
#' summary(num_cat)
#' 
#' # plot(num_cat)
#' 
#' # Not allow typographic
#' # plot(num_cat, typographic = FALSE)
#' 
#' @name target_by.data.frame
#' @usage 
#' ## S3 method for class 'data.frame'
#' target_by(.data, target, ...)
#' 
NULL


#' Relationship between target variable and variable of interest
#'
#' @description The relationship between the target variable and
#' the variable of interest (predictor) is briefly analyzed.
#'
#' @details Returns the four types of results that correspond to the combination
#' of the target variable and the data type of the variable of interest.
#'
#' \itemize{
#'   \item target variable: categorical variable
#'   \itemize{
#'     \item predictor: categorical variable
#'     \itemize{
#'       \item contingency table
#'       \item c("xtabs", "table") class
#'     }
#'     \item predictor: numerical variable
#'     \itemize{
#'       \item descriptive statistic for each levels and total observation.
#'     }
#'   }
#'   \item target variable: numerical variable
#'   \itemize{
#'     \item predictor: categorical variable
#'     \itemize{
#'       \item ANOVA test. "lm" class.
#'     }
#'     \item predictor: numerical variable
#'     \itemize{
#'       \item simple linear model. "lm" class.
#'     }
#'   }
#' }
#'
#' @section Descriptive statistic information:
#' The information derived from the numerical data describe is as follows.
#'
#' \itemize{
#' \item mean : arithmetic average
#' \item sd : standard deviation
#' \item se_mean : standrd error mean. sd/sqrt(n)
#' \item IQR : interqurtle range (Q3-Q1)
#' \item skewness : skewness
#' \item kurtosis : kurtosis
#' \item p25 : Q1. 25\% percentile
#' \item p50 : median. 50\% percentile
#' \item p75 : Q3. 75\% percentile
#' \item p01, p05, p10, p20, p30 : 1\%, 5\%, 20\%, 30\% percentiles
#' \item p40, p60, p70, p80 : 40\%, 60\%, 70\%, 80\% percentiles
#' \item p90, p95, p99, p100 : 90\%, 95\%, 99\%, 100\% percentiles
#' }
#'
#' @param .data a target_df.
#' @param predictor variable of interest. predictor.
#'
#' See vignette("relate") for an introduction to these concepts.
#'
#' @return An object of the class as relate.
#' Attributes of relate class is as follows.
#' \itemize{
#' \item target : name of target variable
#' \item predictor : name of predictor
#' \item model : levels of binned value.
#' \item raw : table_df with two variables target and predictor.
#' }
#' @seealso \code{\link{print.relate}}, \code{\link{plot.relate}}.
#'
#' @examples
#' # If the target variable is a categorical variable
#' categ <- target_by(heartfailure, death_event)
#' 
#' # If the variable of interest is a numerical variable
#' cat_num <- relate(categ, sodium)
#' cat_num
#' summary(cat_num)
#' 
#' # plot(cat_num)
#' 
#' # If the variable of interest is a categorical variable
#' cat_cat <- relate(categ, hblood_pressure)
#' cat_cat
#' summary(cat_cat)
#'  
#' # plot(cat_cat)
#' 
#' ##---------------------------------------------------
#' # If the target variable is a numerical variable
#' num <- target_by(heartfailure, creatinine)
#' 
#' # If the variable of interest is a numerical variable
#' num_num <- relate(num, sodium)
#' num_num
#' summary(num_num)
#' 
#' # plot(num_num)
#' 
#' # If the variable of interest is a categorical variable
#' num_cat <- relate(num, smoking)
#' num_cat
#' summary(num_cat)
#' 
#' # plot(num_cat)
#' 
#' # Not allow typographic
#' # plot(num_cat, typographic = FALSE)
#' 
#' @name relate
#' @usage relate(.data, predictor)
#' 
NULL


#' @rdname relate
#' @name relate.target_df
#' @usage 
#' ## S3 method for class 'target_df'
#' relate(.data, predictor)
#' 
NULL


#' Summarizing relate information
#'
#' @description print and summary method for "relate" class.
#' @param x an object of class "relate", usually, a result of a call to relate().
#' @param ... further arguments passed to or from other methods.
#' @details
#' print.relate() tries to be smart about formatting four kinds of relate.
#' summary.relate() tries to be smart about formatting four kinds of relate.
#'
#' @seealso \code{\link{plot.relate}}.
#' @examples
#' \dontrun{
#' # If the target variable is a categorical variable
#' categ <- target_by(heartfailure, death_event)
#'
#' # If the variable of interest is a categorical variable
#' cat_cat <- relate(categ, hblood_pressure)
#' 
#' # Print bins class object
#' cat_cat
#' 
#' summary(cat_cat)
#' }
#'
#' @examples
#' # If the target variable is a categorical variable
#' categ <- target_by(heartfailure, death_event)
#' 
#' # If the variable of interest is a numerical variable
#' cat_num <- relate(categ, sodium)
#' cat_num
#' summary(cat_num)
#' 
#' # plot(cat_num)
#' 
#' # If the variable of interest is a categorical variable
#' cat_cat <- relate(categ, hblood_pressure)
#' cat_cat
#' summary(cat_cat)
#'  
#' # plot(cat_cat)
#' 
#' ##---------------------------------------------------
#' # If the target variable is a numerical variable
#' num <- target_by(heartfailure, creatinine)
#' 
#' # If the variable of interest is a numerical variable
#' num_num <- relate(num, sodium)
#' num_num
#' summary(num_num)
#' 
#' # plot(num_num)
#' 
#' # If the variable of interest is a categorical variable
#' num_cat <- relate(num, smoking)
#' num_cat
#' summary(num_cat)
#' 
#' # plot(num_cat)
#' 
#' # Not allow typographic
#' # plot(num_cat, typographic = FALSE)
#' 
#' @name print.relate
#' @usage 
#' ## S3 method for class 'relate'
#' print(x, ...)
#' 
NULL


#' Visualize Information for an "relate" Object
#'
#' @description
#' Visualize four kinds of plot by attribute of relate class.
#'
#' @param x an object of class "relate", usually, a result of a call to relate().
#' @param model logical. This argument selects whether to output the visualization result
#' to the visualization of the object of the lm model to grasp the relationship between
#' the numerical variables.
#' @param hex_thres an integer. Use only when the target and predictor are numeric variables.
#' Used when the number of observations is large. 
#' Specify the threshold of the observations to draw hexabin plots that are not scatterplots. 
#' The default value is 1000.
#' @param pal Color palette to paint hexabin. Use only when the target and predictor are numeric variables.
#' Applied only when the number of observations is greater than hex_thres.
#' @param typographic logical. Whether to apply focuses on typographic elements to ggplot2 visualization. 
#' The default is TRUE. if TRUE provides a base theme that focuses on typographic elements using hrbrthemes package.
#' @param ... arguments to be passed to methods, such as graphical parameters (see par).
#' only applies when the model argument is TRUE, and is used for ... of the plot.lm() function.
#' @seealso \code{\link{relate}}, \code{\link{print.relate}}.
#' @examples
#' # If the target variable is a categorical variable
#' categ <- target_by(heartfailure, death_event)
#' 
#' # If the variable of interest is a numerical variable
#' cat_num <- relate(categ, sodium)
#' cat_num
#' summary(cat_num)
#' 
#' plot(cat_num)
#' 
#' # If the variable of interest is a categorical variable
#' cat_cat <- relate(categ, hblood_pressure)
#' cat_cat
#' summary(cat_cat)
#'  
#' plot(cat_cat)
#' 
#' ##---------------------------------------------------
#' # If the target variable is a numerical variable
#' num <- target_by(heartfailure, creatinine)
#' 
#' # If the variable of interest is a numerical variable
#' num_num <- relate(num, sodium)
#' num_num
#' summary(num_num)
#' 
#' plot(num_num)
#' 
#' # If the variable of interest is a categorical variable
#' num_cat <- relate(num, smoking)
#' num_cat
#' summary(num_cat)
#' 
#' plot(num_cat)
#' 
#' # Not allow typographic
#' plot(num_cat, typographic = FALSE)
#'  
#' @name plot.relate
#' @usage 
#' ## S3 method for class 'relate'
#' plot(
#'   x,
#'   model = FALSE,
#'   hex_thres = 1000,
#'   pal = c("#FFFFB2", "#FED976", "#FEB24C", "#FD8D3C", "#FC4E2A", "#E31A1C", "#B10026"),
#'   typographic = TRUE,
#'   ...
#' )
#' 
NULL
