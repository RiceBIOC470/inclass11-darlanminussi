% Inclass11

% You can find a multilayered .tif file with some data on stem cells here:
% https://www.dropbox.com/s/83vjkkj3np4ehu3/011917-wntDose-esi017-RI_f0016.tif?dl=0

% 1. Find out (without reading  the entire file) -  (a) the size of the image in
% x and y, (b) the number of z-slices, (c) the number of time points, and (d) the number of
% channels.

reader = bfGetReader('011917-wntDose-esi017-RI_f0016.tif');
[reader.getSizeX, reader.getSizeY]
reader.getSizeZ
reader.getSizeT
reader.getSizeC


% 2. Write code which reads in all the channels from the 30th time point
% and displays them as a multicolor image.

zplane = 1;
chan_c1 = 1;
chan_c2 = 2;
time = 30;

iplane_c1 = reader.getIndex(zplane-1, chan_c1-1, time-1)+1;
iplane_c2 = reader.getIndex(zplane-1, chan_c2-1, time-1)+1;


img1 = bfGetPlane(reader,iplane_c1);
img2 = bfGetPlane(reader,iplane_c2);

img2show = cat(3, imadjust(img1), imadjust(img2), zeros(size(img1)));
imshow(img2show);

% 3. Use the images from part (2). In one of the channels, the membrane is
% prominently marked. Determine the best threshold and make a binary
% mask which marks the membranes and displays this mask. 

img1_d = im2double(img1);
imgbright = uint16((2^16-1)*(img1_d/max(max(img1_d))));
imshow(img1);
imshow(imgbright);

img_bw = img1 > 900;
imshow(img_bw);

% 4. Run and display both an erosion and a dilation on your mask from part
% (3) with a structuring element which is a disk of radius 3. Explain the
% results.

imshow(imerode(img_bw,strel('disk',3)));
imshow(imdilate(img_bw,strel('disk',3)));

% imerode and imdilate will apply on the mask the structure show below to
% each pixel

SE3 = strel('disk', 3);
imshow(SE3.Neighborhood);

% As we can see imdilate will pronounce any of the pixels present in the
% mask, highlighting the pixels on the membrane but also artificats that
% are in the image.

% Image erode will apply the erosion of the disk structure to each pixel,
% in this case leaving only traces of the membrane on the image.




