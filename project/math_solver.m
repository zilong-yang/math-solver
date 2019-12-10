function answer = math_solver(imInput) 
% read reference images
one = im2double(imread('1.png'));
two = im2double(imread('2.png'));
three = im2double(imread('3.png'));
four = im2double(imread('4.png'));
five = im2double(imread('5.png'));
six = im2double(imread('6.png'));
seven = im2double(imread('7.png'));
eight = im2double(imread('8.png'));
nine = im2double(imread('9.png'));
zero = im2double(imread('0.png'));
add = im2double(imread('a.png'));
subt = im2double(imread('s.png'));
mult = im2double(imread('m.png'));
div = im2double(imread('d.png'));

% store reference images into a cell vector
ops = cell(14, 1);
ops(1) = {one};
ops(2) = {two};
ops(3) = {three};
ops(4) = {four};
ops(5) = {five};
ops(6) = {six};
ops(7) = {seven};
ops(8) = {eight};
ops(9) = {nine};
ops(10) = {zero};
ops(11) = {add};
ops(12) = {subt};
ops(13) = {mult};
ops(14) = {div};

% read test image
% I = imread("simple1.png");
% I = imread("dark1.png"); 
% I = imread("dark2.jpg");
% I = imread("small1.png"); 
% I = imread("rotate90.png");
% I = imread('test1.png');
% I = imread("test2.png");
I = imread(imInput);
[m, n] = size(I);

% convert intensity values to doubles (0-1)
img = im2double(I);

% convert image to black and white
img = rgb2gray(img);

% adjust intensities
% img = imadjust(img);

% use gaussian filter to remove noise and smoothen image
% gaus_filter = fspecial('gaussian');
% img = imfilter(img, gaus_filter);
img = imgaussfilt(img);

% threshold image using bradley's method
% img will turn into a logical matrix
img = ~bradley(img, [50, 50]);

img = bwareaopen(img, 30);

% remove noise using the median filter
% img = medfilt2(img, [5,5]);

% remove noise using morphologi cal operations
% se = strel('square', 4);
% img = imopen(img, se);

% convert back from logical to double
img = double(img);

% adjust the angle
ori = regionprops(img, 'Orientation');
angle = ori(1).Orientation;
img = imrotate(img, -angle);

% get components of img
[comps, len] = components(img);

% result image
% figure(1);
% subplot(1,2,1);
% imshow(I);
% title("Original");
% subplot(1,2,2);
% imshow(img);
% title("Result");

% figure;
% s = ceil(sqrt(len));
% for i=1:len
%     subplot(s, s, i);
%     imshow(cell2mat(comps(i)));
% end

% compare test image components against reference images
mse = zeros(size(ops, 1), 1);
result = zeros(len, 1);
for i=1:len
    for j=1:size(ops, 1)
        op = cell2mat(ops(j));
        comp = cell2mat(comps(i));
        
        % redo the connected components operations
        comp = imresize(comp, size(op));
        comp = imbinarize(comp);
        c = components(comp);
        
        comp = im2double(cell2mat(c(1)));
        comp = imresize(comp, size(op));
        mse(j) = immse(comp, op);
    end
    
    % find the best match
    best = min(mse);
    if best < 0.3
        result(i) = find(mse == min(mse));
%     else
%         error("Cannot find match for component " + int2str(i));
    end
end

% form expression
expr = "";
for i=1:size(result, 1)
    idx = result(i);
    if idx == 11
        expr = append(expr, '+');
    elseif idx == 12
        expr = append(expr, '-');
    elseif idx == 13
        expr = append(expr, '*');
    elseif idx == 14
        expr = append(expr, '/');
    else
        expr = append(expr, int2str(result(i)));
    end
end

answer = eval(expr);


end 
% pause;
% close all;

% function [result] = component(I, C)
% % Return a matrix in which all non-component 
% % indices are set to 0 (black)
% I(1:min(C)-1) = 0;
% I(max(C)+1:end) = 0;
% result = I;
% end