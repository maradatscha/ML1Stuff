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

% one versus one
%K = linear_own(x);
%[alpha,b,fval,e] = dualSVM(K,y);

si = 0;
st = 0;

% try RBF kernel
for i=1:3
  disp(i);
  
  pred_validation = zeros(1000,10,10);
  for k=1:10
    for j=k+1:10
      xk = [x((k-1)*100+1:k*100,:) ; x((j-1)*100+1:j*100,:)];

      K = rbf(xk,l(i));
      

      Kv = rbf(xv,l(i),xk); % 16. juni slide 11
      y = - ones(200,1);
      y(1:100) = 1;
    
      [alpha,b,fval,e] = dualSVM(K,y);
      
      assert(e==1);
      pred = sign(K*alpha+b);
      assert(all(pred==y));

      pred_validation(:,k,j) = (sign(Kv*alpha+b)>0);
      pred_validation(:,j,k) = (-sign(Kv*alpha+b)>0);
      
  end
  
  [pred I] = max(sum(pred_validation, 3), [],2);
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
end


disp(sprintf('RBF: geringste Fehler auf den Validierungsdaten mit gamma=%d, (err=%i)', l(si), ...
	(1000-st)));

rbfst = st;
rbfsi = si;

si = 0;
st = 0;

%try polynomial kernel
for i=1:4
  pred_validation = zeros(1000,10, 10);
 
   for k=1:10
    for j=k+1:10
      xk = [x((k-1)*100+1:k*100,:) ; x((j-1)*100+1:j*100,:)];
      K = poly(xk,1,B(i));
      
      Kv = poly(xv,1,B(i),xk);      
      
      
      y = - ones(200,1);
      y(1:100) = 1;
      
      [alpha,b,fval,e] = dualSVM(K,y);
      
      assert(e==1);
      pred = sign(K*alpha+b);
      assert(all(pred==y));
    
    
      pred_validation(:,k,j) = (sign(Kv*alpha+b)>0);
      pred_validation(:,j,k) = (-sign(Kv*alpha+b)>0);

    end
  end
  [pred I] = max(sum(pred_validation, 3), [],2);
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




pred_validation = zeros(9000,10,10);
for k=1:10
    for j=k+1:10
      xk = [x((k-1)*100+1:k*100,:) ; x((j-1)*100+1:j*100,:)];
      xvk = [xv((k-1)*100+1:k*100,:) ; xv((j-1)*100+1:j*100,:)];
      xx = [xk;xvk];
      if (rbfst> st)
	K = rbf(xx ,l(rbfsi));
	Kv = rbf(xt,l(rbfsi), xx);
	disp('using rbf')
      else 
	K = poly(xx,1,B(si));
	Kv = poly(xt,1,B(si),xx);
	disp('using poly')
      end
      
      y = - ones(400,1);
      y(1:200) = 1;
      
      [alpha,b,fval,e] = dualSVM(K,y);
      
      assert(e==1);
      pred = sign(K*alpha+b);
      assert(all(pred==y));
    
    
      pred_validation(:,k,j) = (sign(Kv*alpha+b)>0);
      pred_validation(:,j,k) = (-sign(Kv*alpha+b)>0);

    end
end

[pred I] = max(sum(pred_validation, 3), [],2);
  t = ones(1000,1);
  for j=1:10
    t((j-1)*100+1:j*100) = j;
  end
  sum(abs(I==t))


disp(sprintf('Final error is %i', (9000-sum(abs(I==t)))))
