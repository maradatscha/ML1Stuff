function [ t,z] = predict( W1, W2, x, g1, g2 )
    
  z = activation( x, W1, g1);
  z = [z ;1];
  t = activation( z, W2, g2);
  
end

