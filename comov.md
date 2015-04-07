### Code documentation ###

```

;+
;This function, comov return the comoving volume
;Calling sequence: comov(ra_min,ra_max,dec_min,dec_max,z_min,z_max)
;The angular diameter distance is calculated by assuming
;h=0.7,ogm=0.3,w=-1

;The ra_min, ra_max range is [0,360]
;The dec_min,dec_max range is [-90,90]
;Example, comov(30,60,-20,40,0.2,0.4)

;v1:2/17/2007 modified from previous codes.

;J.G. Hao @ U of Mich. 
;-

;------------------------------------------------
function InverseEz,z
   
     ogm=0.3
     w=-1.
   ;  result=sqrt(ogm*(1+z)^3.+(1-ogm)^(3.*(1+w)))
      result=sqrt(ogm*(1+z)^3.+(1-ogm))
     return,1./result
end

;------------------------------------------------

Function D_A,z  ;angular_diameter distance
  
      h=0.7  ;H0=100*h
      result=3000.*QROMB('InverseEz',0,z)/(h*(1+z))    

      return,result
  End

;--------------------------------------------------

Function dV_z_integrand,z
         
        h=0.7
        result=3000.*D_A(z)^2.*(1+z)^2.*InverseEz(z)/h
        return,result
End

;----------------------------------------------------

Function dV_z,zmin,zmax

        result=QROMB('dV_z_integrand',zmin,zmax)
        return,result
End

;---------------------------------------------------
Function dV_ra,ra_min,ra_max
       
         result=!d2r*(ra_max-ra_min)
         return,result
End


;-------------------------------------------------

Function dV_dec,dec_min,dec_max

         decmin=!d2r*(90.-dec_min)
         decmax=!d2r*(90.-dec_max)
         result=cos(decmax)-cos(decmin)

         return,result
End

;------------The main funciton---------------------
;
function comov,ra_min,ra_max,dec_min,dec_max,zmin,zmax

          result=dV_z(zmin,zmax)*dV_ra(ra_min,ra_max)*dV_dec(dec_min,dec_max)
         return,result
end


```