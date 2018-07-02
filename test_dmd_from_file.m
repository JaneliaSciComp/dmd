tube_magnification = 0.5 ;
camera_image_file_name = sprintf('camera-alphabet-image-with-%0.1fx-tube-mask.tif', tube_magnification) ;

camera_image = imread(camera_image_file_name) ;
imtool(camera_image) ;

dmd_image_file_name = sprintf('dmd-image-with-%0.1fx-tube-mask.tif', tube_magnification) ;
dmd_from_file(dmd_image_file_name, camera_image_file_name, tube_magnification) ;

dmd_image = imread(dmd_image_file_name) ;
imtool(dmd_image) ;
