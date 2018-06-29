function dmd_image = dmd_image_from_desired_camera_image(camera_image, tube_magnification)
    % Outputs the image that you should feed into the DMD so that the desired
    % camera_image appears in the image plane of the microscope.
    
    transform_file_name = sprintf('transform-parameters-for-%0.1fx-tube.mat', tube_magnification) ;
    transform_file_path = fullfile(fileparts(mfilename('full')), transform_file_name) ;
    s = load(transform_file_path) ;
    debarrel_parameter = s.debarrel_parameter ;
    transform_to_dmd_space_from_debarreled_camera_space = s.transform_to_dmd_space_from_debarreled_camera_space ;
    dmd_reference_frame = s.dmd_reference_frame ;
    dmd_image = ...
        map_camera_image_into_dmd_space(camera_image, ...
                                        debarrel_parameter, ...
                                        transform_to_dmd_space_from_debarreled_camera_space, ...
                                        dmd_reference_frame) ;
end
