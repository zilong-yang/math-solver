op = imread('operators.png');
op = rgb2gray(im2double(op));
op = ~imbinarize(op);
op = im2double(op);

[comps, N] = components(op);

for i=1:N
    subplot(1, N, i);
    imshow(cell2mat(comps(i)));
end

opnames = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0', 'a', 's', 'm', 'd'];
[m, n] = size(opnames);

if N == n
    for i=1:N
        imwrite(cell2mat(comps(i)), opnames(i) + ".png");
    end
end