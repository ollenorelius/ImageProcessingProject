function outCoeffs = WPT_convCol(inCoeffs,decompHi,decompLo)

noCol = size(inCoeffs,2);

for col = 1:noCol
   convCH = conv(decompHi',inCoeffs(:,col));
   hiCoeff(:,col) = downsample(convCH,2);
   convRL = conv(decompLo',inCoeffs(:,col));
   loCoeff(:,col) = downsample(convRL,2);
end

outCoeffs = vertcat(hiCoeff,loCoeff);

end