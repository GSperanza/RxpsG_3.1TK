% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/XPSEShiftTKGUI.r
\name{XPSEshift}
\alias{XPSEshift}
\title{XPSEShift}
\usage{
XPSEshift()
}
\description{
XPSEshift function correct the energy scale of spectra
  affected by charging effects. Generally C1s from hydrocarbons at BE=285eV
  or Au4f 7/2 at BE=84eV  are chosen as reference peaks. Charges spectra are
  shifted forcing the reference spectra to fall at their correct BE position.
}
\examples{
 \dontrun{
	XPSEshift()
}
}
