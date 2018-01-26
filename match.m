dmd_image = imread('dmd-alphabet-image.png') ;
figure; imshow(dmd_image) ;
dmd_size = size(dmd_image) ;
dmd_reference_frame = imref2d(dmd_size) ;

raw_camera_image_file_name = sprintf('camera-alphabet-image-with-%0.1fx-tube.png', tube_magnification) ;
raw_camera_image = imread(raw_camera_image_file_name) ;
raw_camera_image_max = double(max(raw_camera_image(:))) ;
camera_image = uint8(255/raw_camera_image_max*double(raw_camera_image)) ;
figure; imshow(camera_image) ;

% try to fix lens distortion on camera image
debarreled_camera_image = correct_lens_distortion(camera_image, debarrel_parameter) ;  % 
figure; imshow(debarreled_camera_image) ;

points_file_name = sprintf('fiducial-points-for-%0.1fx-tube.mat', tube_magnification) ;
if exist(points_file_name, 'file') ,
    s = load(points_file_name) ;
    debarreled_camera_image_fiducial_points = s.camera_points ;
    dmd_image_fiducial_points = s.dmd_points ;
else    
    [camera_points,dmd_points] = ...
        cpselect(debarreled_camera_image, dmd_image, ...
                 'Wait', true) ;
    save(points_file_name,'camera_points','dmd_points') ;
    debarreled_camera_image_fiducial_points = camera_points ;
    dmd_image_fiducial_points = dmd_points ;
end

transform_to_dmd_space_from_debarreled_camera_space = fitgeotrans(debarreled_camera_image_fiducial_points, dmd_image_fiducial_points, 'projective') ;

camera_image_in_dmd_space = imwarp(debarreled_camera_image, transform_to_dmd_space_from_debarreled_camera_space, 'OutputView', dmd_reference_frame) ;

comparison_image = cat(3, camera_image_in_dmd_space, dmd_image, zeros(dmd_size, 'uint8')) ;

figure; imshow(comparison_image) ;

% generate image containing 
n_x = dmd_size(2) ;
n_y = dmd_size(1) ;
dmd_x = repmat((1:n_x) , [n_y 1]) ;
dmd_y = repmat(n_y+1-(1:n_y)', [1 n_x]) ;
xc = (1+n_x)/2 ;
yc = (1+n_y)/2 ;
dmd_x_prime = dmd_x - xc ;  % primed version has origin at center
dmd_y_prime = dmd_y - yc ;
dmd_r_prime = hypot(dmd_x_prime, dmd_y_prime) ;

is_lit = logical(dmd_image) ;

figure;
plot(dmd_image, camera_image_in_dmd_space, '.k') ;
axis square ;
axis equal ;
xlim([0 255]) ;
ylim([0 255]) ;

figure;
plot(dmd_r_prime(is_lit), camera_image_in_dmd_space(is_lit), '.k') ;

figure;
plot3(dmd_x_prime(is_lit), dmd_y_prime(is_lit), camera_image_in_dmd_space(is_lit), '.k') ;
axis vis3d ;

E = mean(mean((camera_image_in_dmd_space-dmd_image).^2))  %#ok<NOPTS>

% Package up the parameters, store in disk file
transform_file_name = sprintf('transform-parameters-for-%0.1fx-tube.mat', tube_magnification) ;
save(transform_file_name, 'debarrel_parameter', 'transform_to_dmd_space_from_debarreled_camera_space', 'dmd_reference_frame') ;
