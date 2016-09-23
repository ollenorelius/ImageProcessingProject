%blockproc

close all
im = imread('im2.jpg');
track = zeros(1,100);
for j = 1:1
    j
    track(j) = DCT_main(im,j/30,true, false,false);
end
%plot((1:100)/30,track)