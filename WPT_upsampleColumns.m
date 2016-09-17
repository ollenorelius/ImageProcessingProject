function image = WPT_upsampleColumns(image)
imageX = size(image,2);
imageY = size(image,1);
imageN = zeros(imageY, imageX*2);
imageN(:,1:2:2*imageX-1) = image;
imageN(:,2:2:2*imageX) = image;

image = imageN;
