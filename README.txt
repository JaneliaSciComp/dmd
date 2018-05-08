This code is for generating images to be fed to a DMD, to achieve a
pattern of illumination specified by an image in the imaging plane of
the microscope.  It does this using a DMD calibration image, which is
fed into the DMD and then imaged with the camera.  The user then
specifies a de-barreling parameter and a set of paired fiducial points
in the DMD calibration image and the camera calibration image.  Based
on these, an affine transform is calculated to map between the camera
and DMD spaces.  Once this calibration is performed, a binary image
specifying a desired illumination pattern in the camera space can be
transformed into a DMD image to acheive that illumination pattern.

To generate a DMD illumination image from a camera illumination image
(assuming calibration has already been done), execute this in Matlab:

dmd_from_file(<dmd_image_file_name>, ...
              <camera_image_file_name>, ...
              <tube_magnification>) ;

This will generate a file named <dmd_image_file_name> in the current
Matlab working folder, which can then be fed into the DMD software to
generate an illumination patten in the image plane that is (hopefully)
close to that in <camera_image_file_name>.  <tube_magnification> is
the tube lens magnification, typically 0.5 or 1.0 in Amrita's rig.

To do (or re-do) the calibration, use the DMD software to load
dmd-alhabet-image.png, and project it onto a uniform and flat fluorescent
slide.  Take an image with the camera, and save it to, say,
camera-alphabet-image-with-0.5x-tube.tif (assuming you're using the
0.5x tube lens---the calibration has to be done separately for each
tube lens).

Next, delete any existing
fiducial-points-for-0.5x-tube.mat file, and run (in Matlab):

determine_transform_parameters_for_half_x_tube

You will be presented with an interface that shows both the DMD
alphabet image and a camera alphabet image, and allows you to
specify corresponding fiducial points in each image.

First, check to make sure the camera image (the less-crisp one) does
not show evidence of barrel distortion.  The raw camera image
typically shows barrel distortion, and we correct for this before
showing the camera image in this interface.  This correction is based
on a "debarrel" parameter specified in
determine_transform_parameters_for_half_x_tube.m.  If the debarreled
camera image still shows evidence of barrel distortion (the edges of
letters that should be straight are curved, etc.), adjust the
debarrel_parameter in determine_transform_parameters_for_half_x_tube.m
and re-run determine_transform_parameters_for_half_x_tube until the
barrel distortion goes away.  (But hopefully the already-determined
values will work well.)

Once the barrel distortion has been corrrected, use the GUI interface
brought up by determine_transform_parameters_for_half_x_tube to
specify corresponding pairs of fiducial points in the two images.  The
corners of the glyphs make good ones, because they're easy to localize
in x and y.  Specify about a dozen of these, roughly uniformly
distributed throughout the image.  Go to File > Close [something
something] to save your fiducial points to a new
fiducial-points-for-0.5x-tube.mat file.  The script will then generate
transform parameters and save them in

transform-parameters-for-0.5x-tube.mat

These parameters will be used by dmd_from_file() when the
<tube_magnification> is given as 0.5.

The determine_transform_parameters_for_half_x_tube will also show an
image with the original DMD camera image in the red channel, and an
image computed using the transform to match this image.  These should
match up, with no prominent red or green lines at the edges of the
glyphs.

Repeat the calibration procedure for the 1.0x tube lens.

Additional note:

To generate an illumination target image, take a still of the field
you want to illuminate, open in Roving ("roving" in Matlab), open the
"video" (which is a one-frame video, and has to be a TIFF file), and
draw ROIs using the Roving tools.  Then go to File > Export ROI
mask... to save the ROI mask image as a black-and-white TIFF.  You can
then use this image as the <camera_image_file_name> input to
dmd_from_file().

ALT
2018-05-08


