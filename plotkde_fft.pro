;+
; NAME:
;       plotkde_fft
; PURPOSE:
;       Plot 1 dim kernel density
; EXPLANATION:
;       Using FFT to speed up the calculation. Supercede the old plotkde
;             
;
; CALLING EXAMPLE:
;       plotkde_fft,array,bw,[gridsize=gridsize,xtitle=xtitle,ytitle=ytitle,title=title,linestyle=linestyle,color=color,psym=psym,charsize=charsize,xlog=xlog,ylog=ylog,xrange=xrange,yrange=yrange,overplot=overplot,background=background,textcolor=textcolor]
;      
;       IDL> x=randomn(seed,10000)
;       IDL> plotkde_fft,x,0
;
; INPUTS:
;       array = The input array for plots
;       bw = band width of the kernel. If bw set to 0, optimal bw will
;       be used.
;
;
; OPTIONAL INPUT KEYWORD:
;       see the main part of the procedure
;
; OUTPUTS:
;       the plot
;
; Note: 
;       the plot is normalized to its peak
;
; MODIFICATION HISTORY:
;       written by J. G. Hao @ Univ. of Michigan, Oct. 10. 2007
;       
;-

;--------------------------------------------------------------------
;generate a gaussian kernel with sigma=bw/binsize.
;num specify the dimension of the gaussian kernel
;-------------------------------------------------------------------

FUNCTION GAUSS_KN,NN,SIGMA
         
         MEAN=NN/2.
         SIGMA=FLOAT(SIGMA)
         x=lindgen(NN)

         KN = 1.0/(sqrt(2*!PI)*SIGMA)*EXP(-double((X-MEAN)^2/(2.0*SIGMA^2)))
         
        
          RETURN, KN
END



;-------------------------------------------------
;               main program                      ;
;-------------------------------------------------

pro plotkde_fft,array,bw,gridsize=gridsize,xtitle=xtitle,ytitle=ytitle,title=title,linestyle=linestyle,color=color,psym=psym,charsize=charsize,xlog=xlog,ylog=ylog,xrange=xrange,yrange=yrange,overplot=overplot,background=background,textcolor=textcolor
   
   if N_params() LT 2 or n_elements(array) le 2 then begin
      print,'use doc_library to see the usage!'
      return
   endif
   range=[min(array)-stdev(array),max(array)+stdev(array)]
   array=double(array)
   if not keyword_set(gridsize) then gridsize=(range[1]-range[0])/10000.
      !except=0
      iqr=(hquantile(array,3)-hquantile(array,1))
      N = N_ELEMENTS(array)
      IF(bw EQ 0) THEN bw=1.06*N^(-1.0/5.0)*min([sqrt(variance(array)),iqr/1.34])
      hst=double(histogram(array,binsize=gridsize,min=range[0],max=range[1]))
      grid=range[0]+lindgen(N_elements(hst))*gridsize
      num=double(round(bw/gridsize))
      GK=gauss_KN(6.*num,num)
      KDE = Convol(hst,GK,bw,/edge_tr)
      KDE = KDE/max(float(KDE))
   
      IF keyword_set(overplot) THEN BEGIN
       
          Oplot,grid,kde,color=color,psym=psym,linestyle=linestyle
          
      ENDIF ELSE BEGIN 

          plot,grid,kde,xtitle=xtitle,ytitle=ytitle,title=title,linestyle=linestyle,color=color,psym=psym,charsize=charsize,xlog=xlog,ylog=ylog,xrange=xrange,yrange=yrange,background=background
          legend,['bandwidth='+ntostr(bw)],box=0,charsize=1.5,textcolor=textcolor
      ENDELSE
end
