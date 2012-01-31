;This pro produce a map with x, y and z. 
; J G Hao @ U of Michigan 10/4/2007



pro hist2d_weighed,x,y,z,xrange=xrange,yrange=yrange,xgridsize,ygridsize,hstmap,xgrid,ygrid

    n_xgrid=round((xrange[1]-xrange[0])/xgridsize)
    n_ygrid=round((yrange[1]-yrange[0])/ygridsize)
   
    ind_xgrid=lindgen(n_xgrid)
    ind_ygrid=lindgen(n_ygrid)
   
    hstmap=dblarr(n_xgrid,n_ygrid)
    x=x-xrange[0]   ;shift the data to make the grid start from 0
    y=y-yrange[0]

    xx=floor(x/xgridsize)
    yy=floor(y/ygridsize)

    for i=0L, n_elements(x)-1 do begin

        hstmap[xx[i],yy[i]]=hstmap[xx[i],yy[i]]+z[i]
     
    endfor

    x=x+xrange[0]
    y=y+yrange[0]

    xgrid=xrange[0]+ind_xgrid*xgridsize+xgridsize/2.
    ygrid=yrange[0]+ind_ygrid*ygridsize+ygridsize/2.
    
    return

end
