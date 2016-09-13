function a = DCT_main(im)
a = 1;

for i = 1:3
    imPart = im(:,:,i);
    
    trans(:,:,i) = blockproc(imPart, [8 8], @DCT_truncFun);
    
end
trans = uint8(trans);
imagesc(im);
figure()
image(trans);
figure();
imagesc(abs(im-trans))


end