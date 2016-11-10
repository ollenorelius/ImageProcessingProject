function [image,noPadPixels] = WPT_padPower2(image)
imageX = size(image,1);
imageY = size(image,2);
padImageX = 2^nextpow2(imageX);
padImageY = 2^nextpow2(imageY);
image = padarray(image, [padImageX - imageX, padImageY - imageY], 0, 'post');
noPadPixels = (padImageX*padImageY)-(imageX*imageY);
