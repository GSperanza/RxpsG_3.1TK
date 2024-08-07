% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/XPSClass.r
\docType{class}
\name{XPSCoreLine-class}
\alias{XPSCoreLine-class}
\alias{plot,XPSSample,missing-method}
\title{Class "XPSCoreLine"}
\usage{
\S4method{plot}{XPSSample,missing}(x, reset = TRUE, ...)
}
\arguments{
\item{x}{an object of class XPSSample}

\item{reset}{logical if TRUE the reset of the graphical device is made}

\item{...}{further parameters to the plot function}
}
\description{
The package provides a class for XPS spectra (class \code{XPSCoreLine}) and
 lists of such objects (class \code{XPSSample}). \code{XPSCoreLine} are values
 pairs stored in a \code{list} and several additional parameters stored in
 slots.

definition of method plot for objects of class XPSSample
}
\section{Slots}{

\describe{
\item{\code{.Data}}{contains the x,y spectral data}

\item{\code{RegionToFit}}{the portion of the spectrum to fit}

\item{\code{Baseline}}{the Baseline applied to subtract background}

\item{\code{Components}}{the fitting components}

\item{\code{Fit}}{the best fit}

\item{\code{RSF}}{the relative sensitivity factor associated to the element spectrum}

\item{\code{Shift}}{the energy correction shift if charging present}

\item{\code{Boundaries}}{the values of the RegionToFit edges}

\item{\code{units}}{the adopted units: kinetic/binding energy, counts/counts_per_second}

\item{\code{Flags}}{logical}

\item{\code{Info}}{information regarding the spectrum acquisition}

\item{\code{Symbol}}{symbol of the element associated to the spectrum}
}}

\examples{
\dontrun{
  test <- new("XPSCoreLine", Info="test", units=c("Binding [eV]", "Counts"))
}
\dontrun{
  plot(XPSSample)
}
}
\keyword{classes}
