;+
; This code generate the magnitudes that keep a constant co-moving #
; density of galaxies. It is valid from 0.1 to 1.0 in redshift. 
; example: mag_volmt,dst0,b,z,mag
;          input: b: is the galaxy catalog. It needs the tags z for redshift,
;                 omag for magnitude
;                 dst0: the comoving number density at redshift 0. You
;                 need to tune this number to match the 0.4L* from
;                 limi.pro if you want the mag corresponding to 0.4L*
;           output: z: redshifts at which the magnitude is calculated
;                   mag: magnitudes at different z that ensure the
;                   constant comoving # density
;
;J. Hao, @ U Michigan, 2/1/2008
;-


;------------------------------------------------
function InverseEz,z
   
     ogm=0.3
     w=-1.
    ; result=sqrt(ogm*(1+z)^3.+(1-ogm)^(3.*(1+w)))
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


pro mag_volmt,dst0,b,z,mag

    zmin=lindgen(100)/100.
    zmax=zmin+0.1
    z=(zmin+zmax)/2.

    ratio=fltarr(n_elements(z))
    dv=fltarr(n_elements(z))
    
    for i=0,n_elements(z)-2 do begin

        ratio[i]=dV_z(zmin[i],zmax[i])/dV_z(zmin[0],zmax[0])*dst0
        dv[i]=dV_z(zmin[i],zmax[i])
    endfor

    x=where(b.omag[0] gt 0 and b.omag[1] gt 0 and b.omag[2] gt 0 and b.omag[3] gt 0 and b.omag[4] gt 0 and b.z gt 0 and b.z le 1.)
    b=b[x]
    y=where(z le 1. and z ge 0.1)
    z=z[y]
    ratio=ratio[y]
    dv=dv[y]

    mag=fltarr(n_elements(y))

    for j=0,n_elements(y)-1 do begin

        x=where(b.z ge zmin[j] and b.z le zmax[j])
     ;   x=where(b.photozd1 ge zmin[j] and b.photozd1 le zmax[j])
        s=sort(b[x].omag[2])
        mag[j]=b[x[s[round(ratio[j])]]].omag[2]

        
    endfor   

      
      return
    

end
