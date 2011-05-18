function  y = activation( x, W, g)

%assert(length(x) == size(W,1));
y = g(W*x);

end

