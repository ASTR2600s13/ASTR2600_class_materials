

; Read a binary tree in sorted order into an array
function traverse_tree,binary_tree
    if binary_tree eq !null then return,[]
    return,[traverse_tree((*binary_tree).left,nsteps),$
            (*binary_tree).data,$
            traverse_tree((*binary_tree).right,nsteps)]
end

; Add new data onto a binary tree in sorted order
pro add_to_tree,binary_tree,data
    if binary_tree eq !null then return
    if (*binary_tree).data gt data then begin
        if (*binary_tree).left eq !null then begin
            (*binary_tree).left = ptr_new({binary_tree})
            (*(*binary_tree).left).data = data
        endif else begin
            add_to_tree,(*binary_tree).left,data,nsteps
        endelse
    endif else begin
        if (*binary_tree).right eq !null then begin
            (*binary_tree).right = ptr_new({binary_tree})
            (*(*binary_tree).right).data = data
        endif else begin
            add_to_tree,(*binary_tree).right,data,nsteps
        endelse
    endelse 
end
