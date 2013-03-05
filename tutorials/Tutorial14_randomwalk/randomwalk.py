import numpy as np

def random_step(seed=None):
    """
    Take a random step of length 1

    Parameters
    ----------
    seed : None or int
        The random seed to use.  Set this to a number if you want a
        reproduceable random number

    Returns
    -------
    step_x,step_y : float,float
        The steps in the x and y directions
    """
    np.random.seed(seed)
    step_angle = np.random.random() * np.pi * 2
    step_x = np.cos(step_angle)
    step_y = np.sin(step_angle)
    return step_x, step_y

def test_random_step(tolerance=1e-8, number_of_seeds=10):
    """
    Test function to ensure that random_step returns a step of size 1

    Performs the test for number_of_seeds seeds

    It also prints out some interesting info about the floats
    """
    for ii in xrange(number_of_seeds):
        assert np.abs(np.sum( np.array(random_step(ii))**2 ) - 1) < tolerance
        if np.sum( np.array(random_step(ii))**2 ) == 1:
            print "Exact!"
        else:
            print np.abs(np.sum( np.array(random_step(ii))**2 ) - 1)

def random_walk(xpos, ypos, nsteps, seed=None, stepsize=1, plot=False):
    """
    Take N steps in independent random directions
    Start somewhere, report where you end up

    *NOTE: stepsize and plot are not currently used!  That is left as an
    exercise to set up!*

    Parameters
    ----------
    xpos,ypos : float,float
        Starting X,Y positions
    nsteps : int
        number of steps
    seed : None or int
        starting random seed 
    stepsize : int
        size of steps (defaults to 1)
    plot : bool
        Plot the steps as they are taken?

    Returns
    -------
    xpos,ypos : float,float
        The final x and y positions of the random walk
    """

    for stepcount in xrange(nsteps):
        dx,dy = random_step(seed=seed)
        xpos += dx
        ypos += dy

    return xpos,ypos

def plot_step():
    """
    Plot a step from a random walk.

    HINT: plotting may require an additional import

    Parameters
    ----------
    Hmm, what does a plotter need to know about?

    Returns
    -------
    Does the plotter need to return something?
    """
    pass

# this is a commonly employed trick in python: whenever you run a program with
# %run file.py or execute('file.py'), the code that isn't in any function gets
# given the name __main__, so if you want code to run when %run'ing it, but not
# when you call 'import file.py', you use this if statement:
if __name__ == "__main__":
    # we now call the test code so that whenever you run this .py file, you get
    # to check if the code worked
    test_random_step()
    # the output should look like this:
"""
In [1]: %run randomwalk.py
Exact!
Exact!
Exact!
Exact!
Exact!
Exact!
Exact!
Exact!
Exact!
1.11022302463e-16
"""
