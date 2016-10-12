function ret = DCT_truncFun(inputM)
    blockSize = size(inputM.data,1);
    
    %compR = 8;
    
    r = reshape(inputM.data, 1,[]);
    removeCount = round((blockSize^2)*((compR-1)/compR));
    [~, idx] = sort(abs(r));
    r(idx(1:removeCount)) = 0;
    ret = reshape(r,blockSize,[]);
    
end