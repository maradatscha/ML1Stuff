function a = sig( i )

a = 1 ./ (ones(size(i))  + exp(-i));

end

