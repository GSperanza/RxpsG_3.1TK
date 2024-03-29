% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/XPSCnvDcnvTKGUI.r
\name{XPSCnvDcnv}
\alias{XPSCnvDcnv}
\title{XPSCnvDcnv concolution, deconvolution functions}
\usage{
XPSCnvDcnv(x, y, deco = FALSE)
}
\arguments{
\item{x}{array to convolve}

\item{y}{array to convolve}

\item{deco}{= FALSE convolution of X, Y arrays, TRUE deconvolution of Y from X}
}
\description{
XPSCnvDcnv() is used to calculate the convolution of 
  the two X, Y input arrays or deconvolve Y from X.
  deconvolution can be made using the fft and its inverse or the
}
\examples{
\dontrun{
 x <- c(4, 13, 28, 34, 32, 21)
 y <- c(1, 2, 3)
 C <- XPSCnvDcnv(x, y, deco=TRUE)
 print(C)
 [1]  4 5 6 7
}
}
