function outCoeffs = WPT_convRow(inCoeffs,decompHi,decompLo)

[noRowIn,noColIn] = size(inCoeffs);
hiCoeff = zeros(noRowIn,noColIn/2);
loCoeff = hiCoeff;

%shiftCoeffs = circshift(inCoeffs,[0,2]);
shiftCoeffs = wextend('addcol','sp0',inCoeffs,ceil(size(decompHi,2)/2));

%convRH = zeros(noRowIn,noColIn);
%convRL = zeros(noRowIn,noColIn);

for row = 1:noRowIn   
   convRH(row,:) = conv(shiftCoeffs(row,:),decompHi,'valid');   
   convRL(row,:) = conv(shiftCoeffs(row,:),decompLo,'valid');   
end
hiCoeff = downsample(convRH',2,1)';
loCoeff = downsample(convRL',2,1)';
outCoeffs = horzcat(loCoeff,hiCoeff);

end