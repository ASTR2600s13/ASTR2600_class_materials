; Draw an eyeball
; Make a "t" array for parametric eqns
tt = findgen(1000)/999. * 2 * !pi
; Build a circle:
; x^2 + y^2 = r^2, so 
; x = r cos(t), y=r sin(t)
rr = 0.25 ; radius of circle
xx = cos(tt)*rr ; cosine(t) * r
yy = sin(tt)*rr ; sine(t) * r

xo1 = 1.5
yo1 = 2.0

xo2 = 2.5
yo2 = 2.0

plot,xx+xo1,yy+yo1,xrange=[1,3],yrange=[1,3]
oplot,xx+xo2,yy+yo2

; add irises
rr = 0.15 ; radius of circle
xx = cos(tt)*rr
yy = sin(tt)*rr

oplot,xx+xo1,yy+yo1,thick=50,color='FF0000'x
oplot,xx+xo2,yy+yo2,thick=50,color='FF0000'x

; add pupils
rr = 0.05 ; radius of circle
xx = cos(tt)*rr
yy = sin(tt)*rr

oplot,xx+xo1,yy+yo1,thick=25,color='555555'x
oplot,xx+xo2,yy+yo2,thick=25,color='555555'x
