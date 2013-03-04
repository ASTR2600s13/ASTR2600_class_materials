; random walk
; Take N steps in independent random directions
; Start somewhere, report where you end up
; INPUTS:
;   xpos,ypos : Starting X,Y
;   nsteps : number of steps
;   seed : starting random seed 
;   stepsize : size of steps (defaults to 1)
pro random_walk,xpos,ypos,nsteps

    for stepcount=0,nsteps-1 do begin
        random_step,seed,dx,dy
        xpos += dx
        ypos += dy
    endfor ; steps
end ; random_walk


