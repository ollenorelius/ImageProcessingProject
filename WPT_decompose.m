function coeffArray = WPT_decompose(imPart,decompHi,decompLo)

[noRow,noCol] = size(imPart);
% Rows
for row = 1:noRow
   hiCoeff(row,:) = conv(decompHi,imPart(row,:));
   loCoeff(row,:) = conv(decompLo,imPart(row,:));
end

end