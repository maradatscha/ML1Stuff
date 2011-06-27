function K = linear_own(x, x2);
    if exist('x2','var')
      K = x*x2';
    else 
      K = x*x';
    end;
    
