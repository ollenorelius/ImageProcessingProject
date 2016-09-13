%blockproc

close all
im = imread('im2.jpg');
track = zeros(1,100);
parfor j = 1:100
    j
    track(j) = DCT_main(im,j/30,false);
end
plot((1:100)/30,track)