nn = 500
window,1,xsize=nn,ysize=200
plot,[0],[0],xrange=[0,1],yrange=[0,1],/nodata
for ii=0,nn-1 do begin
    color_convert,ii*360L/float(nn),1,1,r,g,b,/hsv_rgb
    oplot,[ii/float(nn),ii/float(nn)],[0,1],color=r+g*256L+b*256L^2L
endfor
wset,0
end
