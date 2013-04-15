; This document contains a series of examples we did in lecture
; Journal this file!
; You can copy & paste each code block, but don't do more than one code-block
; at a time
; (code blocks are separated by blank lines)


.full_reset_session ; just to make sure we're starting fresh
; load up some function definitions we need
.r  lecture23_functions.pro

x = findgen(50)/49*10.
y = 2.5 * x + 1.2
p1 = plot(x,y)
p2 = plot(x,y,symbol='s',overplot=p1)
noise = randomn(seed, n_elements(y))
noisy_flux = y + noise

p1.putdata,x,noisy_flux
p1.symbol='o'
p1.sym_size=0.3
p1.linestyle=''
p1.xtitle = "Time"
p1.ytitle = "Flux"
p2.hide = 1

p = linfit(x,noisy_flux)
p = poly_fit(x,noisy_flux,1)
print,p

p1.putdata,x,noisy_flux
p1.symbol='o'
p1.sym_size=0.3
p1.linestyle=''
p1.xtitle = "Time"
p1.ytitle = "Flux"
p3 = plot(x,p[1]*x+p[0],color='r',overplot=p1)

p3.hide=1
p4 = plot(x,poly(x,p),color='r',overplot=p1)

p4.hide=1
noisy_flux = y+noise*10
p = poly_fit(x,noisy_flux,1)
p1.putdata,x,noisy_flux
p2 = plot(x,poly(x,p),color='r',overplot=p1,name="Best Fit")
p3 = plot(x,2.5*x+1.2,color='b',linestyle='--',overplot=p1,name="Input Model")

p_legend = legend(target=[p2,p3]) 

errp = errorplot(x,noisy_flux,replicate(10,n_elements(x)),$
    linestyle='', symbol='o', sym_size=0.3, xtitle='Time', ytitle='Flux')
errp2 = plot(x,poly(x,p),color='r',overplot=errp,name="Best Fit")
errp3 = plot(x,2.5*x+1.2,color='b',linestyle='--',overplot=errp,name="Input Model")
p_legend = legend(target=[errp2,errp3]) 


x = findgen(50)/49. * 2 * !pi
y = sin(x)
curvepl = plot(x,y,color='b')

noise = randomn(seed,n_elements(x))
noisy_flux = y + noise
noisypl = plot(x,noisy_flux,color='k', symbol='o', sym_size=0.3, overplot=curvepl, linestyle='', sym_filled=1)


errorbars = replicate(1.,n_elements(x))
guesses = [0.,0.]
params = mpfitfun("shifted_sin",x,noisy_flux,errorbars,guesses)
fitpl = plot(x,shifted_sin(x,params), color='r', overplot=curvepl)


t = findgen(50)/49.*(10-0.1)+0.1
a = 1.5
b = 2.5
z = a*t^b 
plpl = plot(t,z,color='b',name='Input')

y = alog(z)
x = alog(t)
logplpl = plot(x,y,color='b',xtitle='log(t)',ytitle='log(z)')

noisy_z = z + randomn(seed,n_elements(z))*10
noisyplpl = plot(t,noisy_z,color='k',symbol='o',sym_size=0.3,overplot=plpl,linestyle='',sym_filled=1,name='Noisy Data')

noisy_y = alog(noisy_z)
noisylogplpl = plot(x,noisy_y,color='k',symbol='o',sym_size=0.3,overplot=logplpl,linestyle='',sym_filled=1)

; try the bad polyfit
pars = poly_fit(x,noisy_y,1)
print,pars 
; they're nan

OK = finite(noisy_y)
whok = where(ok,nok)
print,"There are ",nok," OK values"
masked_noisy_y = noisy_y[whok]
masked_x = x[whok]
pars = poly_fit(masked_x,masked_noisy_y,1)

fitted_y = poly(x,pars)
fitlogplpl = plot(x,fitted_y,color='r',linestyle='--',overplot=logplpl)

fitted_z = exp(fitted_y)
fitplpl = plot(t,fitted_z,color='r',linestyle='--',overplot=plpl,name='loglog polyfit')


errorbars = replicate(10.,n_elements(t))
guesses = [0.,0.]
pars = mpfitfun("powerlaw",t,noisy_z,errorbars,guesses)
mpfitplpl = plot(t,powerlaw(t,pars),color='g',linestyle='__',thick=3,overplot=plpl,name='mpfit')

plpl_legend = legend(target=[plpl,noisyplpl,fitplpl,mpfitplpl]) 
