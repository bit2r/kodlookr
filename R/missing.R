#' Combination chart for missing value
#'
#' @description
#' Visualize distribution of missing value by combination of variables.
#'
#' @details Rows are variables containing missing values, and columns are observations. 
#' These data structures were grouped into similar groups by applying hclust. 
#' So, it was made possible to visually examine how the missing values are distributed 
#' for each combination of variables.
#' 
#' @param x data frames, or objects to be coerced to one.
#' @param main character. Main title.
#' @param col.left character. The color of left legend that is frequency of NA. default is "#009E73".
#' @param col.right character. The color of right legend that is percentage of NA. default is "#56B4E9".
#' @param typographic logical. Whether to apply focuses on typographic elements to ggplot2 visualization. 
#' The default is TRUE. if TRUE provides a base theme that focuses on typographic elements using hrbrthemes package.
#' @examples
#' # Generate data for the example
#' set.seed(123L)
#' jobchange2 <- jobchange[sample(nrow(jobchange), size = 1000), ]
#' 
#' # Visualize hcluster chart for variables with missing value.
#' plot_na_hclust(jobchange2)
#' 
#' # Change the main title.
#' plot_na_hclust(jobchange2, main = "Distribution of missing value")
#' 
#' # Not support typographic elements
#' plot_na_hclust(jobchange2, typographic = FALSE)
#' 
#' @name plot_na_hclust
#' @usage 
#' plot_na_hclust(
#'   x,
#'   main = NULL,
#'   col.left = "#009E73",
#'   col.right = "#56B4E9",
#'   typographic = TRUE
#' )
#' 
NULL


#' Pareto chart for missing value
#'
#' @description
#' Visualize pareto chart for variables with missing value.
#'
#' @param x data frames, or objects to be coerced to one.
#' @param only_na logical. The default value is FALSE. 
#' If TRUE, only variables containing missing values are selected for visualization. 
#' If FALSE, all variables are included.
#' @param relative logical. If this argument is TRUE, it sets the unit of the left y-axis to relative frequency. 
#' In case of FALSE, set it to frequency.
#' @param grade list. Specifies the cut-off to set the grade of the variable according to the ratio of missing values.
#' The default values are Good: [0, 0.05], OK: (0.05, 0.1], NotBad: (0.1, 0.2], Bad: (0.2, 0.5], Remove: (0.5, 1].
#' @param main character. Main title.
#' @param col character. The color of line for display the cumulative percentage.
#' @param plot logical. If this value is TRUE then visualize plot. else if FALSE, return aggregate information about missing values.
#' @param typographic logical. Whether to apply focuses on typographic elements to ggplot2 visualization. 
#' The default is TRUE. if TRUE provides a base theme that focuses on typographic elements using hrbrthemes package.
#' @examples
#' # Generate data for the example
#' set.seed(123L)
#' jobchange2 <- jobchange[sample(nrow(jobchange), size = 1000), ]
#' 
#' # Diagnose the data with missing_count using diagnose() function
#' library(dplyr)
#' 
#' jobchange2 %>% 
#'   diagnose %>% 
#'   arrange(desc(missing_count))
#' 
#' # Visualize pareto chart for variables with missing value.
#' plot_na_pareto(jobchange2)
#' 
#' # Visualize pareto chart for variables with missing value.
#' plot_na_pareto(jobchange2, col = "blue")
#' 
#' # Visualize only variables containing missing values
#' plot_na_pareto(jobchange2, only_na = TRUE)
#' 
#' # Display the relative frequency 
#' plot_na_pareto(jobchange2, relative = TRUE)
#' 
#' # Change the grade
#' plot_na_pareto(jobchange2, grade = list(High = 0.1, Middle = 0.6, Low = 1))
#' 
#' # Change the main title.
#' plot_na_pareto(jobchange2, relative = TRUE, only_na = TRUE, 
#'                main = "Pareto Chart for jobchange")
#'   
#' # Return the aggregate information about missing values.
#' plot_na_pareto(jobchange2, only_na = TRUE, plot = FALSE)
#' 
#' # Not support typographic elements
#' plot_na_pareto(jobchange2, typographic = FALSE)
#' 
#' @name plot_na_pareto
#' @usage 
#' plot_na_pareto(
#'   x,
#'   only_na = FALSE,
#'   relative = FALSE,
#'   main = NULL,
#'   col = "black",
#'   grade = list(Good = 0.05, OK = 0.1, NotBad = 0.2, Bad = 0.5, Remove = 1),
#'   plot = TRUE,
#'   typographic = TRUE
#' )
#' 
NULL


#' Plot the combination variables that is include missing value
#'
#' @description
#' Visualize the combinations of missing value across cases.
#'
#' @details 
#' The visualization consists of four parts.
#' The bottom left, which is the most basic, visualizes the case of cross(intersection)-combination. 
#' The x-axis is the variable including the missing value, and the y-axis represents the case of a combination of variables.
#' And on the marginal of the two axes, the frequency of the case is expressed as a bar graph. 
#' Finally, the visualization at the top right expresses the number of variables including missing values in the data set, 
#' and the number of observations including missing values and complete cases .
#' 
#' @param x data frames, or objects to be coerced to one.
#' @param only_na logical. The default value is FALSE. 
#' If TRUE, only variables containing missing values are selected for visualization. 
#' If FALSE, included complete case.
#' @param n_intersacts integer. Specifies the number of combinations of variables including missing values. 
#' The combination of variables containing many missing values is chosen first.
#' @param n_vars integer. Specifies the number of variables that contain missing values to be visualized. 
#' The default value is NULL, which visualizes variables containing all missing values. 
#' If this value is greater than the number of variables containing missing values, 
#' all variables containing missing values are visualized. Variables containing many missing values are chosen first.
#' @param main character. Main title.
#' @param typographic logical. Whether to apply focuses on typographic elements to ggplot2 visualization. 
#' The default is TRUE. if TRUE provides a base theme that focuses on typographic elements using hrbrthemes package.
#' @examples
#' # Generate data for the example
#' set.seed(123L)
#' jobchange2 <- jobchange[sample(nrow(jobchange), size = 1000), ]
#' 
#' # Visualize the combination variables that is include missing value.
#' plot_na_intersect(jobchange2)
#' 
#' # Diagnose the data with missing_count using diagnose() function
#' library(dplyr)
#' 
#' jobchange2 %>% 
#'   diagnose %>% 
#'   arrange(desc(missing_count))
#' 
#' # Visualize the combination variables that is include missing value
#' plot_na_intersect(jobchange2)
#' 
#' # Visualize variables containing missing values and complete case
#' plot_na_intersect(jobchange2, only_na = FALSE)
#' 
#' # Using n_vars argument
#' plot_na_intersect(jobchange2, n_vars = 5) 
#' 
#' # Using n_intersects argument
#' plot_na_intersect(jobchange2, only_na = FALSE, n_intersacts = 7)
#' 
#' # Not allow typographic elements
#' plot_na_intersect(jobchange2, typographic = FALSE)
#' 
#' @name plot_na_intersect
#' @usage 
#' plot_na_intersect(
#'   x,
#'   only_na = TRUE,
#'   n_intersacts = NULL,
#'   n_vars = NULL,
#'   main = NULL,
#'   typographic = TRUE
#' )
#' 
NULL
