function  y = activation( x, w, g)

assert(length(x) == length(w));

m = x.*w;
y = sum(m);

y = g(y);

end

