clearvars;
img = imread("thumbnail_Image-33.png");

% conert intensity values to doubles (0-1)

% convert image to black and white
img = rgb2gray(img);
img = imrotate(img,90);
% make img binary using 0.4 as threshold
% 0.4 is selected to allow darker background color
% to be thresholded (become white)
% invert result for finding connected components

img = ~imbinarize(img,0.25);
imwrite(img,'binaryimage.jpeg')
img = bwareaopen(img,100);
pause(1)

%returns the number of components and the 
[L, Ne] = bwlabel(img);
figure
imshow(L)
pause
propied = regionprops(L, 'BoundingBox');
hold on

for n=1:size(propied,1)
    rectangle('Position',propied(n).BoundingBox,'EdgeColor','g','LineWidth',2)
end

hold off
pause(1)

figure
for n=1:Ne
    [r,c] = find(L==n);
    n1=img(min(r):max(r),min(c):max(c));
    x = feature_vec(n1)
    imshow(~n1);
    pause
end

% end
pause;
close all;

