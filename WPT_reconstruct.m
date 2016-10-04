function image_out = WPT_reconstruct(image_in, wave_lo, wave_hi, levels)

Q1 = image_in(1:end/2, 1:end/2);  %Split input into quarters
Q3 = image_in(1:end/2, end/2+1:end);
Q2 = image_in(end/2+1:end, 1:end/2);
Q4 = image_in(end/2+1:end, end/2+1:end);

if(levels > 1)
    Q1 = WPT_reconstruct(Q1, wave_lo, wave_hi, levels-1);
    Q2 = WPT_reconstruct(Q2, wave_lo, wave_hi, levels-1);
    Q3 = WPT_reconstruct(Q3, wave_lo, wave_hi, levels-1);
    Q4 = WPT_reconstruct(Q4, wave_lo, wave_hi, levels-1);
end



Q1 = WPT_upsampleRows(Q1);
Q2 = WPT_upsampleRows(Q2);
Q3 = WPT_upsampleRows(Q3);
Q4 = WPT_upsampleRows(Q4);

% Qa = vertcat(Q1,Q3);
% 
% for i = 1:size(Q1,2)
%     Qa(:,i) = conv(Qa(:,i),wave_lo,'same');
% end
% Q1 = Qa(1:end/2,:);
% Q3 = Qa(end/2+1:end,:);
% 
% Qb = vertcat(Q1,Q3);
% 
% for i = 1:size(Q1,2)
%     Qb(:,i) = conv(Qb(:,i),wave_hi,'same');
% end
% Q2 = Qb(1:end/2,:);
% Q4 = Qb(end/2+1:end,:);

padSize = ceil(size(wave_lo,2)/2);

extMode = 'symw';

Q1 = wextend('addrow',extMode,Q1,padSize);
Q2 = wextend('addrow',extMode,Q2,padSize);
Q3 = wextend('addrow',extMode,Q3,padSize);
Q4 = wextend('addrow',extMode,Q4,padSize);

for i = 1:size(Q1,2)
   q1(:,i) = conv(Q1(:,i),wave_lo);
end
Q1 = q1(padSize*2:size(Q1,1)-1,:);

for i = 1:size(Q2,2)
   q2(:,i) = conv(Q2(:,i),wave_hi);
end
Q2 = q2(padSize*2:size(Q2,1)-1,:);

for i = 1:size(Q3,2)
   q3(:,i) = conv(Q3(:,i),wave_lo);
end
Q3 = q3(padSize*2:size(Q3,1)-1,:);

for i = 1:size(Q4,2)
   q4(:,i) = conv(Q4(:,i),wave_hi);
end
Q4 = q4(padSize*2:size(Q4,1)-1,:);

Ql = Q1+Q2;
Qh = Q3+Q4;

Ql = WPT_upsampleColumns(Ql);
Qh = WPT_upsampleColumns(Qh);

Ql = wextend('addcol',extMode,Ql,padSize);
Qh = wextend('addcol',extMode,Qh,padSize);

for i = 1:size(Ql,1)
    ql(i,:) = conv(Ql(i,:),wave_lo);
end
Ql = ql(:,padSize*2:size(Ql,2)-1);

for i = 1:size(Qh,1)
    qh(i,:) = conv(Qh(i,:),wave_hi);
end
Qh = qh(:,padSize*2:size(Qh,2)-1);

image_out = (Ql+Qh);  