function loCoeff = WPT_convColL(inCoeffs)

global decompL;

inCoeffs = inCoeffs.data;
[noRowIn,noColIn] = size(inCoeffs);
loCoeff = zeros(noRowIn/2,noColIn);

for col = 1:noColIn
   convRL = conv(inCoeffs(:,col),decompL','same');
   loCoeff(:,col) = downsample(convRL,2,1);
end


end