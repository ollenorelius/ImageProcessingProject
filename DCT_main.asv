function [rms, trans_T] = DCT_main(im, comp, blockSize, showImages, parallel)

global compRatio_DCT blckSze;
compRatio_DCT = comp;
blckSze = blockSize;

if(parallel == true)
    parfor i = 1:3
        imPart = im(:,:,i);
        
        trans(:,:,i) = blockproc(imPart, [blockSize blockSize], @DCT_truncFun);
        
    end
else
    for i = 1:3
        imPart = im(:,:,i);
        
        trans(:,:,i) = blockproc(imPart, [blockSize blockSize], @DCT_truncFun);
        
    end
end
trans_T = uint8(trans);
if showImages
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