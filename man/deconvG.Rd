% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/g_model.R
\name{deconvG}
\alias{deconvG}
\title{Base function of G-modeling deconvolution}
\usage{
deconvG(tau, X, offset, family = c("Poisson", "Negative Binomial"),
  ignoreZero = F, zeroInflate = F, Z = NULL, Z0 = NULL, c0 = 1,
  NB.size = 100, only.value = F, pDegree = 5, aStart = 1,
  bStart = 0, gStart = 0, ...)
}
\arguments{
\item{tau}{log of the discrete points of the deconvolved distribution}

\item{X}{a vector of observed counts}

\item{offset}{a vector with the same length as \code{X}. See details}

\item{family}{family of the noise distribution, support either "Poisson" or "Negative Binomial" with known tuning parameter}

\item{ignoreZero}{whether ignore the zero count. If true, then use truncated Poisson / Negative Binomial distribution. Default is False}

\item{zeroInflate}{whether add zero inflation part to the deconvolved distribution to reflect transcriptional bursting. Default is True.}

\item{Z}{covariates for active intensity. Default is NULL.}

\item{Z0}{covariates for active fraction. Used only when zeroInflate is True. Default is NULL.}

\item{c0}{the tuning parameter on the L2 penalty term. Default is 1. c0 will be selected automatically in \code{deconvSingle}}

\item{NB.size}{over-dispersion parameter when the family is Negative Binomial: mu = mu + mu^2/size}

\item{only.value}{whether not to compute the estimation statistics but only the value of the optimized lieklihood. Used for likelihood ratio test.}

\item{pDegree}{the degree of the Spline matrix. Default is 5.}

\item{aStart, bStart, gStart}{initial values of the density parameters, the coefficients of Z0 and coefficients of Z}

\item{...}{extra parameters for the \code{\link[stats]{nlm}} function}
}
\value{
a list with elements
\item{stats}{a list of two elements. One is the \code{mat.dist}, which is the matrix of the estimated distribution. The other is \code{mat.coef}, which is the matrix of the coefficients of Z and Z0}
\item{mle}{the estimated parameters of the the density function}
\item{mle.g}{the estimated coefficients of Z}
\item{value}{the optimized penalized negative log-likelihood value}
\item{S}{the fake information proportion}
\item{cov}{the covariance of the parameters}
\item{bias}{the bias of the parameters}
\item{cov.g}{the covaraince of the estimated density points}
\item{cov.g.gamma}{the covariance between the estimated density points and the coefficient of Z}
\item{loglik}{the objective function being optimized}
\item{statsFunction}{the function computing the relavant statistics}
}
\description{
Base function used by \code{\link{deconvSingle}} to deconvolve the underlying distribution. 
We assume X ~ F(T) where F is the noise distribution. We assume that 
\deqn{log(T) = offset + \gamma Z + \epsilon}
\deqn{P(T = 0) = \beta_0 + \beta_1 Z0}
The goal is the recover the distribution of exp(log(T) - offset - gamma Z), which has density g and is discretized at exp(tau) (add 0 when zero inflation is allowed). There can be some warning messages for the optimization process, which can be ignored.
}
\note{
This is an extension of the G-modeling package
}
\examples{

X <- rpois(1000, 0.2 * 3)
lam.max <- quantile(X[!X == 0], probs = c(0.98))/0.2
tau <- seq(0, lam.max, length.out = 51)[-1]

Z <- rnorm(1000)

result <- deconvG(log(tau), X, zeroInflate = TRUE,
                     Z = Z,
                     Z0 = Z,
                     offset = rep(log(0.2), 1000))

}
