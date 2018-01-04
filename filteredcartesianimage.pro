; to get filtered cartesian images retry
;To set up the files required
filteredpolarimagefile='C:\Users\Keshav\Desktop\NIUS 14.2\Solar Image Data\Practice Data\20070509\Radially Enhanced Filtered Polar Images'
filteredcartesianimagefile='C:\Users\Keshav\Desktop\NIUS 14.2\Solar Image Data\Practice Data\20070509\Radially Enhanced Cartesian Images'
backsubtractedimagefile='C:\Users\Keshav\Desktop\NIUS 14.2\Solar Image Data\Practice Data\20070509\Backsubtracted Images'
f=file_search(filteredpolarimagefile+'\*.fts',count=nfiles1)
g=file_search(backsubtractedimagefile+'\*.fts',count=nfiles2)
;To decide if files are 512*512 or 1024*1024
sampleimage=readfits(g[0])
sampleimagesize=size(sampleimage)
if sampleimagesize[1] eq 512 then begin 
  polarimagefull=Make_array(720,256,/float, value=0)
end
if sampleimagesize[1] eq 1024 then begin
  polarimagefull=Make_array(720,512,/float, value=0)
end
;Assuming that if there are missing files then they are properly dealt with
;To convert images one by one from f file
for i=0,nfiles1-1 do begin
  polarimage=readfits(f[i])
  ;Matching it with corresponding header making use of the od=rder in which they are stored
  header=headfits(g[i])
  ;To set up cartimage and polarimagefull
  if sampleimagesize[1] eq 512 then begin
    polarimagefull[*,100:255]=polarimage
    cartimage=make_array(512,512,/float,value=0)
  end
  if sampleimagesize[1] eq 1024 then begin
    polarimagefull[*,215:500]=polarimage
    cartimage=make_array(1024,1024,/float,value=0)
  end
  ;to get pixel of sun center
  WCS = FITSHEAD2WCS(header)
  PIXEL_SUN = WCS_GET_PIXEL(WCS,[0,0])
  centerx=PIXEL_SUN[0]
  centery=PIXEL_SUN[1]
  ;To convert each polar image into cartesian
  for y=0,sampleimagesize[2]-1 do begin
    for x=0,sampleimagesize[1]-1 do begin
      r=round(sqrt((x-centerx)^2+(y-centery)^2))
      if sampleimagesize[1] eq 512 then begin
        if (r gt 255) then cartimage[x,y]=0 else begin
          if(x eq centerx) then begin
            if(y lt centery) then theta= 270 else theta=90
          end else begin
            theta=atan((y-centery)/(x-centerx))*!RADEG
            if x lt centerx then theta=theta+180 else if y lt centery then theta=theta+360
          end
          theta2=round(2*theta)
          if theta2 eq 720 then theta2=0
          cartimage[x,y]=polarimagefull[theta2,r]
        end
      end
      if sampleimagesize[1] eq 1024 then begin
        if (r gt 511) then cartimage[x,y]=0 else begin
          if(x eq centerx) then begin
            if(y lt centery) then theta= 270 else theta=90
          end else begin
            theta=atan((y-centery)/(x-centerx))*!RADEG
            if x lt centerx then theta=theta+180 else if y lt centery then theta=theta+360
          end
          theta2=round(2*theta)
          if theta2 eq 720 then theta2=0
          cartimage[x,y]=polarimagefull[theta2,r]
        end
      end
    end
  end
  name=STRMID(header[5],11,4)+STRMID(header[5],16,2)+STRMID(header[5],19,2)+STRMID(header[5],22,2)+STRMID(header[5],25,2)
  writefits, filteredcartesianimagefile+'\filteredcartesianimage'+name+'.fts', cartimage, header
end
print, 'done'
END