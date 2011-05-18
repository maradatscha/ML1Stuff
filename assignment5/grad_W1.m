function g = grad_W1( x,z, dh , gt)

assert(length(x) == length(z));
assert(length(x) == length(dh));

g = x.*gt(z).*dh;

end

