# NIUS-14.2
This Repository contains all the code in IDL used by Keshav during the winter camp of NIUS 14.2
The Order in which to operate the code is as follows:
1. removefaultyimage.pro to remove faulty images from the set of level1 datafiles
2. getbackgroundimages.pro to store backgroundimage
3. store_background_subtracted_image.pro to store backgroundsubtracted cartesian images
4. polartransform.pro to transform images to polar form
5. time-distancemaps.pro to get time-distance maps from the polar images
6. filteringtime-distancemaps.pro to filter using fourier transforms
7. filteredpolarimages.pro to get filtered polar images
8. filteredcartesianimage.pro to get filtered cartesian images
9. writinggif.pro if needed to create a gif of any of the files
