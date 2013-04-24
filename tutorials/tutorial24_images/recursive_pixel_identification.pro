function sum_image,x,y,image,mask
    imsize = size(image,/dim)
    if x ge imsize[0] then return,0
    if y ge imsize[1] then return,0
    if mask[x,y] eq 1 then return,0
    mask[x,y] = 1
    return,sum_image(x+1,y,image,mask)+$
           sum_image(x,y+1,image,mask)+$
           image[x,y]
end

function sum_image_withplots,x,y,image,mask,fig,maskfig
    imsize = size(image,/dim)
    ;print,x,y,imsize,mask[x,y]
    if x ge imsize[0] then return,0
    if y ge imsize[1] then return,0
    if mask[x,y] eq 1 then return,0
    mask[x,y] = 1
    if x mod 8 eq 0 and y mod 8 eq 0 and y gt 0 then begin
        maskfig.hide = 1
        maskfig = image(congrid(mask+150,512,512),overplot=fig,rgb_table=13,transparency=0.5)
    endif
    return,sum_image_withplots(x+1,y,image,mask,fig,maskfig)+sum_image_withplots(x,y+1,image,mask,fig,maskfig)+image[x,y]
end

pro unmask_star,x,y,mask,unmask_value
    if n_elements(unmask_value) eq 0 then unmask_value = 0
    imsize = size(mask,/dim)
    if x ge imsize[0] then return
    if y ge imsize[1] then return
    if mask[x,y] ne 1 then return
    mask[x,y] = unmask_value
    unmask_star,x+1,y,mask,unmask_value
    unmask_star,x-1,y,mask,unmask_value
    unmask_star,x,y+1,mask,unmask_value
    unmask_star,x,y-1,mask,unmask_value
    return
end
