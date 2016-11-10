function image = WPT_upsampleRows(image)
imageX = size(image,2);
imageY = size(image,1);
imageN = zeros(imageY*2, imageX);
imageN(1:2:2*imageY-1, :) = image;
imageN(2:2:2*imageY, :) = 0;

image = imageN;
