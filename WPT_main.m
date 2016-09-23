function [rms,reconIm] = WPT_main(ogIm,comp,waveletStr)

noLevels = 1;
[Rf,Df] = biorwavf(waveletStr);
[decompLo,decompHi,reconLo,reconHi] = biorfilt(Df,Rf);
padIm = WPT_padPower2(ogIm);
noChannel = size(padIm,3);
reconIm = zeros(size(padIm));
coeffIm = reconIm;

for i = 1:noChannel
   imLayer = double(padIm(:,:,i));
   coeffLayer = WPT_decompose(imLayer,decompHi,decompLo,noLevels); 
   comprsdCoeff = WPT_removeSmallest(coeffLayer, comp);
   %reconLayer = WPT_reconstruct(comprsdCoeff,reconLo,reconHi,noLevels);
   % REMOVE LATER!!
   figure(1)
   imagesc(coeffLayer)
   title('coeffs')
   figure(2)
   imagesc(comprsdCoeff)
   title('compressed')
   % Compute Error
   %reconIm(:,:,i) = reconLayer;
   coeffIm(:,:,i) = coeffLayer;
end


end