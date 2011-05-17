function a = sig( i )

a = 1 ./ (one(1,length(i))  + exp(-i));

end

