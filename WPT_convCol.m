function outCoeffs = WPT_convCol(inCoeffs,decompHi,decompLo)

[noRowIn,noColIn] = size(inCoeffs);
hiCoeff = zeros(noRowIn/2,noColIn);
loCoeff = hiCoeff;

%convCH = zeros(noRowIn,noColIn);
%convRL = zeros(noRowIn,noColIn);

%shiftCoeffs = circshift(inCoeffs,[2,0]);
shiftCoeffs = wextend('addrow','sp0',inCoeffs,ceil(size(decompHi,2)/2));

for col = 1:noColIn   
   convCH(:,col) = conv(shiftCoeffs(:,col),decompHi','valid');   
   convRL(:,col) = conv(shiftCoeffs(:,col),decompLo','valid');   
end
hiCoeff = downsample(convCH,2,1);
loCoeff = downsample(convRL,2,1);

outCoeffs = vertcat(loCoeff,hiCoeff);

end