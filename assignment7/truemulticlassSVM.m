function [w,b,fval,e,A] = truemulticlassSVM(x,y);
    
% min 0.5* ||w||^2 + Csum(slack)
            
dim = size(x,1);
N = size(x,2)
assert(numel(y)==N);

numclasses = 10;

A = zeros(numclasses*N,numclasses *(dim+1));
current = 1;
for i=1:N
	i
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
b = -ones(numclasses*N,1);
f = zeros(size(A,2),1);

H = eye(numclasses*(dim+1));
for i=numclasses*dim +1 :numclasses*(dim+1)
	H(i,i) = 0;
end

opts = optimset;
opts.LargeScale = 'off';
[w,fval,e] = quadprog(H,f,A,b,[],[],[],[],[],opts);
b=0;

