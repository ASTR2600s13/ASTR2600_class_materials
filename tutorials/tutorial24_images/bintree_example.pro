bt=ptr_new({binary_tree})
(*bt).data = 6
x = [1,0,2,3,4,9,5,7]
print,"x: ",x
nsteps = 0
for ii=0,n_elements(x)-1 do begin 
    add_to_tree,bt,x[ii],nsteps 
endfor
nsteps_traverse = 0
x_sorted = traverse_tree(bt,nsteps_traverse)
print,"sorted x:",x_sorted
print,"Required ",nsteps," to make the tree and ",nsteps_traverse," to traverse it"
print
stop

r = randomu(seed,100)
bt2=ptr_new({binary_tree})
(*bt2).data = r[0]
nsteps = 0
for ii=1,n_elements(r)-1 do begin 
    add_to_tree,bt2,r[ii],nsteps
endfor
print,"r: ",r
nsteps_traverse = 0
r_sorted = traverse_tree(bt2,nsteps_traverse)
print,"sorted r: ",r_sorted
print,"Required ",nsteps," to make the tree and ",nsteps_traverse," to traverse it"
print
stop

nsteps = 0L
print,"insertion sort for comparison"
print,"Did insertion sort work?",is_sorted(insertion_sort(r,nsteps))
print,"Took ",nsteps," comparisons"
stop

end
