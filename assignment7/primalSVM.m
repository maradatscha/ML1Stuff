function [w,b,fval,e] = primalSVM(x,y,useb);
    
% min 0.5* ||w||^2
% sb.t. y_i<w,x_i> + b >= 1
            
if ~exist('useb','var')
    useb = 1;
end

[n,d] = size(x);
assert(numel(y)==n);

if useb
    A = [-diag(y)*[x, ones(n,1)]];
    b = -ones(n,1);
    H = eye(d);H(end+1,end+1)=0;
    f = zeros(d+1,1);
else
    A = -diag(y)*x;
    b = -ones(n,1);
    H = eye(d);
    f = zeros(d,1);
end

opts = optimset;
opts.LargeScale = 'off';
[w,fval,e] = quadprog(H,f,A,b,[],[],[],[],[],opts);

b = 0;
if useb
    b = w(end);
    w(end) = [];
end
