close all ;
clear;

camera_offset = [0 0] ;
camera_binning = 4 ;

tube_magnification = 0.5 ;
raw_camera_image_file_name = sprintf('camera-alphabet-image-with-%0.1fx-tube.png', tube_magnification) ;
raw_camera_image_full = imread(raw_camera_image_file_name) ;
im = conv2(raw_camera_image_full, (1/camera_binning^2)*ones(camera_binning), 'valid') ;
raw_camera_image = im(1:camera_binning:end, 1:camera_binning:end) ;
raw_camera_image_max = double(max(raw_camera_image(:))) ;
camera_image = uint8(255/raw_camera_image_max*double(raw_camera_image)) ;
figure; imshow(camera_image) ;
title(sprintf('Camera image of alphabet at %0.1fx', tube_magnification)) ;


dmd_image = dmd_image_from_desired_camera_image(camera_image, tube_magnification, camera_offset, camera_binning) ;
figure; imshow(dmd_image) ;
title(sprintf('DMD image to match camera image at %0.1fx', tube_magnification)) ;

true_dmd_image = imread('dmd-alphabet-image.png') ;

comparison_image = cat(3, dmd_image, true_dmd_image, zeros(size(dmd_image), 'uint8')) ;

figure; imshow(comparison_image) ;
title(sprintf('Comparison of original DMD image (green), and matched image (red) at %0.1fx', tube_magnification)) ;





tube_magnification = 1 ;
raw_camera_image_file_name = sprintf('camera-alphabet-image-with-%0.1fx-tube.png', tube_magnification) ;
raw_camera_image_full = imread(raw_camera_image_file_name) ;
im = conv2(raw_camera_image_full, (1/camera_binning^2)*ones(camera_binning), 'valid') ;
raw_camera_image = im(1:camera_binning:end, 1:camera_binning:end) ;
raw_camera_image_max = double(max(raw_camera_image(:))) ;
camera_image = uint8(255/raw_camera_image_max*double(raw_camera_image)) ;
figure; imshow(camera_image) ;
title(sprintf('Camera image of alphabet at %0.1fx', tube_magnification)) ;


dmd_image = dmd_image_from_desired_camera_image(camera_image, tube_magnification, camera_offset, camera_binning) ;
figure; imshow(dmd_image) ;
title(sprintf('DMD image to match camera image at %0.1fx', tube_magnification)) ;

true_dmd_image = imread('dmd-alphabet-image.png') ;

comparison_image = cat(3, dmd_image, true_dmd_image, zeros(size(dmd_image), 'uint8')) ;

figure; imshow(comparison_image) ;
title(sprintf('Comparison of original DMD image (green), and matched image (red) at %0.1fx', tube_magnification)) ;
