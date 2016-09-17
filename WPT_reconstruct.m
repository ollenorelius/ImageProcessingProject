function image_out = WPT_reconstruct(image_in, wave_lo, wave_hi, levels)

Q1 = image_in(1:end/2, 1:end/2);
Q2 = image_in(1:end/2, end/2+1:end);
Q3 = image_in(end/2+1:end, 1:end/2);
Q4 = image_in(end/2+1:end, end/2+1:end);

if(levels > 1)
    Q1 = WPT_reconstruct(imag, wave_lo, wave_hi, levels-1);
end

Q1 = WPT_upsampleRows(Q1);
Q2 = WPT_upsampleRows(Q2);
Q3 = WPT_upsampleRows(Q3);
Q4 = WPT_upsampleRows(Q4);

for i = 1:size(Q1,2)
    Q1(:,i) = conv(Q1(:,i),wave_lo,'same');
end

for i = 1:size(Q2,2)
    Q2(:,i) = conv(Q2(:,i),wave_hi,'same');
end

for i = 1:size(Q3,2)
    Q3(:,i) = conv(Q3(:,i),wave_lo,'same');
end

for i = 1:size(Q4,2)
    Q4(:,i) = conv(Q4(:,i),wave_hi,'same');
end

Ql = Q1+Q2;
Qh = Q3+Q4;

Ql = WPT_upsampleColumns(Ql);
Qh = WPT_upsampleColumns(Qh);

for i = 1:size(Ql,1)
    Ql(i,:) = conv(Ql(i,:),wave_lo,'same');
end

for i = 1:size(Qh,1)
    Qh(i,:) = conv(Qh(i,:),wave_hi,'same');
end

image_out = Ql+Qh;  