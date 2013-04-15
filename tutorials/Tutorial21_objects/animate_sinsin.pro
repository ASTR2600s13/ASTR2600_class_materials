nframes = 360+180
width = 50
height = 50
fps = 30

x = indgen(width) # replicate(1,height) * (2*!pi/width)
y = indgen(width) ## replicate(1,height) * (2*!pi/height)

; Create a new "Output Video" file
outputVid = IDLffVideoWrite('sinsin_anim.avi')

surf = SURFACE(sin(2*x)*sin(y), x, y, /BUFFER, DIMENSIONS=[width,height])

vidStream = outputVid.AddVideoStream(width, height, fps)
 
FOR iframe = 0, nframes do begin
    print,iframe
    if iframe lt 360 then begin
        surf.Rotate, 1, /YAXIS
    endif else begin
        surf.Rotate, 1, /ZAXIS
    endelse
    frame = surf.CopyWindow()
    !NULL = outputVid.Put(vidStream, frame)
ENDFOR
 
outputVid.Cleanup

end
