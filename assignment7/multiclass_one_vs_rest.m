clear all;
close all;

load usps_all.mat;

train_data = data(:,1:100,:);
validation_data = data(:,101:200,:);
test_data = data(:,201:end,:);

train_mean = mean(double(train_data), 2);

train_data = double(train_data)-repmat(train_mean, [1 100 1]);
validation_data = double(validation_data)-repmat(train_mean, [1 100 1]);
test_data = double(test_data)-repmat(train_mean, [1 900 1]);

% set up parameters

B = [2,3,5,7];

np = size(train_data,2)*size(train_data,3);

g = zeros(np, np);

x = reshape(train_data, [256 1000]);
x = x'; 

xv = reshape(validation_data, [256 1000]);
xv = xv'; 

xt = reshape(test_data, [256 9000]);
xt = xt'; 

for i=1:np
  for j=i+1:np
    g(i,j) = norm(x(i,:)-x(j,:));
    g(j,i) = g(i,j);
  end
end


m = median(g(:));

l = [0.5*m, m, 5*m];

C = [0.01, 0.1, 1, 10, 100 ];

% one versus rest
%K = linear_own(x);
%[alpha,b,fval,e] = dualSVM(K,y);

si = 0;
st = 0;

% try RBF kernel
for i=1:3
  disp(i);
  
  pred_validation = zeros(1000,10);  
  K = rbf(x,l(i));
  Kv = rbf(xv,l(i),x); % 16. juni slide 11

  
  for j=1:10
    y = - ones(1000,1);
    y((j-1)*100+1:j*100) = 1;
    
    [alpha,b,fval,e] = dualSVM(K,y);
    
    assert(e==1);
    pred = sign(K*alpha+b);
    assert(all(pred==y));
    
    pred_validation(:,j) = Kv*alpha+b;
    
  end
  
  [p I] = max(pred_validation, [], 2);
  t = ones(1000,1);
  for j=1:10
    t((j-1)*100+1:j*100) = j;
  end
  sum(abs(I==t))
  if (sum(abs(I==t)) > st)
    st = sum(abs(I==t));
    si = i;
  end
  
end
disp(sprintf('RBF: geringste Fehler auf den Validierungsdaten mit gamma=%d, (err=%i)', l(si), ...
	(1000-st)));

rbfst = st;
rbfsi = si;

si = 0;
st = 0;

%try polynomial kernel
for i=1:4
  pred_validation = zeros(1000,10);
  K = poly(x,1,B(i));
  Kv = poly(xv,1,B(i),x); 
  for j=1:10
    y = - ones(1000,1);
    y((j-1)*100+1:j*100) = 1;
    
    [alpha,b,fval,e] = dualSVM(K,y);
    
    assert(e==1);
    pred = sign(K*alpha+b);
    assert(all(pred==y));
    
    
    pred_validation(:,j) = Kv*alpha+b;
    
  end
  
  [p I] = max(pred_validation, [], 2);
  t = ones(1000,1);
  for j=1:10
    t((j-1)*100+1:j*100) = j;
  end
  
  sum(abs(I==t))
  
  if (sum(abs(I==t)) > st)
    st = sum(abs(I==t));
    si = i;
  end
  
end

disp(sprintf('Poly: geringste Fehler auf den Validierungsdaten mit b=%d, (err=%i)', B(si), ...
	(1000-st)));


%train best on validation and training data
disp('running on test data')
if (rbfst> st)
  K = rbf([x;xv] ,l(rbfsi));
  Kv = rbf(xt,l(rbfsi), [x;xv]);
  disp('using rbf')
else 
  K = poly([x;xv],1,B(si));
  Kv = poly(xt,1,B(si),[x;xv]);
  size(Kv)
  disp('using poly')
end



pred_validation = zeros(9000,10);

for j=1:10
  y = - ones(2000,1);
  y((j-1)*100+1:j*100) = 1;
  y(1000+(j-1)*100+1:1000+j*100) = 1;
  
  [alpha,b,fval,e] = dualSVM(K,y);
  
  assert(e==1);
  pred = sign(K*alpha+b);
  assert(all(pred==y));
  
  
  pred_validation(:,j) = Kv*alpha+b;
  
end

[p I] = max(pred_validation, [], 2);
t = ones(9000,1);
for j=1:10
  t((j-1)*900+1:j*900) = j;
end


disp(sprintf('Final error is %i', (9000-sum(abs(I==t)))))
  