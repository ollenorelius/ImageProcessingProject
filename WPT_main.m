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

parfor i = 1:noChannel
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

%reconIm = uint8(reconIm(1:ogIm(1),1:ogIm(2),:));

figure(1)
imagesc(coeffIm)
title('Wavelet Coefficients')
figure(2)
imagesc(comprsdIm)
title('Compressed wavelet coefficients')


end