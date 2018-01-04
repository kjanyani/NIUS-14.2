;getting time-distance maps
polarfile='C:\Users\Keshav\Desktop\NIUS 14.2\Solar Image Data\Practice Data\20070509\Polar Images'
f=file_search(polarfile+'\*.fts', count=nfiles)
h=headfits(f[0])
sampleimage=readfits(f[0])
sampleimagesize=size(sampleimage)
date= sxpar(h,'DATE-OBS')
date=strmid(date,0,10) 
imagevec=fltarr(nfiles,720,sampleimagesize[2])
;To create a dummy Header that contains the Angle and Date
mkhdr, HEADER, [nfiles, 156]
sxaddpar, HEADER, 'DATE-OBS', date
for i=0,nfiles-1 do begin
  image=readfits(f[i])
  if max(image) lt 1 then imagevec[i,*,*]=image else imagevec[i,*,*]=0.0
  
end
timedistancefile='C:\Users\Keshav\Desktop\NIUS 14.2\Solar Image Data\Practice Data\20070509\Time-Distance Maps'
;plot_image, reform(imagevec[*,90,*])
for i=0, 719 do begin
  sxaddpar, HEADER, 'ANGLE', i/2.0
  writefits, timedistancefile + '\timedistancemap'+string((i/2.0))+'.fts', reform(imagevec[*,i,*]), HEADER
end
print, 'done'
END