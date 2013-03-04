;Test function to ensure that random_step returns a step of size 1
;Performs the test for number_of_seeds seeds
;It also prints out some interesting info about the floats
pro test_random_step,tolerance=tolerance, number_of_seeds=number_of_seeds
    if n_elements(tolerance) eq 0 then tolerance = 1e-8
    if n_elements(number_of_seeds) eq 0 then number_of_seeds = 10
    for ii=0,number_of_seeds-1 do begin
        random_step,seed,x,y
        ok = abs( x^2+y^2 - 1) lt tolerance
        if x^2+y^2 eq 1 then begin
            print,"Exact!"
        endif else begin
            print, abs(x^2+y^2 - 1)
        endelse
    endfor
end

