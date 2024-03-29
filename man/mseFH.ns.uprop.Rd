% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mseFH.ns.uprop.R
\name{mseFH.ns.uprop}
\alias{mseFH.ns.uprop}
\title{Parametric Bootstrap Mean Squared Error of EBLUPs based on a Univariate Fay Herriot model with Additive Logistic Transformation for Non-Sampled Data}
\usage{
mseFH.ns.uprop(
  formula,
  vardir,
  MAXITER = 100,
  PRECISION = 1e-04,
  cluster = "auto",
  B = 1000,
  data
)
}
\arguments{
\item{formula}{an object of class \code{\link[stats]{formula}} that describe the fitted model.}

\item{vardir}{vector containing the sampling variances of direct estimators for each domain. The values must be sorted as the variables in \code{formula}.}

\item{MAXITER}{maximum number of iterations allowed in the Fisher-scoring algorithm, Default: \code{100}.}

\item{PRECISION}{convergence tolerance limit for the Fisher-scoring algorithm, Default: \code{1e-4}.}

\item{cluster}{Default: \code{"auto"}. If \code{cluster = "auto"}, then the clustering will be performed by the function by finding optimal number of cluster. If cluster is a number, then clustering will be performed based on the chosen number of cluster. If cluster is a vector containing cluster information, then the vector will be used directly to find average of random effects. Clustering is performed with k-medoids algorithms using the function \code{\link[fpc]{pamk}}. If \code{"auto"} is chosen, \code{krange} are set to \code{2:(nrow(data)-1)}.}

\item{B}{number of Bootstrap iterations in calculating MSE, Default: \code{1000}.}

\item{data}{optional data frame containing the variables named in \code{formula} and \code{vardir}.}
}
\value{
The function returns a list with the following objects:
   \item{est}{a data frame containing values of the estimators for each domains.}
     \itemize{
       \item \code{PC} : transformed EBLUP estimators using inverse alr.
       \item \code{status} : status of corresponding domain, whether sampled or non-sampled.
       \item \code{cluster} : cluster of corresponding domain.
     }
   \item{fit}{a list containing the following objects (model is fitted using REML):}
     \itemize{
       \item \code{convergence} : a logical value equal to \code{TRUE} if Fisher-scoring algorithm converges in less than \code{MAXITER} iterations.
       \item \code{iterations} : number of iterations performed by the Fisher-scoring algorithm.
       \item \code{estcoef} : a data frame that contains the estimated model coefficients, standard errors, t-statistics, and p-values of each coefficient.
       \item \code{refvar} : estimated random effects variance.
       \item \code{cluster.information} : a data frame containing average random effects of sampled domain in each cluster.
     }
   \item{components}{a data frame containing the following columns:}
     \itemize{
       \item \code{random.effects} : estimated random effect values of the fitted model.
       \item \code{residuals} : residuals of the fitted model.
       \item \code{status} : status of corresponding domain, whether sampled or non-sampled.
     }
   \item{mse}{a data frame containing estimated MSE of the estimators.}
     \itemize{
       \item \code{PC} : estimated MSE of plugin (PC) estimators.
       \item \code{status} : status of domain, whether sampled or non-sampled.
     }
}
\description{
This function gives the MSE of transformed EBLUP based on a univariate Fay-Herriot model. For sampled domains, MSE is estimated using modified parametric bootstrap approach proposed by Butar & Lahiri. For non-sampled domains, MSE is estimated using modified approach proposed by Haris & Ubaidillah.
}
\examples{
\dontrun{
## Load dataset
data(datasaeu.ns)

## If data is defined
Fo = y ~ x1 + x2
vardir = "vardir"
MSE.ns <- mseFH.ns.uprop(Fo, vardir, data = datasaeu.ns)

## If data is undefined (and option for cluster arguments)
Fo = datasaeu.ns$y ~ datasaeu.ns$x1 + datasaeu.ns$x2
vardir = datasaeu.ns$vardir

### "auto"
MSE.ns1 <- mseFH.ns.uprop(Fo, vardir, cluster = "auto")

### number of clusters
MSE.ns2 <- mseFH.ns.uprop(Fo, vardir, cluster = 2)

### vector containing cluster for each domain
MSE.ns3 <- mseFH.ns.uprop(Fo, vardir, cluster = datasaeu.ns$cluster)

## See the estimators
MSE.ns$mse
}

}
