function d = output_error( y , t )

assert(length(y) == length(t))

d = y - t;

end

