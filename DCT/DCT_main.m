function [rms, trans_T] = DCT_main(im, comp, blockSize, showImages, parallel)

padX = mod(size(im,1), blockSize);
padY = mod(size(im,2), blockSize);

global compR

compR = comp;

oX = size(im,1);
oY = size(im,2);

im = padarray(im, [padX, padY], 'symmetric', 'post');

nChan = size(im,3);

if(parallel == true) %Decomposition
    parfor i = 1:nChan
        imPart = im(:,:,i);
        
        trans(:,:,i) = blockproc(imPart, [blockSize blockSize], @DCT_decomp);
        
    end
else
    for i = 1:nChan
        imPart = im(:,:,i);
        
        trans(:,:,i) = blockproc(imPart, [blockSize blockSize], @DCT_decomp);
        
    end
end

before = nextpow2(size(unique(round(reshape(trans,1,[]))),2));
before = before * size(find(trans),1);

compression = @DCT_quantTrunc;
if(parallel == true) %Quantization
    parfor i = 1:nChan
        transP = trans(:,:,i);
        
        trans(:,:,i) = round(blockproc(transP, [blockSize blockSize], compression));
        
    end
else
    for i = 1:nChan
        transP = trans(:,:,i);
      
        trans(:,:,i) = round(blockproc(transP, [blockSize blockSize], compression));
        
    end
end

after = nextpow2(size(unique(reshape(trans,1,[])),2));
after = after * size(find(trans),1);

nnZero = nnz(trans);

if(parallel == true) %Reconstruction
    parfor i = 1:nChan
        transP = trans(:,:,i);
        
        imRec(:,:,i) = blockproc(transP, [blockSize blockSize], @DCT_recomp);
        
    end
else
    for i = 1:nChan
        transP = trans(:,:,i);
        
        imRec(:,:,i) = blockproc(transP, [blockSize blockSize], @DCT_recomp);
        
    end
end

imRec = uint8(imRec(1:end-padX,1:end-padY,:));
im = im(1:end-padX,1:end-padY,:);

calcComp = after/before;
calcComp = nnZero/(oX*oY)

trans_T = uint8(trans);
if showImages
    figure()
    imagesc(im);
    title('Original image');
    figure()
    imagesc(imRec);
    title('reconstructed image')
    
    figure()
    error = abs(im-imRec);
    imagesc(uint8(error))
    title('error')
end
%imwrite(imRec, gray(256), sprintf('imDump/DCT_%ix%i_%ixc_%s.png', blockSize, blockSize, comp, imName));
error = abs(im-imRec);
rms = sqrt(mean(mean(mean(error.^2))));

end