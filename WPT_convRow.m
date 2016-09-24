function hiCoeff = WPT_convRow(inCoeffs)

global decompH;

inCoeffs = inCoeffs.data;
[noRowIn,noColIn] = size(inCoeffs);
hiCoeff = zeros(noRowIn,noColIn/2);

for row = 1:noRowIn
   convRH = conv(inCoeffs(row,:),decompH,'same');
   hiCoeff(row,:) = downsample(convRH,2,1);
end

end