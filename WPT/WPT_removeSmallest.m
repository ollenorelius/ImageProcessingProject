function image = WPT_removeSmallest(image, ratio, noPadPixels, ogDim)

imageX = size(image,1);
imageY = size(image,2);

nChannels = size(image,3);
sum = zeros(imageX, imageY);
for iChan = 1:nChannels
    sum = sum + image(:,:,iChan).^2;
end

vals = sqrt(sum);

v = reshape(vals,1,[]);


removeCount = round((ogDim(1)*ogDim(2))*((ratio-1)/ratio))+noPadPixels;
fprintf('Removing %i pixels (%i including padding) from image of %i (%i including padded)\n', removeCount-noPadPixels, removeCount, ogDim(1)*ogDim(2), imageX*imageY);
[~, I] = sort(v);
for iChan = 1:nChannels
    layer = image(:,:,iChan);
    layer(I(1:removeCount)) = 0;
    image(:,:,iChan) = layer;
end