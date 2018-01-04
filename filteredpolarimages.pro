; to regenerate polar images from filtered imagedistance maps
;to read in time-distancemaps
filteredtimedistancemapfile='C:\Users\Keshav\Desktop\NIUS 14.2\Solar Image Data\Practice Data\20070509\Filtered Time-Distance Maps'
filteredpolarimagefile='C:\Users\Keshav\Desktop\NIUS 14.2\Solar Image Data\Practice Data\20070509\Filtered Polar Images'
f=file_search(filteredtimedistancemapfile+'\*.fts', count=nfiles)
print, nfiles
sampleimage=readfits(f[0])
sampleimagesize=size(sampleimage)
print, sampleimagesize

;;imageveec[t,theta,r]
imagevec=fltarr(sampleimagesize[1],720,sampleimagesize[2])
for i=0,nfiles-1 do begin
  image=readfits(f[i])
  header=headfits(f[i])
  angle= sxpar(header,'ANGLE')
  imagevec[*,round(2*angle),*]=abs(image)
end
mkhdr, HEADER, [nfiles, sampleimagesize[2]]
for i=0,sampleimagesize[1]-1  do begin
  writefits, filteredpolarimagefile+'\filteredpolarimage'+string(i)+'.fts', abs(reform(imagevec[i,*,*]))
end
print, 'done'
END