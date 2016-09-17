function ret = DCT_truncFun(inputM)
    
    global compRatio_DCT blckSize;
    inputM.data;
    
    blockSize = blckSize;
    padX = blockSize-size(inputM.data,1);
    padY = blockSize-size(inputM.data,2);
    
    pad = padarray(inputM.data, [padX, padY], 'symmetric', 'post');
    
    trans = dct2(pad);
    
    multi = compRatio_DCT;
    
    r = reshape(trans, 1,[]);
    
    removeCount = (blockSize^2)*((multi-1)/multi);
    for i = 1:removeCount
        [~, idx] = min(abs(r));
        r(idx) = 999999;
    end
    r(r==999999) = 0;
    
    trans = reshape(r,blockSize,[]);
    
    iTrans = idct2(trans);
    ret = iTrans(1:end-padX,1:end-padY);
end