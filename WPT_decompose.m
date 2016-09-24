function coeffArray = WPT_decompose(imPart,decompHi,decompLo,noLevels)

global decompH decompL;
decompH = decompHi;
decompL = decompLo;

coeffArray = imPart;
[ogNoRows,ogNoCols] = size(imPart);

for levels = 1:noLevels
    horzCoeffH = blockproc(coeffArray,[ogNoRows ogNoCols/(2^(levels-1))], @WPT_convRow);
    horzCoeffL = blockproc(coeffArray,[ogNoRows ogNoCols/(2^(levels-1))], @WPT_convRowL);
    horzCoeff = horzcat(horzCoeffL,horzCoeffH);
    vertCoeffH = blockproc(horzCoeff,[ogNoRows/(2^(levels-1)) ogNoCols], @WPT_convCol);
    vertCoeffL = blockproc(horzCoeff,[ogNoRows/(2^(levels-1)) ogNoCols], @WPT_convColL);
    coeffArray = vertcat(vertCoeffL,vertCoeffH);
end

end