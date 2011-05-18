function g = grad_W2( d ,z, gt)

g = gt(d).*d.*z;

end

