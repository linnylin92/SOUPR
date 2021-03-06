% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils_plot.R
\name{getPermute}
\alias{getPermute}
\title{Permute labels}
\usage{
getPermute(est.label, true.label)
}
\arguments{
\item{est.label}{a vector of estimated clusters, containing {1, ..., K}}

\item{true.label}{a vector of reference/true labels}
}
\value{
A vector of length K, i.permute, 
such that the i-th reference cluster maps to i.permute[i] in estimated clusters.
}
\description{
Permute the estimated labels to be consistent with the reference labels.
}
