; test code for MKS units
; Prints "Pass" or "Fail" for each element in mks_units
pro test_mks_units

    ; make a hash storing the appropriate values
    tagvals = hash('au',1.496e11,$
                   'kmpersec',1e3,$      
                   'year',365L*24*3600,$      
                   'parsec',3.08567758e16)      

    OK = 0 ; Default to "not OK" in case first command fails

    ; make a nicely formatted table
    print,"Tag Name","Command","Value",format="(3A20)"
    foreach val,tagvals,tag do begin
        
        ; This is the command string.  You're writing
        ; a STRING that will contain valid IDL code!
        ; (hint: print your "command" and test it on the
        ; command line to make sure it works!)
        cmd = 'OK = [something]'+ tag +' eq '+string(val)

        ; Execute the command string, and store its pass/fail
        ; status in a variable
        ; The 1,1 indicate "QuietCompile" and "QuietExecute"
        ; That means that, if the command "cmd" fails, there
        ; will be no error message!  If you want to see the
        ; full error message(s), set these to 0
        test_status = execute(cmd,1,1)

        ; these next two lines of code use TERNARY operators!

        ; This first test tells you whether the "test code"
        ; (i.e., cmd) was OK: was it valid IDL?  Was there a 
        ; runtime error?
        msg1 = test_status ? "Passed" : "X Failed X"

        ; This second test tells you whether the "tag"
        ; had the right value.  This can be FAIL even if
        ; the code technically worked
        msg2 = OK ? "Passed" : "X Failed X"

        ; finally, print out the nicely formatted message
        print,tag,msg1,msg2,format="(3A20)"
    endforeach

end ; test_mks_units


