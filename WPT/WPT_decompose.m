function coeffArray = WPT_decompose(imPart,decompHi,decompLo,noLevels)

coeffArray = imPart;
horzCoeff = WPT_convRow(coeffArray,decompHi,decompLo);
coeffArray = WPT_convCol(horzCoeff,decompHi,decompLo);

LL = coeffArray(1:(end/2),1:(end/2));
LH = coeffArray(1:(end/2),((end/2)+1):end);
HL = coeffArray(((end/2)+1):end,1:(end/2));
HH = coeffArray(((end/2)+1):end,((end/2)+1):end);

if noLevels>1
    LL = WPT_decompose(LL,decompHi,decompLo,noLevels-1);
    LH = WPT_decompose(LH,decompHi,decompLo,noLevels-1);
    HL = WPT_decompose(HL,decompHi,decompLo,noLevels-1);
    HH = WPT_decompose(HH,decompHi,decompLo,noLevels-1);
end

L = horzcat(LL,LH);
H = horzcat(HL,HH);
coeffArray = vertcat(L,H);

end