#' @title Data generated based on Univariate Fay Herriot Model with Additive Logistic Transformation
#' @description This data is generated based on univariate Fay-Herriot model and then transformed by using inverse Additive Logistic Transformation (alr). The steps are as follows:
#' \enumerate{
#'   \item \eqn{\beta} are set to be \eqn{\beta_{0} = \beta_{1} = \beta_{2} = 1}
#'   \item Auxiliary variables are set as follows:
#'   \itemize{
#'     \item \eqn{x_{1} \sim N(0, 1)}
#'     \item \eqn{x_{2} \sim N(0.5, 1)}
#'   }
#'   \item For random effects, \eqn{u \sim N(0, V_{u})}, where \eqn{V_{u} = 1}.
#'   \item For sampling errors \eqn{e \sim N(0, V_{ed})}, where \eqn{V_{ed}} is generated \eqn{V_{ed} \sim InvGamma(50, 0.5)}.
#'   \item The generated data is transformed using inverse alr transformation, so the data will be within the range of proportion.
#' }
#'
#' Auxiliary variables \eqn{x_{1}, x_{2}}, direct estimation \eqn{y}, and sampling variance \eqn{vardir} are combined into a data frame called datasaeu.
#'
#' @format A data frame with 30 rows and 4 columns:
#' \describe{
#'   \item{y}{Direct Estimation of y}
#'   \item{x1}{Auxiliary variable of x1}
#'   \item{x2}{Auxiliary variable of x2}
#'   \item{vardir}{Sampling Variance of y}
#' }
#'
"datasaeu"
