;filtering out using fourier transforms
minslope=0.4
maxslope=6.9
timedistancefile='C:\Users\Keshav\Desktop\NIUS 14.2\Solar Image Data\Practice Data\20070509\Time-Distance Maps'
f=file_search(timedistancefile+'\*.fts',count=nfiles)
filteredtimedistancemapfile='C:\Users\Keshav\Desktop\NIUS 14.2\Solar Image Data\Practice Data\20070509\Filtered Time-Distance Maps'
for i=0,nfiles-1 do begin
;print, f[i]
image=readfits(f[i])
header=headfits(f[i])
angle= sxpar(header,'ANGLE') 
filterslope, image, minslope, maxslope, outputimage
writefits, filteredtimedistancemapfile+'\filteredtimedistancemap'+string(angle)+'.fts', abs(real_part(outputimage)), header
end
print, 'done'
;writefits, 'C:\Users\Keshav\Desktop\NIUS 14.2\Solar Image Data\Practice Data\Background Subtraction\Filtered time-distance maps\try.fts', real_part(outputimage)
END