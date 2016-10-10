function [rms, trans_T] = DCT_main(im, comp, blockSize, showImages, parallel)

close all

padX = mod(size(im,1), blockSize);
padY = mod(size(im,2), blockSize);

im = padarray(im, [padX, padY], 'symmetric', 'post');


if(parallel == true) %Decomposition
    parfor i = 1:3
        imPart = im(:,:,i);
        
        trans(:,:,i) = blockproc(imPart, [blockSize blockSize], @DCT_decomp);
        
    end
else
    for i = 1:3
        imPart = im(:,:,i);
        
        trans(:,:,i) = blockproc(imPart, [blockSize blockSize], @DCT_decomp);
        
    end
end

before = nextpow2(size(unique(round(reshape(trans,1,[]))),2));
before = before * size(find(trans),1);

compression = @DCT_quantTrunc;
%compression = @DCT_truncFun;
if(parallel == true) %Quantization
    parfor i = 1:3
        transP = trans(:,:,i);
        
        trans(:,:,i) = comp.*round(blockproc(transP./comp, [blockSize blockSize], compression));
        
    end
else
    for i = 1:3
        transP = trans(:,:,i);
      
        trans(:,:,i) = comp.*round(blockproc(transP./comp, [blockSize blockSize], compression));
        
    end
end

after = nextpow2(size(unique(reshape(trans,1,[])),2));
after = after * size(find(trans),1);

if(parallel == true) %Reconstruction
    parfor i = 1:3
        transP = trans(:,:,i);
        
        imRec(:,:,i) = blockproc(transP, [blockSize blockSize], @DCT_recomp);
        
    end
else
    for i = 1:3
        transP = trans(:,:,i);
        
        imRec(:,:,i) = blockproc(transP, [blockSize blockSize], @DCT_recomp);
        
    end
end

imRec = uint8(imRec(1:end-padX,1:end-padY,:));
im = im(1:end-padX,1:end-padY,:);

calcComp = after/before

trans_T = uint8(trans);
if showImages
    imagesc(im);
    figure()
    image(imRec);
    figure()
    error = abs(im-imRec);
    imagesc(uint8(error))
end
error = abs(im-imRec);
rms = sqrt(mean(mean(mean(error.^2))));

end