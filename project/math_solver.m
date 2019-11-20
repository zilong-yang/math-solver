clearvars;
I = imread("img1.jpeg");
[m, n] = size(I);

% convert intensity values to doubles (0-1)
img = im2double(I);

% convert image to black and white
img = rgb2gray(img);

% make img binary using 0.4 as threshold
% 0.4 is selected to allow darker background color
% to be thresholded (become white)
% invert result for finding connected components
binary = ~imbinarize(img, 0.4);
img = double(binary);

% use gaussian filter to remove noise
% gaus_filter = fspecial('gaussian');
% img = imfilter(img, gaus_filter);
img = imgaussfilt(img, 1);

% label connected components
% cc is a struct containing info about connectivity of img
cc = bwconncomp(img, 4);
nconn = cc.NumObjects;

% store each component matrix into a cell array
comps = cell(nconn, 1);
for i=1:nconn
    c = component(img, cc.PixelIdxList{i});
    comps(i) = {c};
end

% result image
figure(1);
subplot(1,2,1);
imshow(I);
title("Original");
subplot(1,2,2);
imshow(img);
title("Result");

figure(2);
subplot(1,3,1);
imshow(cell2mat(comps(1)));
subplot(1,3,2);
imshow(cell2mat(comps(2)));
subplot(1,3,3);
imshow(cell2mat(comps(3)));

    
% end
pause;
close all;

function [result] = component(I, C)
% Return a matrix in which all non-component 
% indices are set to 0 (black)
I(1:min(C)-1) = 0;
I(max(C)+1:end) = 0;
result = I;
end