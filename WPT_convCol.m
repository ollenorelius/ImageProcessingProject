function hiCoeff = WPT_convCol(inCoeffs)

global decompH;

inCoeffs = inCoeffs.data;
[noRowIn,noColIn] = size(inCoeffs);
hiCoeff = zeros(noRowIn/2,noColIn);

for col = 1:noColIn
   convCH = conv(inCoeffs(:,col),decompH','same');
   hiCoeff(:,col) = downsample(convCH,2,1);
end

end