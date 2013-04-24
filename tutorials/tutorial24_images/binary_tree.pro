; binary tree structure definition
pro binary_tree__define
    dummy = {binary_tree,$
        left: ptr_new(),$
        right: ptr_new(),$
        data:0.0}
end

; Read a binary tree in sorted order into an array
; (and count how many steps it takes)
function traverse_tree,binary_tree,nsteps
    nsteps = nsteps + 1L
    if binary_tree eq !null then return,[]
    return,[traverse_tree((*binary_tree).left,nsteps),$
            (*binary_tree).data,$
            traverse_tree((*binary_tree).right,nsteps)]
end

; Add new data onto a binary tree in sorted order
; (and count how many comparisons are needed)
pro add_to_tree,binary_tree,data,nsteps
    nsteps = nsteps + 1L
    if binary_tree eq !null then return
    nsteps = nsteps + 1
    if (*binary_tree).data gt data then begin
        if (*binary_tree).left eq !null then begin
            (*binary_tree).left = ptr_new({binary_tree})
            (*(*binary_tree).left).data = data
        endif else begin
            add_to_tree,(*binary_tree).left,data,nsteps
        endelse
    endif else begin
        nsteps = nsteps + 1
        if (*binary_tree).right eq !null then begin
            (*binary_tree).right = ptr_new({binary_tree})
            (*(*binary_tree).right).data = data
        endif else begin
            add_to_tree,(*binary_tree).right,data,nsteps
        endelse
    endelse 
end

function binary_sort,input,nsteps
    bt=ptr_new({binary_tree})
    (*bt).data = input[0]
    nsteps = 0
    for ii=1,n_elements(input)-1 do begin 
        add_to_tree,bt,input[ii],nsteps
    endfor
    nsteps_traverse = 0
    r_sorted = traverse_tree(bt,nsteps_traverse)
    return,nsteps+nsteps_traverse
end


; A simple insertion sort
; The code looks complicated, but the idea is really simple:
; loop over each element in the intput, and compare it to each
; element in the output in turn.
; You start off with just one number and build up.   A simple example:
; unsorted = [3,1,5,2]
; 1: output = [3]
; 2: input = 1, output = 3, 1<3, so output = [input, 3
; 3: input = 5, output = [1,3], 5>1, 5>3, so output = [1,3,input]
; 4: input = 2, output = [1,3,5], 2>1, 2<3, so output = [1,input,2,5]
function insertion_sort,input,nsteps

    nsteps = 0L
    output = [input[0]]
    for ii=1,n_elements(input)-1 do begin
        elt = input[ii]
        if elt lt output[0] then begin 
            output=[elt,output]
            continue
        endif
        nout = n_elements(output)
        for jj=0,nout-1 do begin
            if elt le output[jj] then begin
                output=[output[0:jj-1],elt,output[jj:*]]
                break
            endif
            nsteps += 1
        endfor
        ; if it belongs at the end
        if nout gt ii+1 then stop
        if jj eq nout then output=[output,elt]
    endfor
    return,output
end

function is_sorted,x
    for ii=0,n_elements(x)-2 do begin
        if x[ii] gt x[ii+1] then return,0
    endfor
    return,1
end

