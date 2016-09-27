function ret = DCT_truncFun(inputM)
    
    global compRatio_DCT blckSze;
    inputM.data;
    
    blockSize = blckSze;
    padX = blockSize-size(inputM.data,1);
    padY = blockSize-size(inputM.data,2);
    
    pad = padarray(inputM.data, [padX, padY], 'symmetric', 'post');
    
    trans = dct2(pad);
    
    multi = compRatio_DCT;
    
    r = reshape(trans, 1,[]);
    removeCount = round((blockSize^2)*((multi-1)/multi));
    [~, idx] = sort(abs(r));
    r(idx(1:removeCount)) = 0;
    trans = reshape(r,blockSize,[]);
    
    iTrans = idct2(trans);
    ret = iTrans(1:end-padX,1:end-padY);
end