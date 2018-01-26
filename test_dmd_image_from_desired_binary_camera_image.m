% test a binary image

tube_magnification = 0.5 ;
camera_image_file_name = sprintf('camera-alphabet-image-with-%0.1fx-tube-mask.tif', tube_magnification) ;
camera_image = double(imread(camera_image_file_name)) ;
figure; imshow(camera_image) ;


dmd_image = dmd_image_from_desired_camera_image(camera_image, tube_magnification) ;
figure; imshow(dmd_image) ;

