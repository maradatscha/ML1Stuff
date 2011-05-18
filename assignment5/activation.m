function  y = activation( x, W, g)

assert(length(x) == length(w));

y = g(W*x);

end

