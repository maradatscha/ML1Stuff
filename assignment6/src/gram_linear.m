function g = gram_linear( x )

g = zeros(size(x,1), size(x,1));

for i=1:size(x,1)
   for j=1:size(x,1)
        g(i,j) = x(i,:)*x(j,:)';
   end
end


end

