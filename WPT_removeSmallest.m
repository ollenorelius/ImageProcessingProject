function image = WPT_removeSmallest(image, ratio, noPadPixels)

imageX = size(image,1);
imageY = size(image,2);

r = reshape(image,1,[]);
removeCount = (imageX*imageY)*((ratio-1)/ratio)+noPadPixels;
[~, I] = sort(r);
r(I(1:removeCount)) = 0;
image = reshape(r, imageX, imageY);