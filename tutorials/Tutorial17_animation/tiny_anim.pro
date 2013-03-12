nframes = 100
imsize = 300
xinteranimate,set=[imsize,imsize,nframes],title='title',/showload

plot,[0,nframes*5],[0,nframes*5],/nodata,xstyle=4,ystyle=4
for iframe=0,nframes-1 do begin
    oplot,[iframe*5,0],[iframe*5,nframes*5]
    img = tvrd()
    xinteranimate, image=img, frame=iframe
endfor

xinteranimate,30
end



