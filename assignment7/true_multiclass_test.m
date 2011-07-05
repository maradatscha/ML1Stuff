clear all;
close all;

load usps_all.mat;

num_train = 20;

train_data = data(:,1:num_train,:);
validation_data = data(:,101:200,:);
test_data = data(:,201:end,:);

train_mean = mean(double(train_data), 2);

train_data = double(train_data)-repmat(train_mean, [1 num_train 1]);
validation_data = double(validation_data)-repmat(train_mean, [1 100 1]);
test_data = double(test_data)-repmat(train_mean, [1 900 1]);

train = reshape(train_data, size(train_data,1), size(train_data,2)*size(train_data,3));

y = [];
for i=1:10
	ya = i* ones(num_train,1);
	y = [y ; ya];
end
size(y)

%[w,b,fval,e,A] = truemulticlassSVM(train, y);
x = train;

[dim N] = size(x);
assert(numel(y)==N);

numclasses = 10;

A = zeros((numclasses-1)*N,numclasses*dim+N);
current = 1;
for i=1:N
	for j=1:numclasses
		if(y(i)~=j)
			A(current,(y(i)-1)*dim+1:y(i)*dim) = x(:,i);	
			A(current,(j-1)*dim+1:j*dim) = -x(:,i);
			A(current,numclasses*dim+i) = 1;
			current = current + 1;
		end
	end
end
A = -A;
b = -ones(size(A,1),1);
f = zeros(size(A,2),1);

H = eye(size(A,2));
for i=numclasses*dim +1 :numclasses*dim+N
	H(i,i) = 0;
	f(i) = 1;
end
imagesc(H)
opts = optimset;
opts.LargeScale = 'off';
[w,fval,e] = quadprog(H,f,A,b,[],[],[],[],[],opts);
b=0;

