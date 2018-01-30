function dmd_from_file(dmd_mask_file_name, camera_mask_file_name, tube_magnification)
    % DMD_FROM_FILE  Converts a mask file to DMD image file, suitable for
    %                uploading to the DMD.
    %
    % DMD_FROM_FILE(DMD_MASK_FILE_NAME, CAMERA_MASK_FILE_NAME, TUBE_MAGNIFICATION)    
    % converts the camera-space mask file CAMERA_MASK_FILE_NAME to a DMD-space
    % mask image, DMD_MASK_FILE_NAME, suitable for uploading to the DMD.
    % TUBE_MAGNIFICATION determines the tub magnification used (tpyically 0.5
    % or 1).  CAMERA_MASK_FILE_NAME can be any image format supported by
    % imread().  The file type of DMD_MASK_FILE_NAME is determined from the
    % file name extension.  All file types supported by imwrite() are
    % supported.
    
    camera_image = double(imread(camera_mask_file_name)) ;  % double so that output is grayscale, not binary
    dmd_image = dmd_image_from_desired_camera_image(camera_image, tube_magnification) ;
    imwrite(dmd_image, dmd_mask_file_name) ;
end
