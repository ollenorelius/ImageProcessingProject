function outCoeffs = WPT_convRow(inCoeffs,decompHi,decompLo)

[noRowIn,noColIn] = size(inCoeffs);
hiCoeff = zeros(noRowIn,noColIn/2);
loCoeff = hiCoeff;

for row = 1:noRowIn
   shiftCoeffs = circshift(inCoeffs(row,:),[0,2]);
   convRH = conv(shiftCoeffs,decompHi,'same');
   hiCoeff(row,:) = downsample(convRH,2,1);
   convRL = conv(shiftCoeffs,decompLo,'same');
   loCoeff(row,:) = downsample(convRL,2,1);
end

outCoeffs = horzcat(loCoeff,hiCoeff);

end