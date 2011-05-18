function [ T ] = predict( W1, W2, x, g1, g2 )
    
  h = activation( x, W1, g1);
  T = activation( h, W2, g2);
  
end

