close all;
clear all;

num_components = 3;
num_dimensions = 2;
num_samples = 100;

means = zeros([num_dimensions,num_components]);
variances = zeros([num_dimensions,num_dimensions,num_components]);

pis = [0.3 0.6 0.1];

means(:,1) = [0 0];
means(:,2) = [2 2];
means(:,3) = [-2 2];

variances(:,:,1) = [ 1 0  ; 0 1];
variances(:,:,2) = [ 1 0.5; 0.5 1];
variances(:,:,3) = [ 1 -0.3; 0.3 1];


samples = zeros([num_samples,2]);

is = 1;
ie = pis(1)*num_samples;

for i = 1:num_components
	c = num_samples*pis(i);
	R = chol(variances(:,:,i));
	z = repmat(means(:,i)',c,1) + randn(c,2)*R;
	samples(is:ie,:) = z;
	if i < num_components
		is = is + pis(i)*num_samples;
		ie = ie + pis(i+1)*num_samples;
	end
end

plot(samples(:,1), samples(:,2), '.')
