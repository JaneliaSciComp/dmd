function camera_image_in_dmd_space = map_camera_image_into_dmd_space(camera_image, ...
                                                                     debarrel_parameter, ...
                                                                     transform_to_dmd_space_from_debarreled_camera_space, ...
                                                                     dmd_reference_frame, ...
                                                                     camera_image_offset, ...
                                                                     camera_image_binning)
    if ~exist('camera_image_offset', 'var') || isempty(camera_image_offset) , 
        camera_image_offset = [ 0 0 ] ;  % rows, columns on sensor
    end
    if ~exist('camera_image_binning', 'var') || isempty(camera_image_binning) , 
        camera_image_binning = 1 ;  % number of sensor pixels per camera_image pixel, in both x and y
    end

    % Transform the possibly offset and binned camera image to a full-size
    % camera image
    sensor_size = [2048 2048] ; 
    camera_image_size = size(camera_image) ;
    input_view = imref2d(camera_image_size, ...
                         0.5 + camera_image_offset(2) + [0 camera_image_binning*camera_image_size(2)], ...
                         0.5 + camera_image_offset(1) + [0 camera_image_binning*camera_image_size(1)]) ;
    full_camera_image = imwarp(camera_image, ...
                               input_view, ...
                               affine2d(eye(3)), ...
                               'OutputView', imref2d(sensor_size)) ;
                  
    % Do the transformations appropriate to a full-sized camera image                       
    debarreled_camera_image = correct_lens_distortion(full_camera_image, debarrel_parameter) ;
    camera_image_in_dmd_space = imwarp(debarreled_camera_image, transform_to_dmd_space_from_debarreled_camera_space, 'OutputView', dmd_reference_frame) ;
end
