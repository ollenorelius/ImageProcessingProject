waveletStr = 'rbio6.8';
ogIm = imread('dank.jpg');
noLevels = 1;
comp = 1;
%[rms,reconIm,comprsdIm] = WPT_main(ogIm,comp,waveletStr, noLevels);

for i = 1:3
    imageLayer = ogIm(:,:,i);
    [a,b,c,d] = dwt2(imageLayer,waveletStr);
end

