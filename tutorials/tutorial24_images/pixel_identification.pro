!PATH=expand_path('/Users/adam/repos/astron/pro/') + ":" +!PATH

img1 = readfits('img1.fits')

mask1 = intarr(size(img1,/dim))
print,"Opened image data, made image mask"
stop

fig1 = image(congrid(img1,512,512))
print,"Loaded images"
stop

print,sum_image(0,0,img1,mask1)
print,total(img1)
;print,sum_image_withplots(0,0,img1,mask1,fig1,fig2)

mask2 = img1 gt 0.01
fig3 = contour(congrid(mask2,512,512,/interp), overplot=fig1, rgb_table=13)

stop
print,"Total of mask before unmasking: ",total(mask2)
unmask_star,102,77,mask2
print,"Total of mask after unmasking: ",total(mask2)
fig3.setdata,congrid(mask2,512,512,/interp)


stop
print,"Total of mask before unmasking: ",total(mask2)
unmask_star,30,106,mask2
print,"Total of mask after unmasking: ",total(mask2)
fig3.setdata,congrid(mask2,512,512,/interp)

stop
print,"How do you find the brightest star?"
print,"The brightest pixel in the image is: ",max(img1,argmax)
print,"It is at coordinates ",array_indices(img1,argmax)
stop
print,"The brightest pixel in the masked part of the image is: ",max(img1*mask2,argmax)
print,"It is at coordinates ",array_indices(img1,argmax)

stop
while total(mask2) gt 0 do begin
    brightest = max(img1*mask2, argmax)
    xy = array_indices(img1,argmax)
    x=xy[0]
    y=xy[1]
    print,"Unmasking star at ",x,y
    unmask_star,x,y,mask2
    fig3.setdata,congrid(mask2,512,512,/interp)
endwhile

stop
; in this example, the mask becomes a label map instead
mask3 = img1 gt 0.01
starnum = 2
fig3.setdata,congrid(mask3,512,512,/interp)
while total(mask3 eq 1) gt 0 do begin
    brightest = max(img1*(mask3 eq 1), argmax)
    xy = array_indices(img1,argmax)
    x=xy[0]
    y=xy[1]
    print,"Unmasking star at ",x,y
    unmask_star,x,y,mask3,starnum
    fig3.setdata,congrid(mask3,512,512,/interp)
    starnum += 1
endwhile

end

