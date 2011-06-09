function g = gram_RBF( x , l)


g = zeros(size(x,1), size(x,1));

for i=1:size(x,1)
   for j=1:size(x,1)
        g(i,j) = norm(x(i,:)-x(j,:));
   end
end


g = g.*g;
g = -l.*ones(size(g)).*g;

g = exp(g);

end

