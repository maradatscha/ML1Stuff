function g = gram_poly( x, c , d )

g = gram_linear(x);
g = (g+c).^d;


end

