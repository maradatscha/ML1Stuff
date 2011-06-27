function K = rbf(x,gam,x2);

    [n,d] = size(x);
    
    if exist('x2','var')
        [m,d2] = size(x2);
        K = ones(n,m);
        for i=1:n
            for j=1:m
                K(i,j) = exp( - norm(x(i,:)-x2(j,:))/gam);
                
            end 
        end
    else
        
        K = ones(n,n);
        for i=1:n-1
            for j=i+1:n
                K(i,j) = exp( -norm(x(i,:)-x(j,:))/gam);
                K(j,i) = K(i,j);
            end
        end

    end
    