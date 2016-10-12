function ret = DCT_quantTrunc(inputM)
qm = [1 11 10 16 24 40 51 61; 12 12 14 19 26 58 60 55;...
    14 13 16 24 40 57 69 56; 14 17 22 29 51 87 80 62; ...
    18 22 37 56 68 109 103 77; 24 35 55 64 81 104 113 92;...
    49 64 78 87 103 121 120 101; 72 92 95 98 112 100 103 99];

blockSize = size(inputM.data,1);
mult = blockSize / 8;
qm = imresize(qm,mult);
trans = inputM.data;
global compR;
%trans = trans ./ qm;

r = reshape(trans, 1,[]);
removeCount = round((inputM.blockSize(1)*inputM.blockSize(2))*((compR-1)/compR));
[~, idx] = sort(abs(r));
r(idx(1:removeCount)) = 0;
ret = reshape(r,blockSize,[]);

%ret = qm.* ret;

%ret = (qm).*round(trans./(qm));
end