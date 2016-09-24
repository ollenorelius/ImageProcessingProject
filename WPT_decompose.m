function coeffArray = WPT_decompose(imPart,decompHi,decompLo,noLevels)

coeffArray = imPart;
for levels = 1:noLevels
    horzCoeff = WPT_convRow(coeffArray,decompHi,decompLo);
    coeffArray = WPT_convCol(horzCoeff,decompHi,decompLo);
end

end