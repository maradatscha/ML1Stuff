function y = output_activation( x, W1, W2, g1, g2 )

assert(size(W1,2) == length(x));
assert(size(W1,1) == size(W2,2));

y = g2(W2*g1(W1*x));

%TODO check multiplications

end

