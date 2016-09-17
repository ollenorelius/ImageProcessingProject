function coeffArray = WPT_decompose(imPart,decompHi,decompLo)

% 1 Level Decomp
horzCoeff = WPT_convRow(imPart,decompHi,decompLo);
coeffArray = WPT_convCol(horzCoeff,decompHi,decompLo);

% Plot!! Can remove later
figure
imshow(coeffArray)

end