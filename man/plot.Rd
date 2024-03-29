% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/XPSClass.r
\name{plot}
\alias{plot}
\title{'plot' function to plot XPSCoreLine or XPSSample objects}
\usage{
plot(x, y, ...)

plot(x, y, ...)
}
\arguments{
\item{x}{XPSSample}

\item{y}{(not used) Xdata, Ydata are contained in the XPSSample object}

\item{...}{further parameters to the plot function}
}
\description{
S4method 'plot' function to plot objects of class XPSCoreLine or XPSSample objects.
  The normal way to plot \code{XPS} objects is to use the \code{plot} method.
  In the case of \code{XPSCoreLine} object it is a wrapper for
  \code{\link{matplot}}. The data are transformed to \code{matrix} for \code{\link{matplot}}
  unprocessed CoreLine. For processed one it plots the RegionToFit defined by
  the Boundaries extremes, the baseline, any FitComponent and Fit if they are present.

function plot for objects of class 'XPSSample'
}
\seealso{
\code{\link{matplot}}, \code{\link{par}}
}
