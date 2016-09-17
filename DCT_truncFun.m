function ret = DCT_truncFun(inputM)
    inputM.data;
    
    padX = 8-size(inputM.data,1);
    padY = 8-size(inputM.data,2);
    
    pad = padarray(inputM.data, [padX, padY], 'symmetric', 'post');
    
    trans = dct2(pad);
    
    global compRatio_DCT;
    multi = compRatio_DCT;
    
    r = reshape(trans, 1,[]);
    
    removeCount = 64*((multi-1)/multi);
    for i = 1:removeCount
        [~, idx] = min(abs(r));
        r(idx) = 999999;
    end
    r(r==999999) = 0;
    
    trans = reshape(r,8,[]);
    
    iTrans = idct2(trans);
    ret = iTrans(1:end-padX,1:end-padY);
end