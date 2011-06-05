
% XOR points
x = [ 1 1; 1 -1; -1 -1;  -1 1];

% XOR labels

y = [ 1 ; -1; 1; -1  ];

[w, f]  = primal_SVM(x, y);

f

% flag is -2, means not solvable
% which is OK because XOR can't be solved with linear





