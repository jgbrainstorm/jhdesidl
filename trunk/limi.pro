;+
;This code calculate the iband mag corresponding to 0.4L* at a given
;redshift based on the color model from Jim Annis.
;J Hao @ FNAL 9/1/2008
;-
function limi,z

    g=mrdfits('/data/color_model/jims_kcorrections_080904.fit',1) 
    g=g[1:1000]
    lim_i=cspline(g.z,g.lim_i,z)
    return,lim_i
end
