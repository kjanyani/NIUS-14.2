;Code to read in all the images, center them properly, get minimum of each pixel and subtract them from each image
;To read in images and store them in an arrayy of images
Sourcefile='C:\Users\Keshav\Desktop\NIUS 14.2\Solar Image Data\Level05\20070509L1'
Destinationfile='C:\Users\Keshav\Desktop\NIUS 14.2\Solar Image Data\Practice Data\20070509\Background Images'
f=file_search(Sourcefile+'\*.fts', count=nfiles)
nhundredfiles=nfiles/100 ;Gets the no of times to get a background image -1
n=nhundredfiles+1 ; Gets the no of times seperate background has to be found
;print, n
image=readfits(f[0])
imagesize=size(image)
;print, imagesize
imagevec=fltarr(imagesize[1],imagesize[2],100)
for k=0,n-1 do begin
  for i=0,99 do begin
    if(i+k*100 lt nfiles-1) then imagevec[*,*,i]=readfits(f[i+k*100]) ;Note that few files are considered more than once but doesnt matter as we are taking overall minimum anyway
   end
   ;To get Minimum along each pixel
   backimage=fltarr(imagesize[1],imagesize[2])
   for j=0, imagesize[2]-1 do begin
     for i=0,imagesize[1]-1 do begin
       backimage[i,j]=min(imagevec[i,j,*])
     end
   end
;To store it in a fits file
writefits, Destinationfile+'\backimage'+string(k)+'.fts', backimage
end

;for i=0,99 do begin
;  imagevec[*,*,i]=readfits(f[i+100])
;end
;;To get Minimum along each pixel
;;backimage=fltarr(imagesize[1],imagesize[2])
;for j=0, imagesize[2]-1 do begin
;  for i=0,imagesize[1]-1 do begin
;    backimage[i,j]=min(imagevec[i,j,*])
;  end
;end
;;To store it in a fits file
;writefits, Destinationfile+'\backimage2.fts', backimage
;for i=0,nfiles-201 do begin
;  imagevec[*,*,i]=readfits(f[i+200])
;end
;;To get Minimum along each pixel
;;backimage=fltarr(imagesize[1],imagesize[2])
;for j=0, imagesize[2]-1 do begin
;  for i=0,imagesize[1]-1 do begin
;    backimage[i,j]=min(imagevec[i,j,*])
;  end
;end
;;To store it in a fits file
;writefits, Destinationfile+'\backimage3.fts', backimage
;to get background of background images
g=file_search(Destinationfile+'\*.fts', count=nfiles)
backimagevec=fltarr(imagesize[1],imagesize[2],nfiles)
for i=0,nfiles-1 do begin
backimagevec[*,*,i]=readfits(g[i])
end
for j=0, imagesize[2]-1 do begin
  for i=0,imagesize[1]-1 do begin
    backimage[i,j]=min(backimagevec[i,j,*])
  end
end
writefits, Destinationfile+'\backimage.fts', backimage
print, 'done'
END