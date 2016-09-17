function outCoeffs = WPT_convRow(inCoeffs,decompHi,decompLo)

for row = 1:noRow
   convRH = conv(decompHi,inCoeffs(row,:));
   hiCoeff(row,:) = downsample(convRH,2);
   convRL = conv(decompLo,inCoeffs(row,:));
   loCoeff(row,:) = downsample(convRL,2);
end

outCoeffs = horzcat(loCoeff,hiCoeff);

end