; This pro attach tags of the new LKDE centers if you supply a list of
; ra/dec/mag, and the redshift of the cluster. 



; Jiangang Hao, Jan. 31, 2012

;---------------------------
; ra_in,dec_in : the ra and dec array for the members
; mag: apparent mag of the corresponding members
; z_clu: a scalar, the redshift of the cluster
; lkde_ra,lkde_dec: output LKDE centers

pro LKDEcenter,ra_in, dec_in,mag,z_clu,lkde_ra,lkde_dec

    r2d = 180./!pi
    d2r = !pi/180.
    N = n_elements(ra_in)
    x = ra_in
    y = dec_in
    x=(x-median(x))*angdist_lambda(photoz)*d2r
    y=(y-median(y))*angdist_lambda(photoz)*d2r
    xrange=[-4,4]
    yrange=[-4,4]
    array=x
    iqr=(hquantile(array,3)-hquantile(array,1))
    N = N_ELEMENTS(x)
    
    bw=N^(-1.0/6.0)*min([stdev(x),iqr/1.34]) ; for 2 dimensional
    xgridsize=bw/4.
    ygridsize=bw/4.
    z=mag2flux(mag)*10e15
          
    hist2d_weighed,x,y,z,xrange = xrange,yrange=yrange,xgridsize,ygridsize,hst,xgrid,ygrid
    num=[double(round(bw/xgridsize)),double(round(bw/ygridsize))]
    make_gaussian,gauss,size=6.*num,fwhm=double(round(bw/xgridsize)),counts=1.

    dim=size(hst)

    if max(6*num) gt min([dim[1],dim[2]]) then begin
        print,'------------------------------------------'
        print,'kernel size is bigger than the data size'
        print,'change a smaller bw or enlarge the xrange and yrange'
        print,'------------------------------------------'
        
    endif else begin
        kde=convol(hst,gauss,/edge_tr)
        mx=max(kde,location)
        idce=array_indices(kde,location)
        xmax=xgrid[idce[0]]
        ymax=ygrid[idce[1]]
            
        xmax = median(ra_in) + xmax/angdist_lambda(photoz)*r2d ; convert back to ra/dec frame
        ymax = median(dec_in) + ymax/angdist_lambda(photoz)*r2d
        lkde_ra=xmax
        lkde_dec=ymax
                    
    endelse

    return
end



