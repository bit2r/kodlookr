#' 수치 데이터의 비닝
#'
#' @description binning()은 수치형 데이터를 비닝하여 범주형 데이터로 변환합니다.
#'
#' @details 이 함수는 dplyr 패키지의  mutate, 혹은 transmute 함수와 사용하면 
#' 효율적으로 데이터를 비닝할 수 있습니다.
#'
#' 비닝의 이해를 위해서 vignette("transformation") 명령어로 비네트를 참고 하세요.
#'
#' @param x numeric. 비닝의 대상이 되는 수치 벡터
#' @param nbins integer. 비닝할 빈(bin)의 개수. 필수 인수로 만약에 기술하지 
#' 않으면 nclass.Sturges의 결과가 사용됩니다.
#' @param type character. 비닝 방법을 기술합니다. "quantile", "equal", "pretty", 
#' "kmeans", "bclust"에서 선택합니다.
#' "quantile"는 동일한 분위수 구간의 브레이크포인트를 사용하여 비닝합니다.
#' "equal"은 동일한 길이의 구간(interval)의 브레이크포인트를 사용하여 비닝합니다.
#' "pretty"는 base::pretty() 함수를 활용하여 비닝합니다.
#' "kmeans"는 stats::kmeans() 함수를 사용하여 k-mean 방법으로 비닝합니다.
#' "bclust"는 e1071::bclust() 함수를 사용하여 bagged clustering 방법으로 비닝합니다.
#' "kmeans"와 "bclust" 방법은 classInt::classIntervals() 함수를 사용하였습니다.
#' @param ordered logical. 비닝된 결과를 ordered factor로 생성할지의 여부
#' @param labels character. 각 수준에 사용할 라벨 이름
#' @param approxy.lab logical. 큰 숫자의 프레이크포인트에 대해서 근사값의, 
#' 좀더 예쁜 값의 라벨을 취할지의 여부를 선택합니다. TRUE일 경우에는 근사값으로, 
#' FALSE일 경우에는 원래의 값을 라벨로 사용합니다. 
#' @return bins 클래스 객체.
#' bins 클래스의 속성은 다음과 같습니다.
#' \itemize{
#' \item class : "bins"
#' \item type : 비닝 방법, "quantile", "equal", "pretty", "kmeans", "bclust".
#' \item breaks : 수치 벡터가 절단된 구간의 브레이크 포인트
#' \item levels : 비닝된 범주형 데이터의 수준
#' \item raw : 비닝 되기 전의 원(raw) 데이터로서의 수치 벡터
#' }
#' @seealso \code{\link{binning_by}}, \code{\link{print.bins}}, 
#' \code{\link{summary.bins}}, \code{\link{plot.bins}}.
#' @examples
#' # 예제를 위한 데이터 생성
#' heartfailure2 <- heartfailure
#' heartfailure2[sample(seq(NROW(heartfailure2)), 20), "platelets"] <- NA
#'
#' # type 인수의 기본값인 "quantile"을 이용한 platelets 변수의 비닝
#' bin <- binning(heartfailure2$platelets)
#' # bins 클래스 객체의 출력
#' bin
#'
#' # bins 클래스 객체의 요약
#' summary(bin)
#'
#' # Plot bins class object
#' plot(bin)
#'
#' # labels 인수를 이용한 사례
#' bin <- binning(heartfailure2$platelets, nbins = 4,
#'               labels = c("LQ1", "UQ1", "LQ3", "UQ3"))
#' bin
#' 
#' # 다른 인수를 이용한 사례들
#' bin <- binning(heartfailure2$platelets, nbins = 5, type = "equal")
#' bin
#' bin <- binning(heartfailure2$platelets, nbins = 5, type = "pretty")
#' bin
#' bin <- binning(heartfailure2$platelets, nbins = 5, type = "kmeans")
#' bin
#' bin <- binning(heartfailure2$platelets, nbins = 5, type = "bclust")
#' bin
#'
#' x <- sample(1:1000, size = 50) * 12345679
#' bin <- binning(x)
#' bin
#' bin <- binning(x, approxy.lab = FALSE)
#' bin
#'
#' # 비닝된 결과의 추출
#' extract(bin)
#'
#' # ------------------------------------
#' # dplyr 패키지와 파이프를 이용한 사례
#' # ------------------------------------
#' library(dplyr)
#'
#' # 비닝된 결과를 death_event 변수별로 돗수를 구함
#' heartfailure2 %>%
#'  mutate(platelets_bin = binning(heartfailure2$platelets) %>%
#'           extract()) %>%
#'  group_by(death_event, platelets_bin) %>%
#'  summarise(freq = n()) %>%
#'  arrange(desc(freq)) %>%
#'  head(10)
#'
#'  # 비닝된 결과를 death_event 변수별로 돗수 파악할 수 있는 시각화
#'  heartfailure2 %>%
#'    mutate(platelets_bin = binning(heartfailure2$platelets) %>%
#'             extract()) %>%
#'    target_by(death_event) %>%
#'    relate(platelets_bin) %>%
#'    plot()
#'
#' @import dlookr
#' @name binning
#' @usage 
#' binning(
#'   x,
#'   nbins,
#'   type = c("quantile", "equal", "pretty", "kmeans", "bclust"),
#'   ordered = TRUE,
#'   labels = NULL,
#'   approxy.lab = TRUE
#' )
NULL


#' Summarizing Binned Variable
#'
#' @description summary method for "bins" and "optimal_bins".
#' @param object an object of "bins" and "optimal_bins",
#' usually, a result of a call to binning().
#' @param ... further arguments to be passed from or to other methods.
#' @details
#' print.bins() prints the information of "bins" and "optimal_bins" objects nicely.
#' This includes frequency of bins, binned type, and number of bins.
#' summary.bins() returns data.frame including frequency and relative frequency for each levels(bins).
#'
#' See vignette("transformation") for an introduction to these concepts.
#'
#' @return
#' The function summary.bins() computes and returns a data.frame of summary statistics of the
#' binned given in object. Variables of data frame is as follows.
#' \itemize{
#'   \item levels : levels of factor.
#'   \item freq : frequency of levels.
#'   \item rate : relative frequency of levels. it is not percentage.
#' }
#' @seealso \code{\link{binning}}
#' @examples
#' # Generate data for the example
#' heartfailure2 <- heartfailure
#' heartfailure2[sample(seq(NROW(heartfailure2)), 20), "platelets"] <- NA
#'
#' # Binning the platelets variable. default type argument is "quantile"
#' bin <- binning(heartfailure2$platelets)
#'
#' # Print bins class object
#' bin
#'
#' # Summarize bins class object
#' summary(bin)
#' @name summary.bins
#' @usage 
#' ## S3 method for class 'bins'
#' summary(object, ...)
NULL


#' @param x an object of class "bins" and "optimal_bins",
#' usually, a result of a call to binning().
#' @param ... further arguments passed to or from other methods.
#' @rdname summary.bins
#' @name print.bins
#' @usage 
#' ## S3 method for class 'bins'
#' print(object, ...)
NULL


#' Visualize Distribution for a "bins" object
#'
#' @description
#' Visualize two plots on a single screen.
#' The plot at the top is a histogram representing the frequency of the level.
#' The plot at the bottom is a bar chart representing the frequency of the level.
#' @param x an object of class "bins", usually, a result of a call to binning().
#' @param typographic logical. Whether to apply focuses on typographic elements to ggplot2 visualization.
#' The default is TRUE. if TRUE provides a base theme that focuses on typographic elements using hrbrthemes package.
#' @param ... arguments to be passed to methods, such as graphical parameters (see par).
#' @seealso \code{\link{binning}}, \code{\link{print.bins}}, \code{\link{summary.bins}}.
#' @examples
#' # Generate data for the example
#' heartfailure2 <- heartfailure
#' heartfailure2[sample(seq(NROW(heartfailure2)), 20), "platelets"] <- NA
#'
#' # Binning the platelets variable. default type argument is "quantile"
#' bin <- binning(heartfailure2$platelets, nbins = 5)
#' plot(bin)
#'
#' # Using another type arguments
#' bin <- binning(heartfailure2$platelets, nbins = 5, type = "equal")
#' plot(bin)
#'
#' bin <- binning(heartfailure2$platelets, nbins = 5, type = "pretty")
#' plot(bin)
#'
#' bin <- binning(heartfailure2$platelets, nbins = 5, type = "kmeans")
#' plot(bin)
#'
#' bin <- binning(heartfailure2$platelets, nbins = 5, type = "bclust")
#' plot(bin)
#'
#' @name plot.bins
#' @usage 
#' ## S3 method for class 'bins'
#' plot(x, typographic = TRUE, ...)
NULL


#' Optimal Binning for Scoring Modeling
#'
#' @description The binning_by() finding intervals for numerical variable
#' using optical binning. Optimal binning categorizes a numeric characteristic
#' into bins for ulterior usage in scoring modeling.
#'
#' @details This function is useful when used with the mutate/transmute
#' function of the dplyr package. And this function is implemented using
#' smbinning() function of smbinning package.
#'
#' @section attributes of "optimal_bins" class:
#' Attributes of the "optimal_bins" class that is as follows.
#' \itemize{
#'   \item class : "optimal_bins".
#'   \item levels : character. factor or ordered factor levels
#'   \item type : character. binning method
#'   \item breaks : numeric. breaks for binning
#'   \item raw : numeric. before the binned the raw data
#'   \item ivtable : data.frame. information value table
#'   \item iv : numeric. information value
#'   \item target : integer. binary response variable
#' }
#'
#' See vignette("transformation") for an introduction to these concepts.
#'
#' @param .data a data frame.
#' @param y character. name of binary response variable(0, 1).
#' The variable must contain only the integers 0 and 1 as element.
#' However, in the case of factor having two levels, it is performed while type conversion is performed in the calculation process.
#' @param x character. name of continuous characteristic variable. At least 5 different values. and Inf is not allowed.
#' @param p numeric. percentage of records per bin. Default 5\\% (0.05).
#' This parameter only accepts values greater that 0.00 (0\\%) and lower than 0.50 (50\\%).
#' @param ordered logical. whether to build an ordered factor or not.
#' @param labels character. the label names to use for each of the bins.
#' @return an object of "optimal_bins" class.
#' Attributes of "optimal_bins" class is as follows.
#' \itemize{
#'   \item class : "optimal_bins".
#'   \item type : binning type, "optimal".
#'   \item breaks : numeric. the number of intervals into which x is to be cut.
#'   \item levels : character. levels of binned value.
#'   \item raw : numeric. raw data, x argument value.
#'   \item ivtable : data.frame. information value table.
#'   \item iv : numeric. information value.
#'   \item target : integer. binary response variable.
#' }
#' @seealso \code{\link{binning}}, \code{\link{plot.optimal_bins}}.
#' @examples
#' library(dplyr)
#'
#' # Generate data for the example
#' heartfailure2 <- heartfailure
#' heartfailure2[sample(seq(NROW(heartfailure2)), 5), "creatinine"] <- NA
#'
#' # optimal binning using character
#' bin <- binning_by(heartfailure2, "death_event", "creatinine")
#'
#' # optimal binning using name
#' bin <- binning_by(heartfailure2, death_event, creatinine)
#' bin
#'
#' # performance table
#' attr(bin, "performance")
#'
#' # summary optimal_bins class
#' summary(bin)
#'
#' # visualize all information for optimal_bins class
#' plot(bin)
#'
#' # visualize WoE information for optimal_bins class
#' plot(bin, type = "WoE")
#'
#' # visualize all information without typographic
#' plot(bin, typographic = FALSE)
#'
#' # extract binned results
#' extract(bin) %>%
#'   head(20)
#'
#' @name binning_by
#' @usage 
#' binning_by(.data, y, x, p = 0.05, ordered = TRUE, labels = NULL)
NULL



#' Summarizing Performance for Optimal Bins
#'
#' @description summary method for "optimal_bins". summary metrics to evaluate the performance
#' of binomial classification model.
#' @param object an object of class "optimal_bins", usually, a result of a call to binning_by().
#' @param ... further arguments to be passed from or to other methods.
#' @details
#' print() to print only binning table information of "optimal_bins" objects.
#' summary.performance_bin() includes general metrics and result of significance tests life follows.:
#' \itemize{
#'   \item Binning Table : Metrics by bins.
#'   \itemize{
#'     \item CntRec, CntPos, CntNeg, RatePos, RateNeg, Odds, WoE, IV, JSD, AUC.
#'   }
#'   \item General Metrics.
#'   \itemize{
#'     \item Gini index.
#'     \item Jeffrey's Information Value.
#'     \item Jensen-Shannon Divergence.
#'     \item Kolmogorov-Smirnov Statistics.
#'     \item Herfindahl-Hirschman Index.
#'     \item normalized Herfindahl-Hirschman Index.
#'     \item Cramer's V Statistics.
#'   }
#'   \item Table of Significance Tests.
#' }
#' @return NULL.
#' @seealso \code{\link{binning_by}}, \code{\link{plot.optimal_bins}}
#' @examples
#' library(dplyr)
#'
#' # Generate data for the example
#' heartfailure2 <- heartfailure
#' heartfailure2[sample(seq(NROW(heartfailure2)), 5), "creatinine"] <- NA
#'
#' # optimal binning
#' bin <- binning_by(heartfailure2, "death_event", "creatinine")
#' bin
#'
#' # summary optimal_bins class
#' summary(bin)
#'
#' # performance table
#' attr(bin, "performance")
#'
#' # visualize all information for optimal_bins class
#' plot(bin)
#'
#' # visualize WoE information for optimal_bins class
#' plot(bin, type = "WoE")
#'
#' # visualize all information without typographic
#' plot(bin, typographic = FALSE)
#'
#' # extract binned results
#' extract(bin) %>%
#'   head(20)
#'
#' @name summary.optimal_bins
#' @usage 
#' ## S3 method for class 'optimal_bins'
#' summary(object, ...)
NULL


#' Visualize Distribution for an "optimal_bins" Object
#'
#' @description
#' It generates plots for understand distribution, frequency, bad rate, and weight of evidence using optimal_bins.
#'
#' See vignette("transformation") for an introduction to these concepts.
#'
#' @param x an object of class "optimal_bins", usually, a result of a call to binning_by().
#' @param type character. options for visualization. Distribution ("dist"), Relateive Frequency ("freq"),
#' Positive Rate ("posrate"), and Weight of Evidence ("WoE"). and default "all" draw all plot.
#' @param typographic logical. Whether to apply focuses on typographic elements to ggplot2 visualization.
#' The default is TRUE. if TRUE provides a base theme that focuses on typographic elements using hrbrthemes package.
#' @param rotate_angle integer. specifies the rotation angle of the x-axis label.
#' This is useful when the x-axis labels are long and overlap.
#' The default is 0 to not rotate the label.
#' @param ... further arguments to be passed from or to other methods.
#' @seealso \code{\link{binning_by}}, \code{\link{summary.optimal_bins}}
#' @examples
#' # Generate data for the example
#' heartfailure2 <- heartfailure
#' heartfailure2[sample(seq(NROW(heartfailure2)), 5), "creatinine"] <- NA
#'
#' # optimal binning using binning_by()
#' bin <- binning_by(heartfailure2, "death_event", "creatinine")
#' bin
#'
#' # summary optimal_bins class.
#' summary(bin)
#'
#' # visualize all information for optimal_bins class
#' plot(bin)
#'
#' # rotate the x-axis labels by 45 degrees so that they do not overlap.
#' plot(bin, rotate_angle = 45)
#'
#' # visualize WoE information for optimal_bins class
#' plot(bin, type = "WoE")
#'
#' # visualize all information with typographic
#' plot(bin)
#'
#' @name plot.optimal_bins
#' @usage 
#' ## S3 method for class 'optimal_bins'
#' plot(
#'   x,
#'   type = c("all", "dist", "freq", "posrate", "WoE"),
#'   typographic = TRUE,
#'   rotate_angle = 0,
#'   ...
#' )
NULL

#' @rdname extract.bins
#' @name extract
#' @usage extract(x)
NULL

#' Extract bins from "bins"
#'
#' @description The extract() extract binned variable from "bins", "optimal_bins" class object.
#'
#' @details The "bins" and "optimal_bins" class objects use the summary() and plot() functions to diagnose
#' the performance of binned results. This function is used to extract the binned result if you are satisfied
#' with the result.
#'
#' @param x a bins class or optimal_bins class.
#'
#' @return factor.
#' @seealso \code{\link{binning}}, \code{\link{binning_by}}.
#' @examples
#' library(dplyr)
#'
#' # Generate data for the example
#' heartfailure2 <- heartfailure
#' heartfailure2[sample(seq(NROW(heartfailure2)), 5), "creatinine"] <- NA
#'
#' # optimal binning using binning_by()
#' bin <- binning_by(heartfailure2, "death_event", "creatinine")
#' bin
#'
#' # extract binning result
#' extract(bin) %>%
#'   head(20)
#'
#' @name extract.bins
#' @usage 
#' ## S3 method for class 'bins'
#' extract(x)
NULL


#' Diagnose Performance Binned Variable
#'
#' @description The performance_bin() calculates metrics to evaluate the performance of binned variable for
#' binomial classification model.
#'
#' @details This function is useful when used with the mutate/transmute
#' function of the dplyr package.
#'
#' @param y character or numeric, integer, factor. a binary response variable (0, 1).
#' The variable must contain only the integers 0 and 1 as element.
#' However, in the case of factor/character having two levels, it is performed while type conversion is performed in the calculation process.
#' @param x integer or factor, character. At least 2 different values. and Inf is not allowed.
#' @param na.rm logical. a logical indicating whether missing values should be removed.
#' @return an object of "performance_bin" class. vaue of data.frame is as follows.
#' \itemize{
#' \item Bin : character. bins.
#' \item CntRec : integer. frequency by bins.
#' \item CntPos : integer. frequency of positive  by bins.
#' \item CntNeg : integer. frequency of negative  by bins.
#' \item CntCumPos : integer. cumulate frequency of positive  by bins.
#' \item CntCumNeg : integer. cumulate frequency of negative  by bins.
#' \item RatePos : integer. relative frequency of positive  by bins.
#' \item RateNeg : integer. relative frequency of negative  by bins.
#' \item RateCumPos : numeric. cumulate relative frequency of positive  by bins.
#' \item RateCumNeg : numeric. cumulate relative frequency of negative  by bins.
#' \item Odds : numeric. odd ratio.
#' \item LnOdds : numeric. loged odd ratio.
#' \item WoE : numeric. weight of evidence.
#' \item IV : numeric. Jeffrey's Information Value.
#' \item JSD : numeric. Jensen-Shannon Divergence.
#' \item AUC : numeric. AUC. area under curve.
#' }
#' Attributes of "performance_bin" class is as follows.
#' \itemize{
#' \item names : character. variable name of data.frame with "Binning Table".
#' \item class : character. name of class. "performance_bin" "data.frame".
#' \item row.names : character. row name of data.frame with "Binning Table".
#' \item IV : numeric. Jeffrey's Information Value.
#' \item JSD : numeric. Jensen-Shannon Divergence.
#' \item KS : numeric. Kolmogorov-Smirnov Statistics.
#' \item gini : numeric. Gini index.
#' \item HHI : numeric. Herfindahl-Hirschman Index.
#' \item HHI_norm : numeric.normalized Herfindahl-Hirschman Index.
#' \item Cramer_V : numeric. Cramer's V Statistics.
#' \item chisq_test : data.frame. table of significance tests. name is as follows.
#' \itemize{
#'   \item Bin A : character. first bins.
#'   \item Bin B : character. second bins.
#'   \item statistics : numeric. statistics of Chi-square test.
#'   \item p_value : numeric. p-value of Chi-square test.
#'   }
#' }
#' @seealso \code{\link{summary.performance_bin}}, \code{\link{plot.performance_bin}}, \code{\link{binning_by}}.
#' @examples
#' # Generate data for the example
#' heartfailure2 <- heartfailure
#'
#' set.seed(123)
#' heartfailure2[sample(seq(NROW(heartfailure2)), 5), "creatinine"] <- NA
#'
#' # Change the target variable to 0(negative) and 1(positive).
#' heartfailure2$death_event_2 <- ifelse(heartfailure2$death_event %in% "Yes", 1, 0)
#'
#' # Binnig from creatinine to platelets_bin.
#' breaks <- c(0,  1,  2, 10)
#' heartfailure2$creatinine_bin <- cut(heartfailure2$creatinine, breaks)
#'
#' # Diagnose performance binned variable
#' perf <- performance_bin(heartfailure2$death_event_2, heartfailure2$creatinine_bin)
#' perf
#' summary(perf)
#'
#' # plot(perf)
#'
#' # Diagnose performance binned variable without NA
#' perf <- performance_bin(heartfailure2$death_event_2, heartfailure2$creatinine_bin, na.rm = TRUE)
#' perf
#' summary(perf)
#'
#' # plot(perf)
#'
#' @name performance_bin
#' @usage performance_bin(y, x, na.rm = FALSE)
NULL


#' Summarizing Performance for Binned Variable
#'
#' @description summary method for "performance_bin". summary metrics to evaluate the performance
#' of binomial classification model.
#' @param object an object of class "performance_bin", usually, a result of a call to performance_bin().
#' @param ... further arguments to be passed from or to other methods.
#' @details
#' print() to print only binning table information of "performance_bin" objects.
#' summary.performance_bin() includes general metrics and result of significance tests life follows.:
#' \itemize{
#'   \item Binning Table : Metrics by bins.
#'   \itemize{
#'     \item CntRec, CntPos, CntNeg, RatePos, RateNeg, Odds, WoE, IV, JSD, AUC.
#'   }
#'   \item General Metrics.
#'   \itemize{
#'     \item Gini index.
#'     \item Jeffrey's Information Value.
#'     \item Jensen-Shannon Divergence.
#'     \item Kolmogorov-Smirnov Statistics.
#'     \item Herfindahl-Hirschman Index.
#'     \item normalized Herfindahl-Hirschman Index.
#'     \item Cramer's V Statistics.
#'   }
#'   \item Table of Significance Tests.
#' }
#' @return NULL.
#' @seealso \code{\link{performance_bin}}, \code{\link{plot.performance_bin}}, \code{\link{binning_by}},
#' \code{\link{summary.optimal_bins}}.
#' @examples
#' # Generate data for the example
#' heartfailure2 <- heartfailure
#'
#' set.seed(123)
#' heartfailure2[sample(seq(NROW(heartfailure2)), 5), "creatinine"] <- NA
#'
#' # Change the target variable to 0(negative) and 1(positive).
#' heartfailure2$death_event_2 <- ifelse(heartfailure2$death_event %in% "Yes", 1, 0)
#'
#' # Binnig from creatinine to platelets_bin.
#' breaks <- c(0,  1,  2, 10)
#' heartfailure2$creatinine_bin <- cut(heartfailure2$creatinine, breaks)
#'
#' # Diagnose performance binned variable
#' perf <- performance_bin(heartfailure2$death_event_2, heartfailure2$creatinine_bin)
#' perf
#' summary(perf)
#'
#' # plot(perf)
#'
#' # Diagnose performance binned variable without NA
#' perf <- performance_bin(heartfailure2$death_event_2, heartfailure2$creatinine_bin, na.rm = TRUE)
#' perf
#' summary(perf)
#'
#' # plot(perf)
#'
#' @name summary.performance_bin
#' @usage 
#' ## S3 method for class 'performance_bin'
#' summary(object, ...)
NULL


#' Visualize Performance for an "performance_bin" Object
#'
#' @description
#' It generates plots for understand frequency, WoE by bins using performance_bin.
#'
#' @param x an object of class "performance_bin", usually, a result of a call to performance_bin().
#' @param typographic logical. Whether to apply focuses on typographic elements to ggplot2 visualization.
#' The default is TRUE. if TRUE provides a base theme that focuses on typographic elements using hrbrthemes package.
#' @param ... further arguments to be passed from or to other methods.
#' @seealso \code{\link{performance_bin}}, \code{\link{summary.performance_bin}}, \code{\link{binning_by}},
#' \code{\link{plot.optimal_bins}}.
#' @examples
#' # Generate data for the example
#' heartfailure2 <- heartfailure
#'
#' set.seed(123)
#' heartfailure2[sample(seq(NROW(heartfailure2)), 5), "creatinine"] <- NA
#'
#' # Change the target variable to 0(negative) and 1(positive).
#' heartfailure2$death_event_2 <- ifelse(heartfailure2$death_event %in% "Yes", 1, 0)
#'
#' # Binnig from creatinine to platelets_bin.
#' breaks <- c(0,  1,  2, 10)
#' heartfailure2$creatinine_bin <- cut(heartfailure2$creatinine, breaks)
#'
#' # Diagnose performance binned variable
#' perf <- performance_bin(heartfailure2$death_event_2, heartfailure2$creatinine_bin)
#' perf
#' summary(perf)
#'
#' plot(perf)
#'
#' # Diagnose performance binned variable without NA
#' perf <- performance_bin(heartfailure2$death_event_2, heartfailure2$creatinine_bin, na.rm = TRUE)
#' perf
#' summary(perf)
#'
#' plot(perf)
#' plot(perf, typographic = FALSE)
#'
#' @name plot.performance_bin
#' @usage 
#' ## S3 method for class 'performance_bin'
#' plot(x, typographic = TRUE, ...)
NULL
