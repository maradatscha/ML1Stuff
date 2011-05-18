function g = sig_grad( a )

g = sig(a).*(ones(size(a))-sig(a));

end

