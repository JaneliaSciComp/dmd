tube_magnification = 0.5 ;
raw_camera_image_file_name = sprintf('camera-alphabet-image-with-%0.1fx-tube.png', tube_magnification) ;
raw_camera_image = imread(raw_camera_image_file_name) ;
raw_camera_image_max = double(max(raw_camera_image(:))) ;
camera_image = uint8(255/raw_camera_image_max*double(raw_camera_image)) ;
figure; imshow(camera_image) ;


dmd_image = dmd_image_from_desired_camera_image(camera_image, tube_magnification) ;
figure; imshow(dmd_image) ;

true_dmd_image = imread('dmd-alphabet-image.png') ;

comparison_image = cat(3, dmd_image, true_dmd_image, zeros(size(dmd_image), 'uint8')) ;

figure; imshow(comparison_image) ;





tube_magnification = 1 ;
raw_camera_image_file_name = sprintf('camera-alphabet-image-with-%0.1fx-tube.png', tube_magnification) ;
raw_camera_image = imread(raw_camera_image_file_name) ;
raw_camera_image_max = double(max(raw_camera_image(:))) ;
camera_image = uint8(255/raw_camera_image_max*double(raw_camera_image)) ;
figure; imshow(camera_image) ;


dmd_image = dmd_image_from_desired_camera_image(camera_image, tube_magnification) ;
figure; imshow(dmd_image) ;

true_dmd_image = imread('dmd-alphabet-image.png') ;

comparison_image = cat(3, dmd_image, true_dmd_image, zeros(size(dmd_image), 'uint8')) ;

figure; imshow(comparison_image) ;
