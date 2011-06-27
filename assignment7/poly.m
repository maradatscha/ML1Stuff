function K = poly(x,c,d,x2)
    if exist('x2','var')
      K = (linear_own(x,x2)+c).^d;
    else
      K = (linear_own(x)+c).^d;
    end
    