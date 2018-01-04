;Difference images on polar maps
polarimagefile='C:\Users\Keshav\Desktop\NIUS 14.2\Solar Image Data\Practice Data\201008\Polar Images'
diffpolarimagefile='C:\Users\Keshav\Desktop\NIUS 14.2\Solar Image Data\Practice Data\201008\diff Polar Images'
f=file_search(polarimagefile+'\*.fts', count=nfiles)
image1=readfits(f[0])
for i=1,nfiles-1 do begin
  image2=readfits(f[i])
  header=headfits(f[i])
  diffimage=image2-image1
  writefits, diffpolarimagefile+'\diffpolarimage' +string(i)+'.fts', diffimage, header 
  image1=image2
end
print, 'done'
END