close all;
tic
waveletStr = 'bior4.4';
inpIm = imread('dank.jpg');
%inpIm = imread('im2.jpg');
nLevels = 5;

xSize = size(inpIm,2);
ySize = size(inpIm,1);

[rms, picRecon, decon] = WPT_main(inpIm, 100, waveletStr, nLevels);

[Rf,Df] = biorwavf(waveletStr);
[decompLo,decompHi,reconLo,reconHi] = biorfilt(Df,Rf);
%picRecon = zeros(size(decon));
nLayers = size(inpIm,3);
%for i = 1:nLayers
%    picRecon(:,:,i) = WPT_reconstruct(decon(:,:,i), reconLo, reconHi, nLevels);
%end
figure()
imagesc(uint8(picRecon(1:ySize,1:xSize,:)))
%imagesc(picRecon)
title('recon')

figure();
imagesc(inpIm)
title('original')

figure();
diff = abs(double(inpIm)-picRecon(1:ySize,1:xSize,:));
imagesc(diff./max(max(max(diff))))
title('diff')

toc