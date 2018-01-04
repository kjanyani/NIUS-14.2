;code to get time of erronomous images
Sourcefile='C:\Users\Keshav\Desktop\NIUS 14.2\Solar Image Data\Level05\20070509L1'
f=file_search(Sourcefile+'\*.fts', count=nfiles)
meanimage=fltarr(nfiles)
dateimage=strarr(nfiles)

;print, header[5]

for i=0,nfiles-1 do begin
  image=readfits(f[i])
  header=headfits(f[i])
  meanimage[i]=mean(image)
  dateimage[i]=header[5]

end
badimagetime=strarr(10) ;Assuming that #badimages wont exceed 10
meanmeanimage=mean(meanimage)
stdmeanimage=stddev(meanimage)
j=0
for i=0,nfiles-1 do begin
  if (meanimage[i] gt meanmeanimage+1*stdmeanimage) or (meanimage[i] lt meanmeanimage-1*stdmeanimage) then begin
  badimagetime[j]=dateimage[i]
  j+=1
  end
end
print, badimagetime[0:j-1]
for i=0,j-1 do begin
name=strmid(badimagetime[i],11,4)+strmid(badimagetime[i],16,2)+strmid(badimagetime[i],19,2)+'_'+strmid(badimagetime[i],22,2)$
+strmid(badimagetime[i],25,2)+strmid(badimagetime[i],28,2)+'_1B4c1A'
print, Sourcefile+'\'+name+'.fts'
image=readfits(Sourcefile+'\'+name+'.fts')
header=headfits(Sourcefile+'\'+name+'.fts') ;Note this works for only Level 1 data file and i am not sure if it works for each of them
image[*,*]=25000000.0; a large valuw not likely to disturb creation of background images
writefits, Sourcefile+'\'+name+'.fts', image, header
end
print, 'done'
;20070509_002000_1B4c1A
END