#' @rdname eda_report.data.frame
#' @name eda_report
#' @usage eda_report(.data, ...)
#' 
NULL


#' EDA 결과 보고서 
#'
#' @description eda_report()은 데이터프레임으로부터 상속된 객체에 대하여 탐색적 데이터분석 보고서를 생성합니다.
#'
#' @details 이 함수는 정형화된 EDA 보고서를 자동적으로 생성합니다. 
#' 보고서 형식은 pdf, html로 선택할 수 있습니다.
#' 이 함수는 소규모 데이터 보다는 대규모 데이터에 대한 EDA에 유용합니다.
#' pdf 출력을 위해서는 한국어 관리 시스템에서 한국어 고딕 폰트를 설치해야 합니다.
#'  
#' @section 생성된 정보:
#' EDA 과정은 아래의 정보를 생성합니다:
#' 
#' \itemize{
#'   \item 소개
#'   \itemize{
#'     \item 데이터셋 정보
#'     \item 변수 정보
#'     \item EDA 보고서에 대하여
#'   }
#'   \item 단변량 분석
#'   \itemize{
#'     \item 기술 통계
#'     \item 수치형 변수의 정규성 검정 
#'     \itemize{
#'       \item (표본) 데이터의 시각화 및 통계량
#'     }
#'   }
#'   \item 변수 간 관계
#'   \itemize{
#'     \item 상관계수
#'     \itemize{
#'       \item 변수 조합에 대한 상관계수
#'       \item 수치형 변수의 상관계수 그래프 
#'     }
#'   }
#'   \item 반응변수 분석
#'   \itemize{
#'     \item 그룹화된 기술통계량
#'     \itemize{
#'       \item 그룹화된 수치형 변수
#'       \item 그룹화된 범주형 변수 
#'     }
#'     \item 변수 간 그룹화된 관계
#'     \itemize{
#'       \item 그룹화된 상관계수 
#'       \item 수치형 변수의 그룹화된 상관계수 그래프 
#'     }
#'   }
#' }
#'
#' 이 개념에 대한 소개는 vignette("EDA") 문서를 참고하시기 바랍니다.  
#'
#' @param .data a data.frame 또는 a \code{\link{tbl_df}}.
#' @param target 반응변수.
#' @param output_format character. 보고서 출력 유형. "pdf" 또는 "html".
#' "pdf" 는 knitr::knit()에 의해 pdf 파일을 생성합니다.
#' "html" 는 rmarkdown::render()에 의해 html 파일을 생성합니다.
#' @param output_file character. 생성된 파일의 이름. 디폴트는 NULL 입니다.
#' @param output_dir character. 보고서 파일을 생성하기 위한 디렉토리 이름. 디폴트는 tempdir() 입니다.
#' @param font_family character. pdf 내 그림에 대한 font family 이름 .
#' @param browse logical. 보고서 결과를 브라우저에 출력할지 여부.
#' @param ... 매소드에 전달할 인수.
#' 
#' @examples
#' if (FALSE) {
#' library(dplyr)
#' 
#' ## 반응변수가 범주형 변수일 경우 ----------------------------------
#' # EDA 정보 보고서
#' # EDA_Report.pdf 라는 이름으로 pdf 파일을 생성합니다.
#' eda_report(heartfailure, death_event)
#' 
#' # EDA_heartfailure.pdf 라는 이름으로 pdf 파일을 생성합니다.
#' eda_report(heartfailure, "death_event", output_file = "EDA_heartfailure.pdf")
#' 
#' # EDA_heartfailure.pdf 라는 이름으로 브라우저에 출력하지 않고, pdf 파일을 생성합니다.
#' eda_report(heartfailure, "death_event", output_dir = ".", 
#'     output_file = "EDA_heartfailure.pdf", browse = FALSE)
#' 
#' # EDA_Report.html 라는 이름으로 html 파일을 생성합니다.
#' eda_report(heartfailure, "death_event", output_format = "html")
#' 
#' # EDA_heartfailure.html 라는 이름으로 html 파일을 생성합니다.
#' eda_report(heartfailure, death_event, output_format = "html", 
#'    output_file = "EDA_heartfailure.html")
#'
#' ## 반응변수가 수치형 변수일 경우 ------------------------------------
#' # EDA 정보 보고서 
#' eda_report(heartfailure, sodium)
#' 
#' # EDA2.pdf 라는 이름으로 pdf 파일을 생성합니다. 
#' eda_report(heartfailure, "sodium", output_file = "EDA2.pdf")
#' 
#' # EDA_Report.html 라는 이름으로 html 파일을 생성합니다.
#' eda_report(heartfailure, "sodium", output_format = "html")
#' 
#' # EDA2.html 라는 이름으로 html 파일을 생성합니다.
#' eda_report(heartfailure, sodium, output_format = "html", output_file = "EDA2.html")
#'
#' ## 반응변수가 존재하지 않을 경우
#' # EDA 정보 보고서 
#' eda_report(heartfailure)
#' 
#' # EDA2.pdf 라는 이름으로 pdf 파일을 생성합니다.
#' eda_report(heartfailure, output_file = "EDA2.pdf")
#' 
#' # EDA_Report.html 라는 이름으로 html 파일을 생성합니다.
#' eda_report(heartfailure, output_format = "html")
#' 
#' # EDA2.html 라는 이름으로 html 파일을 생성합니다.
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
