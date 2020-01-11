format long

A = [1 1; 1 1.0001; 1 1.0001];
pseudo_A = pinv(A);


cond = norm(A)*norm(pseudo_A);
