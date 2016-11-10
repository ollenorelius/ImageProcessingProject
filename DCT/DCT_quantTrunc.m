function ret = DCT_quantTrunc(inputM)
qm = [1 11 10 16 24 40 51 61; 12 12 14 19 26 58 60 55;... %Matrix was found online somewhere, not chosen for any specific quality
    14 13 16 24 40 57 69 56; 14 17 22 29 51 87 80 62; ...
    18 22 37 56 68 109 103 77; 24 35 55 64 81 104 113 92;...
    49 64 78 87 103 121 120 101; 72 92 95 98 112 100 103 99];

blockSize = size(inputM.data,1);
mult = blockSize / 8; %multiplier for rescaling if blocksize != 8
qm = imresize(qm,mult);
trans = inputM.data;  %trans as in transformed data
global compR;
trans = trans ./ (qm*compR); %divide by quantization matrix scaled with compression factor

ret = (qm).*round(trans); %round (quantize), scale back and return
end