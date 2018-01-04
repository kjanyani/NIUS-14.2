 ;Code to create GIFs
Sourcefile='C:\Users\Keshav\Desktop\NIUS 14.2\Solar Image Data\Practice Data\20070509\Radially Enhanced Filtered Polar Images'
f=file_search(Sourcefile+'\*.fts',count=nfiles)
;print,nfiles
for i=0,nfiles-1 do begin
  image=readfits(f[i])
;  image=bytscl(image, min=1.06*10^(-10), max=1.41*10^(-9))
  write_gif,Sourcefile+'\all.gif' , bytscl(image, min=2.53e-005, max=6.26e-004), /MULTIPLE, delay_time=0.3
end
write_gif, Sourcefile+'\all.gif', /CLOSE
print, 'done'
END
