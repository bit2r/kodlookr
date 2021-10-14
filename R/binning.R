#' 수치 데이터의 비닝
#'
#' @description binning()은 수치형 데이터를 비닝하여 범주형 데이터로 변환합니다.
#'
#' @details 이 함수는 dplyr 패키지의 mutate, 혹은 transmute 함수와 사용하면
#' 효율적으로 데이터를 비닝할 수 있습니다.
#'
#' 비닝의 이해를 위해서 vignette("transformation") 명령어로 비네트를 참고하세요.
#'
#' @param x numeric. 비닝의 대상이 되는 수치 벡터
#' @param nbins integer. 비닝할 빈(bin)의 개수. 필수 인수로 만약에 기술하지 않으면
#' nclass.Sturges의 결과가 사용됩니다.
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
#' \item breaks : 비닝의 브레이크 포인트로, x의 간격을 정합니다.
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
#' 
#' # bins 클래스 객체의 출력
#' bin
#'
#' # bins 클래스 객체의 요약
#' summary(bin)
#'
#' # bins 클래스 객체의 시각화
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
#'  # 비닝된 결과를 death_event 변수별로 도수를 파악할 수 있는 시각화
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


#' 비닝된 변수의 요약
#'
#' @description "bins", "optimal_bins"을 대상으로 한 요약 방법
#' @param object "bins", "optimal_bins" 객체로, 
#' binning()을 호출했을 때의 일반적인 결과
#' @param ... 다른 메서드에서 또는 다른 메서드로 전달되는 추가 인수
#' @details
#' print.bins()는 "bins"와 "optimal_bins" 객체의 정보를 정확하게 출력합니다.
#' 이것은 bins의 빈도, 비닝의 방법, bins의 개수를 포함합니다.
#' summary.bins()는 각 bins의 수준 빈도와 상대 빈도를 포함한 data.frame를 반환합니다.
#'
#' 비닝의 이해를 위해서 vignette("transformation") 명령어로 비네트를 참고하세요.
#'
#' @return
#' summary.bins() 함수는 객체에 제공된 비닝된 요약 통계를 계산하고
#' data.frame 형태로 반환합니다. 데이터 프레임의 변수는 다음과 같습니다.
#' \itemize{
#'   \item levels : 요인의 수준
#'   \item freq : 요인의 빈도 
#'   \item rate : 수준의 상대 빈도이며, 백분율이 아닙니다.
#' }
#' @seealso \code{\link{binning}}
#' @examples
#' # 예제를 위한 데이터 생성
#' heartfailure2 <- heartfailure
#' heartfailure2[sample(seq(NROW(heartfailure2)), 20), "platelets"] <- NA
#'
#' # type 인수의 기본값인 "quantile"을 이용한 platelets 변수의 비닝
#' bin <- binning(heartfailure2$platelets)
#'
#' # bins 클래스 객체의 출력
#' bin
#'
#' # bins 클래스 객체의 요약
#' summary(bin)
#' @name summary.bins
#' @usage 
#' ## 'bins' 클래스 대상의 S3 메서드
#' summary(object, ...)
NULL


#' @param x "bins"와 "optimal_bins" 클래스 객체로,
#' binning()을 호출했을 때의 일반적인 결과
#' @param ... 다른 메서드에서 또는 다른 메서드로 전달되는 추가 인수
#' @rdname summary.bins
#' @name print.bins
#' @usage 
#' ## 'bins' 클래스 대상의 S3 메서드
#' print(object, ...)
NULL


#' "bins" 객체의 분포 시각화
#'
#' @description
#' 단일 화면에서 두 개의 플롯을 시각화합니다.
#' 상단의 플롯은 수준의 빈도를 나타내는 히스토그램입니다.
#' 하단의 플롯은 수준의 빈도를 나타내는 막대 차트입니다.
#' @param x "bins" 클래스의 객체로 binning()을 호출했을 때의 일반적인 결과입니다.
#' @param typographic logical. 적용 여부는 ggplot2 시각화에서 타이포 그래픽 요소의 
#' 중점에 따라 변경됩니다.
#' 기본값은 TRUE 입니다. 값이 TRUE이면 hrbrthemes 패키지를 사용한 타이포 그래픽 요소에 
#' 중점을 둔 기본 테마를 제공합니다.
#' @param ... 그래픽 매개변수와 같이 메소드에 전달되는 인수(파라미터 참고)
#' @seealso \code{\link{binning}}, \code{\link{print.bins}}, \code{\link{summary.bins}}.
#' @examples
#' # 예제를 위한 데이터 생성
#' heartfailure2 <- heartfailure
#' heartfailure2[sample(seq(NROW(heartfailure2)), 20), "platelets"] <- NA
#'
#' # type 인수의 기본값인  "quantile"을 이용한 platelets 변수의 비닝
#' bin <- binning(heartfailure2$platelets, nbins = 5)
#' plot(bin)
#'
#' # 다른 타입의 인수 사용
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
#' ## 'bins' 클래스 대상의 S3 메서드
#' plot(x, typographic = TRUE, ...)
NULL


#' 스코어링 모델링을 대상으로 한 최적 비닝
#'
#' @description binning_by()는 최적 비닝을 사용하여 수치형 변수의 동일한 길이의 
#' 구간(interval)을 찾습니다.
#' 최적 비닝은 스코어링 모델링의 이면적 사용을 위해 수치형 변수를 bins로 범주화합니다.
#'
#' @details 이 함수는 dplyr 패키지의 mutate, 혹은 transmute 함수와 사용하면
#' 효율적으로 데이터를 비닝할 수 있습니다.
#' 또한 이 함수는 smbinning 패키지의 smbinning() 함수를 사용하여 실행됩니다.
#'
#' @section "optimal_bins" 클래스의 속성:
#' "optimal_bins" 클래스의 속성은 다음과 같습니다.
#' \itemize{
#'   \item class : "optimal_bins".
#'   \item levels : character. 요인 또는 정렬된 요인 수준
#'   \item type : character. 비닝 방법
#'   \item breaks : numeric. 비닝의 브레이크포인트
#'   \item raw : numeric. 비닝 되기 전의 원(raw) 데이터
#'   \item ivtable : data.frame. 값 정보 테이블
#'   \item iv : numeric. 값 정보
#'   \item target : integer. 이진 응답 변수
#' }
#'
#' 비닝의 이해를 위해서 vignette("transformation") 명령어로 비네트를 참고하세요.
#'
#' @param .data 데이터 프레임
#' @param y character. 이진 응답 변수(0, 1)의 이름
#' 변수는 0과 1의 요소만을 포함해야 합니다.
#' 단, 2개의 수준을 가진 요소의 경우, 계산 과정에서 타입 변환이 수행됩니다.
#' @param x character. 연속형 변수의 이름. 최소 5개의 다른 값이어야 하며,
#' Inf는 허용되지 않습니다.
#' @param p numeric. 빈(bin)당 레코드 비율. 기본값은 5\\% (0.05).
#' 이 매개변수는 0.00 (0\\%)보다 크고 0.50 (50\\%)보다 작은 값만 허용합니다.
#' @param ordered logical. 비닝된 결과를 ordered factor로 생성할지의 여부
#' @param labels character. 각 수준에 사용할 라벨 이름
#' @return "optimal_bins" 클래스 객체
#' "optimal_bins" 클래스의 속성은 다음과 같습니다.
#' \itemize{
#'   \item class : "optimal_bins".
#'   \item type : 비닝 방법, "optimal".
#'   \item breaks : numeric. 비닝의 브레이크 포인트로, x의 간격을 정합니다.
#'   \item levels : character. 비닝된 범주형 데이터의 수준
#'   \item raw : numeric. 비닝 되기 전의 원(raw) 데이터로서의 수치 벡터
#'   \item ivtable : data.frame. 값 정보 테이블
#'   \item iv : numeric. 값 정보
#'   \item target : integer. 이진 응답 변수
#' }
#' @seealso \code{\link{binning}}, \code{\link{plot.optimal_bins}}.
#' @examples
#' library(dplyr)
#'
#' # 예제를 위한 데이터 생성
#' heartfailure2 <- heartfailure
#' heartfailure2[sample(seq(NROW(heartfailure2)), 5), "creatinine"] <- NA
#'
#' # 문자를 사용한 최적 비닝
#' bin <- binning_by(heartfailure2, "death_event", "creatinine")
#'
#' # 이름을 사용한 최적 비닝
#' bin <- binning_by(heartfailure2, death_event, creatinine)
#' bin
#'
#' # 성능 테이블
#' attr(bin, "performance")
#'
#' # optimal_bins 클래스의 요약
#' summary(bin)
#'
#' # optimal_bins 클래스의 모든 정보 시각화
#' plot(bin)
#'
#' # optimal_bins 클래스의 WoE 정보 시각화
#' plot(bin, type = "WoE")
#'
#' # optimal_bins 클래스의 모든 정보 시각화(타이포 그래픽 제외)
#' plot(bin, typographic = FALSE)
#'
#' # 비닝된 결과의 추출
#' extract(bin) %>%
#'   head(20)
#'
#' @name binning_by
#' @usage 
#' binning_by(.data, y, x, p = 0.05, ordered = TRUE, labels = NULL)
NULL



#' 최적 비닝의 성능 요약
#'
#' @description "optimal_bins"에 대한 요약 방법. 이항 분류 모델의 성능을 평가하기 
#' 위한 요약 메트릭
#' @param object "optimal_bins" 클래스 객체로, 
#' binning_by()을 호출했을 때의 일반적인 결과
#' @param ... 다른 메서드에서 또는 다른 메서드로 전달되는 추가 인수
#' @details
#' print()는 "optimal_bins" 객체의 비닝 테이블 정보만을 출력합니다.
#' summary.performance_bin()은 일반 메트릭 및 유의성 검정을 따른 결과를 포함합니다.:
#' \itemize{
#'   \item Binning Table : 빈(bin)별 메트릭
#'   \itemize{
#'     \item CntRec, CntPos, CntNeg, RatePos, RateNeg, Odds, WoE, IV, JSD, AUC.
#'   }
#'   \item 일반 메트릭
#'   \itemize{
#'     \item 지니 계수
#'     \item 제프리(Jeffrey)의 정보 가치
#'     \item 젠슨-샤논(Jensen-Shannon) 발산
#'     \item 콜모고로프-스미르노프(Kolmogorov-Smirnov) 통계량
#'     \item 허핀달-허쉬만(Herfindahl-Hirschman) 지수
#'     \item 정규화된 허핀달-허쉬만(Herfindahl-Hirschman) 지수
#'     \item 크래머(Cramer)의 V 통계량
#'   }
#'   \item 유의성 검정 표
#' }
#' @return NULL.
#' @seealso \code{\link{binning_by}}, \code{\link{plot.optimal_bins}}
#' @examples
#' library(dplyr)
#'
#' # 예제를 위한 데이터 생성
#' heartfailure2 <- heartfailure
#' heartfailure2[sample(seq(NROW(heartfailure2)), 5), "creatinine"] <- NA
#'
#' # 최적 비닝
#' bin <- binning_by(heartfailure2, "death_event", "creatinine")
#' bin
#'
#' # optimal_bins 클래스의 요약
#' summary(bin)
#'
#' # 성능 테이블
#' attr(bin, "performance")
#'
#' # optimal_bins 클래스의 모든 정보 시각화
#' plot(bin)
#'
#' # optimal_bins 클래스의 WoE 정보 시각화
#' plot(bin, type = "WoE")
#'
#' # optimal_bins 클래스의 모든 정보 시각화(타이포 그래픽 제외)
#' plot(bin, typographic = FALSE)
#'
#' # 비닝된 결과의 추출
#' extract(bin) %>%
#'   head(20)
#'
#' @name summary.optimal_bins
#' @usage 
#' ## 'optimal_bins' 클래스 대상의 S3 메서드
#' summary(object, ...)
NULL


#' "optimal_bins" 객체의 분포 시각화
#'
#' @description
#' optimal_bins를 사용해 분포, 빈도, 불량률 및 WoE를 이해하기 위한 플롯을 생성합니다.
#'
#' 비닝의 이해를 위해서 vignette("transformation") 명령어로 비네트를 참고하세요.
#'
#' @param x "optimal_bins" 클래스 객체로, 
#' binning_by()을 호출했을 때의 일반적인 결과입니다.
#' @param type character. 시각화 옵션으로 분포는 ("dist"), 상대 빈도는 ("freq"),
#' 양성 비율은 ("posrate"), WoE는 ("WoE")로 지정합니다. 기본값은 "all" 입니다.
#' @param typographic logical. 적용 여부는 ggplot2 시각화에서 타이포 그래픽 요소의
#' 중점에 따라 변경됩니다.
#' 기본값은 TRUE 입니다. 값이 TRUE이면 hrbrthemes 패키지를 사용한 타이포 그래픽
#' 요소에 중점을 둔 기본 테마를 제공합니다.
#' @param rotate_angle integer. x축 레이블의 회적 각도를 지정합니다.
#' 이것은 x축 레이블이 길어 겹칠 때 유용합니다.
#' 기본값은 0으로 레이블이 회전하지 않습니다.
#' @param ... 다른 메서드에서 또는 다른 메서드로 전달되는 추가 인수
#' @seealso \code{\link{binning_by}}, \code{\link{summary.optimal_bins}}
#' @examples
#' # 예제를 위한 데이터 생성
#' heartfailure2 <- heartfailure
#' heartfailure2[sample(seq(NROW(heartfailure2)), 5), "creatinine"] <- NA
#'
#' # binning_by()을 이용한 최적 비닝
#' bin <- binning_by(heartfailure2, "death_event", "creatinine")
#' bin
#'
#' # optimal_bins 클래스의 요약
#' summary(bin)
#'
#' # optimal_bins 클래스의 모든 정보 시각화
#' plot(bin)
#'
#' # x축 레이블이 겹치지 않도록 45도 회전
#' plot(bin, rotate_angle = 45)
#'
#' # optimal_bins 클래스의 WoE 정보 시각화
#' plot(bin, type = "WoE")
#'
#' # optimal_bins 클래스의 모든 정보 시각화(타이포 그래픽 제외)
#' plot(bin)
#'
#' @name plot.optimal_bins
#' @usage 
#' ## 'optimal_bins' 클래스 대상의 S3 메서드
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

#' "bins"에서 빈(bin) 추출
#'
#' @description extract()는 "bins", "optimal_bins" 클래스 객체에서 
#' 비닝된 변수를 추출합니다.
#'
#' @details "bins"와 "optimal_bins" 클래스 객체는 summary(), plot() 함수를 사용하여
#' 비닝된 결과의 성능을 진단합니다. 이 함수는 비닝된 결과를 추출하는데 사용됩니다.
#'
#' @param x bins 클래스나(or) optimal_bins 클래스
#'
#' @return factor.
#' @seealso \code{\link{binning}}, \code{\link{binning_by}}.
#' @examples
#' library(dplyr)
#'
#' # 예제를 위한 데이터 생성
#' heartfailure2 <- heartfailure
#' heartfailure2[sample(seq(NROW(heartfailure2)), 5), "creatinine"] <- NA
#'
#' # binning_by()을 이용한 최적 비닝
#' bin <- binning_by(heartfailure2, "death_event", "creatinine")
#' bin
#'
#' # 비닝된 결과의 추출
#' extract(bin) %>%
#'   head(20)
#'
#' @name extract.bins
#' @usage 
#' ## 'bins' 클래스 대상의 S3 메서드
#' extract(x)
NULL


#' 비닝된 변수의 성능 진단
#'
#' @description performance_bin()은 이항 분류 모델에 대한 비닝된 변수의 성능을 
#' 평가하기 위해 메트릭을 계산합니다.
#'
#' @details 이 함수는 dplyr 패키지의 mutate, 혹은 transmute 함수와 사용하면
#' 효율적으로 데이터를 비닝할 수 있습니다.
#'
#' @param y 문자 또는 숫자, 정수, 인수. 이진 응답 변수(0, 1)
#' 변수는 0과 1의 요소만을 포함해야 합니다.
#' 단, 2개의 수준을 가진 요소의 경우, 계산 과정에서 타입 변환이 수행됩니다.
#' @param x 정수 또는 인수, 문자. 최소 2개의 다른 값이어야 하며, 
#' Inf는 허용되지 않습니다.
#' @param na.rm logical. 결측값을 제거해야 하는지 여부를 나타내는 논리값
#' @return "performance_bin" 클래스 객체. data.frame의 값은 다음과 같습니다.
#' \itemize{
#' \item Bin : character. bins.
#' \item CntRec : integer. 빈(bins)별 빈도
#' \item CntPos : integer. 빈(bins)별 양(positive)의 빈도
#' \item CntNeg : integer. 빈(bins)별 음(negative)의 빈도
#' \item CntCumPos : integer. 빈별 양의 누적 빈도
#' \item CntCumNeg : integer. 빈별 음의 누적 빈도
#' \item RatePos : integer. 빈별 양의 상대 빈도
#' \item RateNeg : integer. 빈별 음의 상대 빈도
#' \item RateCumPos : numeric. 빈별 양의 누적 상대 빈도
#' \item RateCumNeg : numeric. 빈별 음의 누적 상대 빈도
#' \item Odds : numeric. 오즈비(Odds Ratio)
#' \item LnOdds : numeric. 로그화된 오즈비
#' \item WoE : numeric. WoE(Weight of Evidence)
#' \item IV : numeric. 제프리(Jeffrey)의 정보 가치
#' \item JSD : numeric. 젠슨-샤논(Jensen-Shannon) 발산
#' \item AUC : numeric. AUC(Area Under Curve;곡선 아래 면적)
#' }
#' "performance_bin" 클래스의 속성은 다음과 같습니다.
#' \itemize{
#' \item names : character. "Binning Table"이 있는 data.frame의 변수 이름
#' \item class : character. 클래스 이름("performance_bin", "data.frame")
#' \item row.names : character. "Binning Table"이 있는 data.frame의 행 이름
#' \item IV : numeric. 제프리(Jeffrey)의 정보 가치
#' \item JSD : numeric. 젠슨-샤논(Jensen-Shannon) 발산
#' \item KS : numeric. 콜모고로프-스미르노프(Kolmogorov-Smirnov) 통계량
#' \item gini : numeric. 지니 계수
#' \item HHI : numeric. 허핀달-허쉬만(Herfindahl-Hirschman) 지수
#' \item HHI_norm : numeric.정규화된 허핀달-허쉬만(Herfindahl-Hirschman) 지수
#' \item Cramer_V : numeric. 크래머(Cramer)의 V 통계량
#' \item chisq_test : data.frame. 유의성 검정 표. 이름은 다음과 같습니다.
#' \itemize{
#'   \item Bin A : character. 첫 번째 빈(bins)
#'   \item Bin B : character. 두 번째 빈(bins)
#'   \item statistics : numeric. 카이제곱 검정의 통계
#'   \item p_value : numeric. 카이제곱 검정의 유의 확률(p-value)
#'   }
#' }
#' @seealso \code{\link{summary.performance_bin}}, \code{\link{plot.performance_bin}}, \code{\link{binning_by}}.
#' @examples
#' # 예제를 위한 데이터 생성
#' heartfailure2 <- heartfailure
#'
#' set.seed(123)
#' heartfailure2[sample(seq(NROW(heartfailure2)), 5), "creatinine"] <- NA
#'
#' # 타깃 변수를 0(음)과 1(양)로 변경
#' heartfailure2$death_event_2 <- ifelse(heartfailure2$death_event %in% "Yes", 1, 0)
#'
#' # creatinine에서 platelets_bin으로 비닝
#' breaks <- c(0,  1,  2, 10)
#' heartfailure2$creatinine_bin <- cut(heartfailure2$creatinine, breaks)
#'
#' # 비닝된 변수의 성능 진단
#' perf <- performance_bin(heartfailure2$death_event_2, heartfailure2$creatinine_bin)
#' perf
#' summary(perf)
#'
#' # plot(perf)
#'
#' # 비닝된 변수의 성능 진단 (NA 제외)
#' perf <- performance_bin(heartfailure2$death_event_2, heartfailure2$creatinine_bin, na.rm = TRUE)
#' perf
#' summary(perf)
#'
#' # plot(perf)
#'
#' @name performance_bin
#' @usage performance_bin(y, x, na.rm = FALSE)
NULL


#' 비닝된 변수의 성능 요약
#'
#' @description "performance_bin"에 대한 요약 방법으로 이항 분류 모델의 성능을 
#' 평가하기 위한 요약 메트릭.
#' @param object "performance_bin" 클래스 객체로, 
#' performance_bin()을 호출했을 때의 일반적인 결과
#' @param ... 다른 메서드에서 또는 다른 메서드로 전달되는 추가 인수
#' @details
#' print()는 "performance_bin" 객체의 비닝 테이블 정보만을 출력합니다.
#' summary.performance_bin() 일반 메트릭 및 유의성 검정을 따른 결과를 포함합니다.:
#' \itemize{
#'   \item Binning Table : 빈(bins)별 메트릭
#'   \itemize{
#'     \item CntRec, CntPos, CntNeg, RatePos, RateNeg, Odds, WoE, IV, JSD, AUC.
#'   }
#'   \item 일반 메트릭
#'   \itemize{
#'     \item 지니 계수
#'     \item 제프리(Jeffrey)의 정보 가치
#'     \item 젠슨-샤논(Jensen-Shannon) 발산
#'     \item 콜모고로프-스미르노프(Kolmogorov-Smirnov) 통계량
#'     \item 허핀달-허쉬만(Herfindahl-Hirschman) 지수
#'     \item 정규화된 허핀달-허쉬만(Herfindahl-Hirschman) 지수
#'     \item 크래머(Cramer)의 V 통계량
#'   }
#'   \item 유의성 검정 표
#' }
#' @return NULL.
#' @seealso \code{\link{performance_bin}}, \code{\link{plot.performance_bin}}, \code{\link{binning_by}},
#' \code{\link{summary.optimal_bins}}.
#' @examples
#' # 예제를 위한 데이터 생성
#' heartfailure2 <- heartfailure
#'
#' set.seed(123)
#' heartfailure2[sample(seq(NROW(heartfailure2)), 5), "creatinine"] <- NA
#'
#' # 타깃 변수를 0(음)과 1(양)로 변경
#' heartfailure2$death_event_2 <- ifelse(heartfailure2$death_event %in% "Yes", 1, 0)
#'
#' # creatinine에서 platelets_bin으로 비닝
#' breaks <- c(0,  1,  2, 10)
#' heartfailure2$creatinine_bin <- cut(heartfailure2$creatinine, breaks)
#'
#' # 비닝된 변수의 성능 진단
#' perf <- performance_bin(heartfailure2$death_event_2, heartfailure2$creatinine_bin)
#' perf
#' summary(perf)
#'
#' # plot(perf)
#'
#' # 비닝된 변수의 성능 진단 (NA 제외)
#' perf <- performance_bin(heartfailure2$death_event_2, heartfailure2$creatinine_bin, na.rm = TRUE)
#' perf
#' summary(perf)
#'
#' # plot(perf)
#'
#' @name summary.performance_bin
#' @usage 
#' ## 'performance_bin' 클래스 대상의 S3 메서드
#' summary(object, ...)
NULL


#' "performance_bin" 객체에 대한 성능 시각화
#'
#' @description
#' performance_bin을 사용하여 빈별 빈도와 WoE를 이해하기 위해 플롯을 생성합니다.
#'
#' @param x "performance_bin" 클래스 객체로, 
#' performance_bin()을 호출했을 때의 일반적인 결과
#' @param typographic logical. 적용 여부는 ggplot2 시각화에서 타이포 그래픽 요소의
#' 중점에 따라 변경됩니다.
#' 기본값은 TRUE 입니다. 값이 TRUE이면 hrbrthemes 패키지를 사용한 타이포그래픽 요소에 
#' 중점을 둔 기본 테마를 제공합니다.
#' @param ... 다른 메서드에서 또는 다른 메서드로 전달되는 추가 인수
#' @seealso \code{\link{performance_bin}}, \code{\link{summary.performance_bin}}, \code{\link{binning_by}},
#' \code{\link{plot.optimal_bins}}.
#' @examples
#' # 예제를 위한 데이터 생성
#' heartfailure2 <- heartfailure
#'
#' set.seed(123)
#' heartfailure2[sample(seq(NROW(heartfailure2)), 5), "creatinine"] <- NA
#'
#' # 타깃 변수를 0(음)과 1(양)로 변경
#' heartfailure2$death_event_2 <- ifelse(heartfailure2$death_event %in% "Yes", 1, 0)
#'
#' # creatinine에서 platelets_bin으로 비닝
#' breaks <- c(0,  1,  2, 10)
#' heartfailure2$creatinine_bin <- cut(heartfailure2$creatinine, breaks)
#'
#' # 비닝된 변수의 성능 진단
#' perf <- performance_bin(heartfailure2$death_event_2, heartfailure2$creatinine_bin)
#' perf
#' summary(perf)
#'
#' plot(perf)
#'
#' # 비닝된 변수의 성능 진단 (NA 제외)
#' perf <- performance_bin(heartfailure2$death_event_2, heartfailure2$creatinine_bin, na.rm = TRUE)
#' perf
#' summary(perf)
#'
#' plot(perf)
#' plot(perf, typographic = FALSE)
#'
#' @name plot.performance_bin
#' @usage 
#' ## 'performance_bin' 클래스 대상의 S3 메서드
#' plot(x, typographic = TRUE, ...)
NULL
