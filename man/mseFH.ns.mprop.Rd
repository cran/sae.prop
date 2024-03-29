% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mseFH.ns.mprop.R
\name{mseFH.ns.mprop}
\alias{mseFH.ns.mprop}
\title{Parametric Bootstrap Mean Squared Error of EBLUPs based on a Multivariate Fay Herriot model with Additive Logistic Transformation for Non-Sampled Data}
\usage{
mseFH.ns.mprop(
  formula,
  vardir,
  MAXITER = 100,
  PRECISION = 1e-04,
  cluster = "auto",
  B = 400,
  data
)
}
\arguments{
\item{formula}{an object of class \code{\link[stats]{formula}} that describe the fitted model.}

\item{vardir}{sampling variances of direct estimations. If data is defined, it is a vector containing names of sampling variance columns. If data is not defined, it should be a data frame of sampling variances of direct estimators. The order is \eqn{var1, var2, \dots, var(q-1), cov12, \dots, cov1(q-1), cov23, \dots, cov(q-2)(q-1)}.}

\item{MAXITER}{maximum number of iterations allowed in the Fisher-scoring algorithm, Default: \code{100}.}

\item{PRECISION}{convergence tolerance limit for the Fisher-scoring algorithm, Default: \code{1e-4}.}

\item{cluster}{Default: \code{"auto"}. If \code{cluster = "auto"}, then the clustering will be performed by the function by finding optimal number of cluster. If cluster is a vector containing numbers of cluster for each category, then clustering will be performed based on the chosen number of cluster. If cluster is a data frame or matrix containing cluster information, then the vector will be used directly to find average of random effects. Clustering is performed with k-medoids algorithms using the function \code{\link[fpc]{pamk}}. If \code{"auto"} is chosen, \code{krange} are set to \code{2:(nrow(data)-1)}.}

\item{B}{number of Bootstrap iterations in calculating MSE, Default: \code{400}.}

\item{data}{optional data frame containing the variables named in \code{formula} and \code{vardir}.}
}
\value{
The function returns a list with the following objects:
   \item{est}{a data frame containing values of the estimators for each domains.}
     \itemize{
       \item \code{PC} : transformed EBLUP estimators using inverse alr for each categoory.
       \item \code{status} : status of corresponding domain, whether sampled or non-sampled.
     }
   \item{fit}{a list containing the following objects (model is fitted using REML):}
     \itemize{
       \item \code{convergence} : a logical value equal to \code{TRUE} if Fisher-scoring algorithm converges in less than \code{MAXITER} iterations.
       \item \code{iterations} : number of iterations performed by the Fisher-scoring algorithm.
       \item \code{estcoef} : a data frame that contains the estimated model coefficients, standard errors, t-statistics, and p-values of each coefficient.
       \item \code{refvar} : estimated covariance matrix of random effects.
       \item \code{cluster} : cluster of each category.
       \item \code{cluster.information} : a list containing data frames with average random effects of sampled domain in each cluster.
     }
   \item{components}{a list containing the following objects:}
     \itemize{
       \item \code{random.effects} : data frame containing estimated random effect values of the fitted model for each category and their status whether sampled or non-sampled.
       \item \code{residuals} : data frame containing residuals of the fitted model for each category and their status whether sampled or non-sampled.
     }
   \item{mse}{data frame containing estimated MSE of the estimators.}
     \itemize{
       \item \code{PC} : estimated MSE of plugin (PC) estimators for each category.
       \item \code{status} : status of domain, whether sampled or non-sampled.
     }
}
\description{
This function gives the MSE of transformed EBLUP based on a multivariate Fay-Herriot model. For sampled domains, MSE is estimated using modified parametric bootstrap approach proposed by Gonzalez-Manteiga. For non-sampled domains, MSE is estimated using modified approach by using average sampling variance of sampled domain in each cluster.
}
\examples{
\dontrun{
## Load dataset
data(datasaem.ns)

## If data is defined
Fo = list(Y1 ~ X1,
          Y2 ~ X2,
          Y3 ~ X3)
vardir = c("v1", "v2", "v3", "v12", "v13", "v23")
MSE.ns <- mseFH.ns.mprop(Fo, vardir, data = datasaem.ns, B = 10)

## If data is undefined (and option for cluster arguments)
Fo = list(datasaem.ns$Y1 ~ datasaem.ns$X1,
          datasaem.ns$Y2 ~ datasaem.ns$X2,
          datasaem.ns$Y3 ~ datasaem.ns$X3)
vardir = datasaem.ns[, c("v1", "v2", "v3", "v12", "v13", "v23")]

### "auto"
MSE.ns1 <- mseFH.ns.mprop(Fo, vardir, cluster = "auto", B = 10)

### number of clusters
MSE.ns2 <- mseFH.ns.mprop(Fo, vardir, cluster = c(3, 2, 2), B = 10)

### data frame or matrix containing cluster for each domain
MSE.ns3 <- mseFH.ns.mprop(Fo, vardir, cluster = datasaem.ns[, c("c1", "c2", "c3")], B = 10)

## See the estimators
MSE.ns$mse

## NOTE:
## B = 10 is just for examples.
## Please choose a proper number for Bootstrap iterations in real calculation.
}

}
