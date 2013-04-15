function shifted_sin,x,pars
    return,pars[0]*sin(x-pars[1])
end

function powerlaw,x,pars
    return,pars[0]*(x^pars[1])
end

