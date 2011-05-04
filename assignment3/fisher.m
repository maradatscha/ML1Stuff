function w = fisher(X1, X2)
mean1 = mean(X1);
mean2 = mean(X2);

cov1 = cov(X1);
cov2 = cov(X2);

w = pinv(cov1+cov2)*(mean2 - mean1)';
