; to store background subtracted images
backimage=readfits('C:\Users\Keshav\Desktop\NIUS 14.2\Solar Image Data\Practice Data\20070509\Background Images\backimage.fts')
level1datafile='C:\Users\Keshav\Desktop\NIUS 14.2\Solar Image Data\Level05\20070509L1'
backsubtractedimagefile='C:\Users\Keshav\Desktop\NIUS 14.2\Solar Image Data\Practice Data\20070509\Backsubtracted Images'
f=file_search(level1datafile+'\*.fts', count=nfiles)
for i=0,nfiles-1 do begin
  image=readfits(f[i])
  header=headfits(f[i])
  backsubimage=image-backimage
  name=STRMID(header[5],11,4)+STRMID(header[5],16,2)+STRMID(header[5],19,2)+STRMID(header[5],22,2)+STRMID(header[5],25,2)
  writefits, backsubtractedimagefile+'\backsubimage'+name+'.fts', backsubimage, header
end
print, 'done'
END