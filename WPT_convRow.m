function outCoeffs = WPT_convRow(inCoeffs,decompHi,decompLo)

noRow = size(inCoeffs,1);

for row = 1:noRow
   convRH = conv(decompHi,inCoeffs(row,:));
   hiCoeff(row,:) = downsample(convRH,2);
   convRL = conv(decompLo,inCoeffs(row,:));
   loCoeff(row,:) = downsample(convRL,2);
end

outCoeffs = horzcat(hiCoeff,loCoeff);

end