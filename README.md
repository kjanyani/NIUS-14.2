# NIUS-14.2
This Repository contains all the code in IDL used by Keshav during the winter camp of NIUS 14.2
The Order in which to operate the code is as follows:
*removefaultyimage.pro to remove faulty images from the set of level1 datafiles
*getbackgroundimages.pro to store backgroundimage
  store_background_subtracted_image.pro to store backgroundsubtracted cartesian images
  polartransform.pro to transform images to polar form
  time-distancemaps.pro to get time-distance maps from the polar images
  filteringtime-distancemaps.pro to filter using fourier transforms
  filteredpolarimages.pro to get filtered polar images
  filteredcartesianimage.pro to get filtered cartesian images
  writinggif.pro if needed to create a gif of any of the files
