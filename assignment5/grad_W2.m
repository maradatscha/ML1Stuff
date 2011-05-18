function WG = grad_W2( d ,z, gt)
WG = zeros(size(d, 1), size(z,1));

for i=1:size(WG,1)
    for j=1:size(WG,2)
        WG(i,j)= gt(d(i))*d(i)*z(j);
    end
end


end

