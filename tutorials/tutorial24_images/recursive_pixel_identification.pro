; sum_image is a recursive function to sum all pixels in an image
; It requires 4 inputs:
; x - the starting X position
; y - the starting Y position
; image - the image to sum
; mask - a mask where *0* represents un-visited locations and *1*
;       represents visited locations (note that this is OPPOSITE
;       of the star mask!)
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

; unmask_star is a recursive function that, given a starting position,
; will find all neighboring positions for which the mask value is 1 and
; set them to `unmask_value` (which is 0 if you don't give it)
; x,y - starting x,y positions
; mask - the array mask to modify.  Pixels with 1's are "good" values, pixels
;        with 0's are "hidden" values
; unmask_value - an integer.  Each pixel corresponding to the star will be set
;                to this number
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

; get_values is a modified version of sum_image
; Instead of *summing* all pixels, it returns an array
; with the *values* of all pixels.  
;
; It's not a very useful function, but it shows you how you can modify
; sum_image to return *values* instead of *sums of values*
;
; Also, in this case, mask=0 means "hidden" and mask=1 means "still need to add this"
function get_values,x,y,image,mask
    imsize = size(image,/dim)
    if x ge imsize[0] then return,0
    if y ge imsize[1] then return,0
    if mask[x,y] eq 0 then return,0
    mask[x,y] = 0
    return,[get_values(x+1,y,image,mask),$
           get_values(x,y+1,image,mask),$
           image[x,y]]
end
