function [rms,reconIm,coeffIm] = WPT_main(ogIm,comp,waveletStr, noLevels)

waitBar = waitbar(0,'Applying WPT compression');

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
   waitbar(i/6)
   imLayer(:,:,i) = double(padIm(:,:,i));
   coeffLayer(:,:,i) = WPT_decompose(imLayer(:,:,i),decompHi,decompLo,noLevels); 
end
   comprsdCoeff = WPT_removeSmallest(coeffLayer, comp, noPadPixels, ogDim);
   
for i = 1:noChannel
   waitbar((i+3)/6)
   
   reconLayer = WPT_reconstruct(comprsdCoeff(:,:,i),reconLo,reconHi,noLevels);

   reconIm(:,:,i) = reconLayer;
   errorIm(:,:,i) = imLayer(:,:,i)-reconLayer;
   coeffIm(:,:,i) = coeffLayer(:,:,i);
   comprsdIm(:,:,i) = comprsdCoeff(:,:,i);
end

errorSq = errorIm.^2;
errorSq = mean(mean(mean(errorSq)));
rms = sqrt(errorSq);
reconIm = uint8(reconIm(1:ogDim(1),1:ogDim(2),:));

close(waitBar)

end