; spectrum.pro
;
; Draw a spectrum for use as an illustration in IDL book


; drawIt
;
; draw a spectrum in 3 phases
; First is a shaded rectangle that would look like a photo
; Second is a plot of the flux values
; Third is a plot of the attenuation near one absorption line
;
PRO drawIt

  Nx = 601   ; # of pixels in spectrum
  Ny = 50    ; # pixel height of drawn image


  ; get the values of the spectrum 
  forward_function mySpectrum
  lambda = 1300. + 60. * findgen(Nx)/(Nx-1)
  flux = mySpectrum(lambda)  


  ; create a 2D array and shade it in based on the spectrum values
  image = BYTSCL(flux)
  image = rebin( image, Nx, 50 )

  ; make a window that is a snug fit
  ; window, retain = 2, xsize = Nx, ysize = Ny

  ; display shaded spectrum
  tv, image
  write_jpeg, "spectrumImage.jpg", image
;   stop  ; DIAG


  ; plot the spectrum

  window, retain = 2, xsize = 1000, ysize = 500
  title = "Spectrum"
  xtitle = "Wavelength [Angstrom]"
  ytitle = "Flux [erg/s/cm^2/Angstrom]"

  ; multiply by 3e-14 to get y axes that looks realistic
  plot, lambda, flux * 3e-14, $   
        charsize = 2,  $
        title = title, xtitle = xtitle, ytitle = ytitle
    cgcolorfill, lambda,flux*3e-14,color='3366CC'x

  ;invertAndSave, "spectrumPlot"
   ;stop   ; DIAG


  ; plot the absorption

  title = "Absorption"
  ytitle = "Absorption [erg/s/cm^2/Angstrom]"

  ; multiply by 3e-14 to get y axes that looks realistic
  plot, lambda, (1. - flux) * 3e-14, $  
        xrange =  [1315., 1321.], yrange = [0., 3e-14], $
        charsize = 2,  $
        title = title, xtitle = xtitle, ytitle = ytitle

  invertAndSave, "absorptionPlot"


END   ; drawIt


; mySpectrum
;
; Return a simulated spectrum of flux values, flux(lambda)
; The spectrum has several absorption lines.
;
; INPUT
;  lambda - array of wavelength values for spectrum
;
FUNCTION mySpectrum, lambda

  ; compute the flux values - multiply several absorption lines
  forward_function absline
  flux = absLine( lambda, 1307.5, 0.2, 0.3 ) *  $
         absLine( lambda, 1311.0, 0.2, 0.6 ) *  $
         absLine( lambda, 1318.0, 0.6, 0.5 ) *  $
         absLine( lambda, 1323.0, 0.4, 0.3 ) *  $
         absLine( lambda, 1324.5, 0.4, 0.4 ) *  $
         absLine( lambda, 1330.0, 0.2, 0.9 ) *  $
         absLine( lambda, 1340.0, 2.0, 0.1 ) *  $
         absLine( lambda, 1348.0, 0.2, 0.1 ) *  $
         absLine( lambda, 1351.0, 0.2, 0.2 )

  ; Apply a random variation to final result
  flux += 0.015 * randomn( seed, n_elements(flux) )

  return, flux
END   ; mySpectrum




; Gauss
;
; A simple Gaussian function G(x; x0, sig, A)
; INPUT
;  x - the array of values
;  x0 - the center of the Guassian
;  sig - sigma, std dev of Gaussian
;  A - amplitude of Gaussian
;
FUNCTION Gauss, x, x0, sig, A
  y = A * exp( -(x-x0)^2 / (2*sig^2) )
  return, y
END  ; Gauss



; absLine
;  Returns values for a single absorption line based on a Gaussian model
;  Assumes continuum is 1 and returns a value from 0 to 1
; INPUT
;  x - the array of values
;  x0 - the center of the Guassian
;  sig - sigma, std dev of Gaussian
;  A - amplitude of Gaussian
FUNCTION absLine, x, x0, sig, depth

  y = 1. - gauss(x, x0, sig, depth)
  return, y

END  ; absLine

