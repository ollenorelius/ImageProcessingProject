function [rms reconIm] = WPT_main(ogIm, comp, waveletStr)

[Rf,Df] = biorwavf(waveletStr);
[decompHi,decompLo,reconLo,reconHi] = biorfilt(Df,Rf);
noChannel = size(ogIm,3);
reconIm = zeros(size(ogIm));
for i = 1:noChannel
   imPart = ogIm(:,:,i);
   coeffArray = WPT_decompose(imPart,decompHi,decompLo);
   % Compress
   % Reconstruct and add layer to reconIm
   % Compute Error
end

end