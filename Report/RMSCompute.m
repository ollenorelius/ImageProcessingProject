function RMS = RMSCompute(original,recon)

diff = original - recon;
sumDiffSq = sum(sum(diff.^2));
RMS = sqrt(sumDiffSq/(size(diff,1)*size(diff,2)));

end