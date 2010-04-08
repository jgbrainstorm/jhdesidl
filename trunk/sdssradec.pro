;+
;sdssradec, ra, dec 
; it will print a weblink pointing to the DR7 image of the ra/dec you
;input.
;J Hao @ UMICHIGAN, 4/8/2008 
;-
pro sdssradec,ra,dec
   
    print,'http://cas.sdss.org/dr7/en/tools/chart/navi.asp?ra='+ntostr(ra)+'&dec='+ntostr(dec)+'&scale=0.800000&width=919&height=919&opt=GS&query=" target="frame2'
   
end
