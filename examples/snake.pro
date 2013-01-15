spawn,'pwd',pwd
!PATH=!PATH+":"+pwd+"/coyote/"
;!PATH=!PATH+":coyote/"
x = findgen(1000) / 999. * 2 * !pi
red = ((randomu(seed)))*(2L^8L) 
green = ((randomu(seed1)))*(2L^8L)
blue = ((randomu(seed2)))*(2L^8L)
color = long(round(red+green*(2L^8L)+blue*(2L^16L)))

npts = 100
for ii=0,npts do begin
    newx = x+ii/float(npts)*2*!pi
    ;print,color,red,green,blue
    color = color + ii
    plot,newx,sin(newx),yrange=[-1,1],xrange=[0,4*!pi],/nodata
    oplot,newx,sin(newx),color=color,thick=6
    tvcircle,10.2,newx[-3],sin(newx[-1])+0.03,color,/fill
    tvcircle,10.075,newx[-1]+0.05,sin(newx[-1])+0.04,0,/fill
    wait,2/float(npts)
endfor
end
