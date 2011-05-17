function g = sig_grad( a )

g = sig(a).*(ones(1,length(a))-sig(a));

end

