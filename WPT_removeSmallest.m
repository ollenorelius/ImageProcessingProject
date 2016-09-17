function image = WPT_removeSmallest(image, ratio)

imageX = size(image,1);
imageY = size(image,2);

r = reshape(image,1,[])
removeCount = 64*((ratio-1)/ratio);
for i = 1:removeCount
    [~, idx] = min(abs(r));
    r(idx) = 999999;
end
r(r==999999) = 0;

image = reshape(r, imageX, imageY);