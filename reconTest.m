close all;
waveletStr = 'rbio6.8';
inpIm = imread('dank.jpg');
nLevels = 3;


[~, ~, decon] = WPT_main(inpIm, 1, waveletStr, nLevels);

[Rf,Df] = biorwavf(waveletStr);
[decompLo,decompHi,reconLo,reconHi] = biorfilt(Df,Rf);
picRecon = zeros(size(decon));
for i = 1:3
    picRecon(:,:,i) = WPT_reconstruct(decon(:,:,i), reconLo, reconHi, nLevels);
end
figure()
imagesc(picRecon/max(max(max(picRecon-min(min(min(picRecon))))))*3)
title('recon')
figure();

imagesc(inpIm)
title('original')