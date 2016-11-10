function image = WPT_removeSmallest(image, ratio, noPadPixels, ogDim)

imageX = size(image,1);
imageY = size(image,2);


R = image(:,:,1);
G = image(:,:,2);
B = image(:,:,3);

vals = sqrt(R.^2 + G.^2 + B.^2);

v = reshape(vals,1,[]);
R = reshape(R,1,[]);
G = reshape(G,1,[]);
B = reshape(B,1,[]);

removeCount = round((ogDim(1)*ogDim(2))*((ratio-1)/ratio))+noPadPixels;
fprintf('Removing %i pixels (%i including padding) from image of %i (%i including padded)\n', removeCount-noPadPixels, removeCount, ogDim(1)*ogDim(2), imageX*imageY);
[~, I] = sort(v);
R(I(1:removeCount)) = 0;
G(I(1:removeCount)) = 0;
B(I(1:removeCount)) = 0;

R = reshape(R, imageX, imageY);
G = reshape(G, imageX, imageY);
B = reshape(B, imageX, imageY);

image = cat(3, R, G, B);