function outCoeffs = WPT_convCol(inCoeffs,decompHi,decompLo)

[noRowIn,noColIn] = size(inCoeffs);
hiCoeff = zeros(noRowIn/2,noColIn);
loCoeff = hiCoeff;

for col = 1:noColIn
   convCH = conv(inCoeffs(:,col),decompHi','same');
   hiCoeff(:,col) = downsample(convCH,2,1);
   convRL = conv(inCoeffs(:,col),decompLo','same');
   loCoeff(:,col) = downsample(convRL,2,1);
end

outCoeffs = vertcat(loCoeff,hiCoeff);

end