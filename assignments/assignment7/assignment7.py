"""
Just like in the IDL part of the assignment, you need to fix a series of bugs
in the code.  However, unlike the IDL code, if you do
%run assignment7.py
it will crash until you've gotten *everything* right.
This means you can work on this code mostly in order, though you may have to
jump around a little to deal with function definitions

An important note: There are no errors in the "assert" statements.  
np.all(something) returns True if ALL elements of the array "something" are True,
and false otherwise.  
the 'assert' statement does nothing if it's given True and crashes otherwise:
    assert True # does nothing
    assert False # crashes

Remember to include the time spent on this in your commit message
"""
import numpy as np

# Identify the error in a comment and fix it
def square():
    return x**2

# This code should make zz into an array like this:
# [0, 1, 4, 9, 16, 25, 36, 49, 64]
# Add a comment indicating what the error is, then correct the error
zz = []
for ii in xrange(8):
    zz.append(ii**2)
assert np.all(zz == np.array([0, 1, 4, 9, 16, 25, 36, 49, 64]))

# This function is just like the coordinatearray function you made in IDL 
# It contains a bug: determine what that bug is, add a comment stating what the
# bug is, and fix it
# Note that test_coordinatearray below does *not* contain a bug, so you can use it
def coordinatearray(xmin,xmax,nsteps):
    arr = np.arange(nsteps,dtype='float')
    linarr = arr/nsteps-1*xmax-xmin + xmin
    return linarr

# This is the test code for coordinatearray: it is bug-free!
# (or so I assert, anyway)
def test_coordinatearray():
    assert np.all( coordinatearray(0,1,5) == np.linspace(0,1,5) )
    assert np.all( coordinatearray(2,1,5) == np.linspace(2,1,5) )

# There is a bug in this code
# Fix it, and report what the bug was
x = np.array([1,2,3,4])
xsqsum = np.sum(x^2)
assert xsqsum == (1+4+9+16)

# There is a bug in this code
# Fix it, and report what the bug was
y = [4.,3.,2.]
assert np.sum(y/2) == 4.5

test_coordinatearray()

