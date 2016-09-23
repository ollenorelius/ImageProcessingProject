waveletStr = 'bior4.4';
inpIm = imread('dank.jpg');

[~, ~, decon] = WPT_main(inpIm, 5, waveletStr);

[Rf,Df] = biorwavf(waveletStr);
[decompLo,decompHi,reconLo,reconHi] = biorfilt(Df,Rf);

picRecon = WPT_reconstruct(decon, reconLo, reconHi, 2);


imagesc(picRecon)
figure();
imagesc(inpIm(:,:,1))