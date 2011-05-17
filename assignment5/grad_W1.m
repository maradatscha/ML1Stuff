function g = grad_W1( x,zt, dh )

assert(length(x) == length(zt));
assert(length(x) == length(dh));

g = x.*zt.*dh;


end

