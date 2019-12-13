function [comps,len] = components(I)
% Gets the connected compoenents in I
% I: a BW image
% comps: a cell vector of matrices
% len: the number of components
cc = bwconncomp(I, 4);
len = cc.NumObjects;
rp = regionprops(cc, 'BoundingBox');
comps = cell(len, 1);
for i=1:len
    cropped = imcrop(I, rp(i).BoundingBox);
    comps(i) = {cropped};
end
end

