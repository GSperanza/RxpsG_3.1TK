#function to provide the list of fitting components and relative abundance for the selected coreline

#' @title  XPSFitInfo
#' @description XPSFitInfo Provides information about a Core Line fit
#'   Makes the computation of the integral intensity of each of the fitting components
#'   of a given coreline. The sum of the component integral intensities =100% (it is the
#'   best fit integral intensity).
#' @return XPSFitInfo returns a table summarizing the area, FWHM, RSF, BE, % for
#'   each of the fit components if the active CoreLine
#' @examples
#' \dontrun{
#' 	XPSFitInfo()
#' }
#' @export
#'


XPSFitInfo <- function(){

   info <- function(CoreLine){
      CompNames <- names(CoreLine@Components)
      maxNchar <- 0   
      sumCoreLine <- 0
      N_comp <- length(CoreLine@Components) #number of fit components
cat("\n FitInfo NComp", N_comp)


      sumComp <- array(0,dim=N_comp)       #define a dummy vector of zeros
      RSF  <-  FName[[Indx]]@RSF 
      E_stp  <-  abs(FName[[Indx]]@.Data[[1]][2]-FName[[Indx]]@.Data[[1]][1]) #energy step

      if (N_comp==0) {
#--- solo Baseline No Fit ---
         sumCoreLine <- sum(FName[[Indx]]@RegionToFit$y-FName[[Indx]]@Baseline$y)*E_stp #Area of the Coreline NOT normalized for the sensitivity factor
         txt <- as.character(sumCoreLine)
         maxNchar <- nchar(txt)
         if (length(FName[[Indx]]@Baseline)>0 ){ #Baseline is defined
            txt <- paste("\n   File Name:", FName@Filename)  #Filename
            CellBord <- ""
            cell <- printCell("label",txt,CellBord,nchar(txt),"left")  #call celprint in LABEL mode
            area <- sprintf("%1.2f",sumCoreLine)  #print area Coreline in formatted way (2 decimals)
            txt <- paste(FName[[Indx]]@Symbol,"peak area: ", area, sep=" ")
            totLgth <- nchar(txt)
            cell <- printCell("separator", "-",CellBord,totLgth-5,"left")  #call celprint in SEPARATOR mode
            cat("\n",cell)
            CellBord <- "|"
            cell <- printCell("label",txt,CellBord,totLgth,"center")
            cat("\n",cell)
            return()
         }

      } else {
         fnName <- sapply(FName[[Indx]]@Components, function(x)  x@funcName) #was VBtop analysis performed on coreline?
         if ("VBtop" %in% fnName){
            lgth <- c(12, 10, 8, 7, 8, 9) #lunghezza varie celle riga tabella
            totLgth <- sum(lgth)
            cat("\n")
            CellBord <- "|"
            txt <- paste("   File Name:", FName@Filename)  #Filename
            cell <- printCell("label",txt,CellBord, totLgth,"left")
            cat("\n",cell)
            txt <- "-"   #separator
            cell <- printCell("separator",txt,CellBord,totLgth,"left")
            cat("\n",cell)

            if (FName[[Indx]]@Flags[1]==TRUE){
               txt <- c("Components", "Area(cps)", "FWHM", "RSF", "BE(eV)", "TOT.(%)")    #Table names
            } else {
               txt <- c("Components", "Area(cps)", "FWHM", "RSF", "KE(eV)", "TOT.(%)")    #Voci Tabella
            }
            lgth <- c(12, 10, 8, 7, 8, 9)
            cell <- printCell("tableRow",txt,CellBord,lgth, "center")  #call celprint in tableRow mode
            cat("\n",cell)
            txt <- "-"  #separator
            cell <- printCell("separator", txt,CellBord,totLgth,"left")
            cat("\n",cell)
            for(jj in 1:N_comp){ #jj runs on the fit components
               Area <- "//"
               FWHM <- "//"
               RSF <- "//"
               BE <- "//"
               if (FName[[Indx]]@Components[[jj]]@funcName=="VBtop"){
                   BE <- sprintf("%1.2f",CoreLine@Components[[jj]]@param[1,1]) #Component BE
                   CompNames[jj] <- paste(CompNames[jj], "VBtop", sep=" ")
               }
               Conc <- "//"
               txt <- c(CompNames[jj], Area, FWHM, RSF, BE, Conc) #compongo la stringa da stampare
               lgth <- c(12, 10, 8, 7, 8, 9) #lunghezza varie celle riga tabella
               cell <- printCell("tableRow",txt,CellBord,lgth, "center") #stampo nella modalita' TABLEROW
               cat("\n",cell)
            }
         } else if ("   ARXPS_Profile" %in% fnName) {
            cat("\n", FName@Filename)
            CellBord <- "|"
            txt <- paste("   File Name:", FName@Filename)  #Filename
            totLgth <- nchar(txt)
            cell <- printCell("label",txt,CellBord, totLgth,"left")
            cat("\n",cell)
            txt <- "-"   #separator
            cell <- printCell("separator",txt,CellBord,totLgth,"left")
            cat("\n",cell)
            txt <- "ARXPS Profile: "    #Table name
            cell <- printCell("label",txt,CellBord,totLgth,"left")
            cat("\n",cell)
            Thickness <- round(FName[[Indx]]@Components[[1]]@param[[4]][1], 3)
            txt <- paste("Film Thickness:", Thickness)  #param[["Fit"]] = film thickness
            cell <- printCell("label",txt,CellBord,totLgth,"left")
            cat("\n",cell)
         } else {
#--- Fit Quantification ---
            sumCoreLine <- sum(FName[[Indx]]@Fit$y)*E_stp  #Fit Contribution not corrected fro the sensitivity factor
            txt <- as.character(sumCoreLine)
            maxNchar <- nchar(txt)
            for(jj in 1:N_comp){    #jj runs on the fit components
               sumComp[jj] <- sum(FName[[Indx]]@Components[[jj]]@ycoor-FName[[Indx]]@Baseline$y)*E_stp #Contributo Componente Fit as acquired non corretto per RSF
            }

            if (11 > maxNchar) { maxNchar <- 11 }  #maxNchar = number among area values is computed
                                            #if maxChar > 11 then 11 is selected.
            lgth <- c(12, maxNchar, 8, 8, 7, 9)  #number of char reserved for "Components", "Area", ", FWHM", "BE(eV)", "RSF", "TOT%"
            totLgth <- sum(lgth)
            cat("\n")
            CellBord <- "|"
            txt <- paste("   File Name:", FName@Filename)  #Filename
            cell <- printCell("label",txt,CellBord, totLgth,"left")
            cat("\n",cell)
            txt <- "-"   #separator
            cell <- printCell("separator",txt,CellBord,totLgth,"left")
            cat("\n",cell)

            if (FName[[Indx]]@Flags[1]==TRUE){
               txt <- c("Components", "Area(cps)", "FWHM", "RSF", "BE(eV)", "TOT.(%)")    #Table names
            } else {
               txt <- c("Components", "Area(cps)", "FWHM", "RSF", "KE(eV)", "TOT.(%)")    #Voci Tabella
            }
            lgth <- c(12, maxNchar, 8, 7, 8, 9)
            cell <- printCell("tableRow",txt,CellBord,lgth, "center")  #call celprint in tableRow mode
            cat("\n",cell)
            txt <- "-"  #separator
            cell <- printCell("separator", txt,CellBord,totLgth,"left")
            cat("\n",cell)

            ClName <- FName[[Indx]]@Symbol
            Area <- sprintf("%1.2f", sumCoreLine)
            RSF <- sprintf("%1.3f",FName[[Indx]]@RSF)
            Conc <- sprintf("%1.2f",100)
            txt <- c(ClName, Area, " ", RSF, " ", Conc )  #total concentration associated to the CoreLine. FWHM e BE are not printed
            lgth <- c(12, maxNchar, 8, 7, 8, 9)
            cell <- printCell("tableRow", txt,CellBord,lgth, "center")
            cat("\n",cell)

            for(jj in 1:N_comp){ #jj runs on the fit components
               Area <- sprintf("%1.2f",sumComp[jj]) #area componente jj linea di core ii
               if (fnName[jj] == "GaussLorentzProd" ||
                   fnName[jj] == "GaussLorentzSum" ||
                   fnName[jj] == "AsymmGauss" ||
                   fnName[jj] == "AsymmLorentz" ||
                   fnName[jj] == "AsymmVoigt" ||
                   fnName[jj] == "AsymmGaussLorentz" ||
                   fnName[jj] == "AsymmGaussVoigt" ||
                   fnName[jj] == "AsymmGaussLorentzProd" ||
                   fnName[jj] == "DoniachSunjicGauss" ||
                   fnName[jj] == "DoniachSunjicGaussTail" ){
                   FWHM <- ComponentWidth(FName[[Indx]], jj)
                   FWHM <- sprintf("%1.2f",FWHM) #FWHM componente jj
               } else {
                   FWHM <- sprintf("%1.2f",FName[[Indx]]@Components[[jj]]@param["sigma", "start"]) #FWHM componente ii
               }
               RSF <- sprintf("%1.3f",FName[[Indx]]@Components[[jj]]@rsf) #RSF componente ii
               BE <- sprintf("%1.2f",FName[[Indx]]@Components[[jj]]@param["mu","start"]) #BE componente ii
               Conc <- sprintf("%1.2f",100*sumComp[jj]/sumCoreLine)  #Concentrazione componente ii
               txt <- c(CompNames[jj], Area, FWHM, RSF, BE, Conc) #compongo la stringa da stampare
               lgth <- c(12, maxNchar, 8, 7, 8, 9) #lunghezza varie celle riga tabella
               cell <- printCell("tableRow",txt,CellBord,lgth, "center") #stampo nella modalita' TABLEROW
               cat("\n",cell)
            }
            txt <- " "  #separatore
            cell <- printCell("separator",txt,CellBord,totLgth,"left")
            cat("\n",cell)
         }
      }
      return()
   }



#----- variabili -----
   FName <- NULL
   activeFName <- get("activeFName", envir = .GlobalEnv)
   if (length(activeFName)==0 || is.null(activeFName) || is.na(activeFName)){
       tkmessageBox(message="No data present: please load and XPS Sample", title="XPS SAMPLES MISSING", icon="error")
       return()
   }
   activeFName <- get("activeFName", envir = .GlobalEnv)
   FName <- get(activeFName, envir = .GlobalEnv)
   Indx <- get("activeSpectIndx", envir = .GlobalEnv)
   activeSpectName <- get("activeSpectName", envir = .GlobalEnv)
   txt <- paste(activeSpectName, "Coreline Fit Info: ", sep=" ")
   cat("\n", txt)
   info(FName[[Indx]])
}
