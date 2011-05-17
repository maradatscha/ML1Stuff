function z = hidden_activation( x, W , g)

assert(size(W,2) == length(x));

z = g(W*x);
%TODO cehck multiplication

end

