; Instructions:
; Use the code below to determine realistic star locations, velocities, and masses.

; Probability distribution functions describing a cut-off power law
; (these are used to determine the locations of the stars - 
; you don't need to use them yourself)
function p_cluster, r, r0=r0, alpha=alpha
    if n_elements(r0) eq 0 then r0 = 1.
    if n_elements(alpha) eq 0 then alpha = 2.
    C = r0^(alpha-1)/(1-1./alpha)
    prob = C/r0^alpha * (r le r0) + C/r^alpha * (r gt r0)
    return, prob
end

; CDF of the stellar distribution function
function c_cluster, r, r0=r0, alpha=alpha
    if n_elements(r0) eq 0 then r0 = 1.
    if n_elements(alpha) eq 0 then alpha = 2.
    p1 = (alpha-1.) * r / (alpha*r0) * (r le r0)
    p2 = (1. - 1./alpha * (r/r0)^(1-alpha)) * (r gt r0)
    return,  p1 + p2
end

; inverse CDF, or "quantile function" of the stellar distribution function
function q_cluster, p, r0=r0, alpha=alpha
    if n_elements(r0) eq 0 then r0 = 1.
    if n_elements(alpha) eq 0 then alpha = 2.
    r1 = (-alpha*(p-1))^(1/(1.-alpha)) * r0
    r2 = p * r0 * alpha / (alpha-1.)
    return, r1*(r1 gt r0)+r2*(r2 le r0)
end

; make a "radius" into random x,y,z directions
; (you don't need to use this yourself, but you might find it useful)
function rand_xyz,r,seed=seed
    rsize = n_elements(r)
    randx = randomu(seed,rsize)*2-1
    randy = randomu(seed,rsize)*2-1
    randz = randomu(seed,rsize)*2-1
    normal = (randx^2+randy^2+randz^2)^0.5
    randx = randx/normal * r
    randy = randy/normal * r
    randz = randz/normal * r
    return,[[randx],[randy],[randz]]
end

; some test code (go ahead and try this if you want to see what the functions look like)
pro test_cluster_making
    r = 10^(findgen(100)/99.*3 - 2)
    alpha=2.
    p = plot(r,p_cluster(r,alpha=alpha),color='FF0000'x)
    p2 = plot(r,p_cluster(r,r0=5,alpha=alpha),overplot=p,color='00FF00'x)
    p3 = plot(r,p_cluster(r,r0=2.5,alpha=alpha),overplot=p,color='0000FF'x)

    p4 = plot(r,c_cluster(r,alpha=alpha))
    p5 = plot(r,c_cluster(r,r0=5,alpha=alpha),overplot=p4)
    p6 = plot(r,c_cluster(r,r0=2.5,alpha=alpha),overplot=p4)

    p=findgen(100)/101. +0.001
    p7 = plot(q_cluster(p,alpha=alpha),p)
    p8 = plot(q_cluster(p,r0=5,alpha=alpha),p,overplot=p7)
    p9 = plot(q_cluster(p,r0=2.5,alpha=alpha),p,overplot=p7)
end

; Given nstars and an alpha (use 2 or 3) for the power law, determine the x,y,z
; coordinates of stars sampled randomly from the power-law distributions.
;
; The return value is an array of shape [nstars,3], so you could do:
;
; xyz = random_xyz(100,2) * !units.pc
; x = xyz[*,0]
; y = xyz[*,1]
; z = xyz[*,2]
;
; (don't forget to convert units appropriately)
function random_xyz,nstars,alpha,r0=r0,seed=seed

    cluster_r = q_cluster(randomu(seed,nstars),alpha=alpha,r0=r0)

    cluster_xyz = rand_xyz(cluster_r,seed=seed)
    
    return, cluster_xyz
end

pro test_randomxyz
    xyz2 = random_xyz(100,2)
    xyz3 = random_xyz(100,3)
    p1 = plot(xyz2[*,0],xyz2[*,1],linestyle=6,symbol="+",xrange=[-5,5],yrange=[-5,5])
    p2 = plot(xyz3[*,0],xyz3[*,1],linestyle=6,symbol="X",xrange=[-5,5],yrange=[-5,5],overplot=p1,color='FF0000'x)
end

; Find random masses for your stars
; This isn't a very realistic distribution - it is a lognormal centered at 1
; (which means stars with the Sun's mass are the most common, but it's possible
; to get stars the mass of Earth and stars 1000 times the mass of the sun, 
; which isn't possible in real life).
;
; The returned masses are in units of SOLAR MASSES.  You need to convert them to
; kilograms to use, e.g.:
;
; star_masses = random_masses(100) * !units.msun
function random_masses,nstars,seed=seed
    return, 10^randomn(seed,nstars)
end

; Determine the appropriate speeds for the stars
;
; ; calculate the star radii using the pythagorean theorem:
; ; sum of the squares of (x,y,z) directions, square rooted:
; star_radii = total(xyz^2,2)^0.5
; speeds = star_speeds(star_masses, star_radii)
function star_speeds,star_masses,star_radii
    sortarr = sort(star_radii)
    star_speeds = fltarr(n_elements(star_masses))

    ;star 0 has 0 velocity
    for starnum=1,n_elements(star_masses)-1 do begin
        enclosed = where(sortarr lt starnum)
        mass_enclosed = total(star_masses[enclosed])
        star_speeds[starnum] = sqrt(6.67e-11*mass_enclosed/star_radii[starnum])
    endfor

    return,star_speeds
end

; Once you've computed your star speeds, convert them into star
; velocities (so randomize the direction) using this function
;
; vxvyvz = star_velocities(speeds)
; vx = vxvyvz[*,0]
; vy = vxvyvz[*,1]
; vz = vxvyvz[*,2]
function star_velocities,speeds,seed=seed

    vxyz = rand_xyz(speeds,seed=seed)

    return,vxyz
end
