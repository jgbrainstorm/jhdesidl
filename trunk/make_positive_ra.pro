;This code make the ra in the range [0,360]
;J. Hao, 9/1/2009 FNAL
function make_positive_ra,gal

        x=where(gal.ra lt 0)
        if x[0] ne -1 then gal[x].ra = gal[x].ra + 360.D
        return,gal

end
