function loCoeff = WPT_convRowL(inCoeffs)

global decompL;

inCoeffs = inCoeffs.data;
[noRowIn,noColIn] = size(inCoeffs);
loCoeff = zeros(noRowIn,noColIn/2);

for row = 1:noRowIn
   convRL = conv(inCoeffs(row,:),decompL,'same');
   loCoeff(row,:) = downsample(convRL,2,1);
end

end