; random step
; Take a step in a random direction
; INPUTS:
;   seed : random seed
; OUTPUTS: 
;   step_x, step_y: step length in x, y direction

pro random_step,seed,step_x,step_y
    step_angle = randomu(seed) * !pi * 2
    step_x = cos(step_angle)
    step_y = sin(step_angle)
end ; random_step

; If you want the code to "automatically" run its own tests when you do 
; .run random_step.pro
; then add this at the end:
test_random_step
end
; It should show this:
; IDL> .r random_step
; % Compiled module: RANDOM_STEP.
; % Compiled module: $MAIN$.
;   5.96046e-08
; Exact!
; Exact!
; Exact!
;   1.19209e-07
; Exact!
;   1.19209e-07
;   1.19209e-07
;   5.96046e-08
;   1.19209e-07

; if you don't want the tests to run (because they print out too much junk to
; the screen), use .compile instead, and it will just show this:
; IDL> .com random_step
; % Compiled module: RANDOM_STEP.
; % Compiled module: $MAIN$.
