function [rms,reconIm,comprsdIm] = WPT_main(ogIm,comp,waveletStr, noLevels)

[Rf,Df] = biorwavf(waveletStr);
[decompLo,decompHi,reconLo,reconHi] = biorfilt(Df,Rf);
[padIm,noPadPixels] = WPT_padPower2(ogIm);
ogDim = size(ogIm);
noChannel = size(padIm,3);
reconIm = zeros(size(padIm));
coeffIm = reconIm;
comprsdIm = reconIm;
errorIm = reconIm;

for i = 1:noChannel
   imLayer = double(padIm(:,:,i));
   coeffLayer = WPT_decompose(imLayer,decompHi,decompLo,noLevels); 
   comprsdCoeff = WPT_removeSmallest(coeffLayer, comp, noPadPixels, ogDim);
   reconLayer = WPT_reconstruct(comprsdCoeff,reconLo,reconHi,noLevels);

   reconIm(:,:,i) = reconLayer;
   errorIm(:,:,i) = imLayer-reconLayer;
   coeffIm(:,:,i) = coeffLayer;
   comprsdIm(:,:,i) = comprsdCoeff;
end

errorSq = errorIm.^2;
errorSq = mean(mean(mean(errorSq)));
rms = sqrt(errorSq);

figure(1)
imshow(coeffIm)
title('Wavelet Coefficients')
figure(2)
imshow(comprsdIm)
title('Compressed wavelet coefficients')
figure(3)
imagesc(reconLayer)
imshow('Reconstructed layer')

end