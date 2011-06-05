function g = gram_RBF( x , l)

i = repmat(x, size(x,2),1);
j = repmat(x', 1, size(x,2));

g = (i-j);
g = g.*g;
g = l.*ones(size(g)).*g;

g = exp(g);

end

