function WG = grad_W1( d, W1, W2,h, x , gt)

WG = zeros(size(W2,2)-1, size(x,1));

zt = gt(W1*x);
dh = d'*W2;

for i=1:size(WG,1)
    for j=1:size(WG,2)
        WG(i,j)= x(j)*zt(i)*dh(i);
    end
end

end

