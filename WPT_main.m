function [rms reconIm] = WPT_main(ogIm, comp, waveletStr)
[Rf,Df] = biorwavf(waveletStr);
[decompHi,decompLo,reconLo,reconHi] = biorfilt(Df,Rf);
padIm = WPT_padPower2(ogIm);
noChannel = size(padIm,3);
reconIm = zeros(size(padIm));
for i = 1:noChannel
   imPart = padIm(:,:,i);
   coeffArray = WPT_decompose(imPart,decompHi,decompLo);
   comprsdIm = WPT_removeSmallest(coeffArray, comp);
   % Reconstruct and add layer to reconIm
   % Compute Error
end

end