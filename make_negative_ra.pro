;This code make the ra in the range [-180,180]
;J Hao, 9/1/2009, FNAL
function make_negative_ra,gal

        x=where(gal.ra gt 180.)
        if x[0] ne -1 then gal[x].ra = gal[x].ra - 360.
        return,gal

end
