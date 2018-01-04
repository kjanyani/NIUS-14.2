; Code to convert Backsubtracted images to appropriate polarimages'
backsubtractedimagefile='C:\Users\Keshav\Desktop\NIUS 14.2\Solar Image Data\Practice Data\20070509\Backsubtracted Images'
polarimagefile='C:\Users\Keshav\Desktop\NIUS 14.2\Solar Image Data\Practice Data\20070509\Polar Images'
f=file_search(backsubtractedimagefile+'\*.fts',count=nfiles)
;print, nfiles
for i=0,nfiles-1 do begin
  IMAGE=readfits(f[i])
HEADER=headfits(f[i])
WCS = FITSHEAD2WCS(header)
PIXEL_SUN = WCS_GET_PIXEL(WCS,[0,0])
imagesize=size(image)
maxdim=max([imagesize[1],imagesize[2]])

rmax=round(sqrt(2*maxdim^2))+1
centerx=PIXEL_SUN[0]
centery=PIXEL_SUN[1]
imagepol=MAKE_ARRAY(720,rmax,/float, value=0)
for y=0,imagesize[2]-1 do begin
  for x=0,imagesize[1]-1 do begin
    r=round(sqrt((x-centerx)^2+(y-centery)^2))
  if(x eq centerx) then begin
    if(y lt centery) then theta= 270 else theta=90
  end else begin
    theta=atan((y-centery)/(x-centerx))*!RADEG
    if x lt centerx then theta=theta+180 else if y lt centery then theta=theta+360
  end
  theta2=round(2*theta)
  if theta2 eq 720 then theta2=0
  imagepol[theta2,r]+=image[x,y]
  end
  
end
imagepol[*,0]=image[centerx,centery]
if imagesize[1] eq 512 then imagepolrelevant=imagepol[*,100:255]
if imagesize[1] eq 1024 then imagepolrelevant=imagepol[*,215:500]
name=STRMID(header[5],11,4)+STRMID(header[5],16,2)+STRMID(header[5],19,2)+STRMID(header[5],22,2)+STRMID(header[5],25,2)
writefits, polarimagefile+'\Polar Image'+name+'.fts', imagepolrelevant, header

end
plot_image, imagepolrelevant
print, 'done'
END