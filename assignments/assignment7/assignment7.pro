; The code contained in this file is full of bugs and errors.  Your assignment
; is to fix them.  
;
; The first thing you *must* do is fix the compile-time errors.  Do not try to
; fix the other errors until the code compiles.  Add comments indicating the
; errors that you fixed.  When you have fixed the compilation errors, make sure
; you do a 'git commit'
;
; Note that this means you may have to work on the code out of order, i.e.
; debug something at the bottom, then at the top, then the middle.
;
; Then, once the code compiles, figure out what's wrong with the other
; functions.  You need to add comments indicating what the error was.
;
; This is debugging.  Good luck!
;
; Remember to include the time spent on this in your commit message


; function to square a value
; Add a comment indicating what the error is, then correct the error
function square
    return,x^2
end

; procedure to square a value
; Add a comment indicating what the error is, then correct the error
pro square,a
    return,a^2
end

; function to check if two floats are equal
; Give a case where this will *not* work, then fix it so that it
; will work in all cases
function check_equal,x,y
    return,(x-y) lt 1e-7
end

; Procedure to let a user pick 'a' or 'b' and print out their reply
; Identify the error(s) and correct it/them
pro choice

    read,"Enter a choice, 'a' or 'b':",choice
    if choice eq 'a' then begin
        print,"You picked a"
    endif else if choice eq 'b' then begin
        print,"You picked b"
    endif else begin
        print,"You picked neither a nor b"
    endelse
end

; Procedure that should print N numbers, where N is the input to the procedure
; The number should be different each time
; Identify the error(s) and correct it/them
pro print_numbers,number_of_numbers
    for ii=0,number_of_numbers do begin
        print,number_of_numbers
    endfor
end



; **Finish the first function before doing this one**
; the "message" procedure acts like a "print" plus "stop" statement, e.g.:
;  message,"Hi"
; is like doing:
;  print,"Hi"
;  stop
; Fix the following test:
pro test_square
    if square(2) ne 4 then message,'Oh no!  Square is broken!'
    if square(3) ne 9 then message,'Oh no!  Square is broken!'
    if square(9) ne 27 then message,'Oh no!  Square is broken!'
end
; The lesson here: if you're going to make tests for your code, you better make
; sure the tests are right!  There's nothing worse than having *correct* code
; but an *incorrect* test tricking you into thinking you made a mistake.

; Read some data from a file
; There is only one bug here, but it will prevent the code from compiling
filename = 'testfile.txt'
number_of_lines = file_lines(filename)
openr,lun,filename,/get_lun
for ii=0,number_of_lines do begin
    readf,lun,z
    if z mod 2 eq 0 then print,z," is even" $
    else print,z," is odd"
endfor
free_lun,lun

; Finally, some for loops.
; There is NO BUG here, but you need to:
; 1. Fix the indentation
; 2. Add a comment above each "print" statement stating the order in which it
; prints out (ignore the print,"" statemenths, though - just label the others
; as "; first","; second", and ";third"
for ii=0,2 do begin
for jj=2,0,-1 do begin
for kk=-2,2,2 do begin
if ii eq 0 and jj eq 1 then begin
print,kk,format="('kk:',I3,', ',$)"
if kk eq 2 then print,""
endif
endfor
if ii eq 2 then begin
print,jj,format="('jj:',I3,', ',$)"
if jj eq 0 then print,""
endif
endfor
if ii eq 1 then begin
print,ii,jj,kk,format="('ii:',I3,', jj:',I3,', kk:',I3)"
endif
endfor

; Just a call to a procedure defined above.   Is there a bug related to this?
test_square

