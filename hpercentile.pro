;+
; This pro return the percentile of an array.
; The definition of percentile follows that recommended by NIST and is
; the same as those adopted by Microsoft Excel
; J G Hao @ U of Michigan, 3/5/2008
;-

FUNCTION hpercentile_single,x,pn

         if n_params() lt 1 then begin
            print,'Syntax: hpercentile(x,pn)'
            return,1
         endif
         ary=x
         srt = sort(ary)
         ary = ary[srt]
         num=n_elements(x)
        
         n=pn/100.*(num-1)+1
         k=floor(n)
         if k eq 1 then vp=ary[0] 
         if k eq num then vp=ary[num-1]
         if k gt 1 and k lt num then vp=ary[k-1]+(n-k)*(ary(k)-ary[k-1]);vp=ary[k]+(n-k)*(ary[k+1]-ary[k])
   
         return,vp

END


FUNCTION hpercentile,x,vpn
         N=n_elements(vpn)
         if N eq 1 then begin
             vvp = hpercentile_single(x,vpn)
         endif else begin
             vvp=fltarr(N)
             for i=0, N-1 do begin
                 vvp[i]=hpercentile_single(x,vpn[i])
             endfor
         endelse
return, vvp   
        
END


