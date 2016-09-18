function [rms,reconIm] = WPT_main(ogIm,comp,waveletStr)

noLevels = 3;
[Rf,Df] = biorwavf(waveletStr);
[decompHi,decompLo,reconLo,reconHi] = biorfilt(Df,Rf);
padIm = WPT_padPower2(ogIm);
noChannel = size(padIm,3);
reconIm = zeros(size(padIm));
coeffIm = reconIm;

for i = 1:noChannel
   imLayer = double(padIm(:,:,i));
   coeffLayer = WPT_decompose(imLayer,decompHi,decompLo,noLevels); 
   comprsdCoeff = WPT_removeSmallest(coeffLayer, comp);
   reconLayer = WPT_reconstruct(comprsdCoeff,reconLo,reconHi,noLevels);
   % Compute Error
   reconIm(:,:,i) = reconLayer;
   coeffIm(:,:,i) = coeffLayer;
end

figure
imshow(coeffIm)
title('WPT coefficients')

end