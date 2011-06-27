

x = [1 0;
     0 1;
     1 1];
y = [1,-1,1];
[w,b,fval,e] = primalSVM(x,y,1);
assert(e==1);
assert(sum(abs( w - [2;0;-1]))<1e-5);


% unsolvabale: xor
x = [1 0;
     0 1;
     1 1;
     0 0];
y = [1,1,-1,-1];
[w,b,fval,e] = primalSVM(x,y,1);
assert(e==-2);

y = [1,-1,-1,1];
[w,fval,e] = primalSVM(x,y);
assert(sum(abs( w - [0;-2;1]))<1e-5);

pred = x*w(1:end-1) + w(end);
assert(all(sign(pred)==y))

x = randn(100,2);
x(1:50,:) = x(1:50,:) + 2;
x(51:end,:) = x(51:end,:) - 2;
y = ones(100,1);y(1:50)=-1;
[w,b,fval,e] = primalSVM(x,y,1);

figure(1); clf; hold on
plot(x(1:50,1),x(1:50,2),'ro');
plot(x(51:end,1),x(51:end,2),'bo');
