function rms = DCT_main(im, comp, showImages)

global compRatio_DCT;
compRatio_DCT = comp;

for i = 1:3
    imPart = im(:,:,i);
    
    trans(:,:,i) = blockproc(imPart, [8 8], @DCT_truncFun);
    
end
if showImages
    trans_T = uint8(trans);
    imagesc(im);
    figure()
    image(trans_T);
    figure();
    error = abs(double(im)-trans);
    imagesc(uint8(error))
end
error = abs(double(im)-trans);
rms = sqrt(mean(mean(mean(error.^2))));

end