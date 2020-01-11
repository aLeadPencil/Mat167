format long

m = 50;
n = 12;
t = linspace(0, 1, m);
A = vander(t);
A = fliplr(A);
A = A(:, 1:12);
b = cos(4*t)';

% 4A
least_squares = (A' * A) \A' * b;

% 4B
[gram_Q, gram_R] = CGS(A);
gram_least_squares = gram_R\gram_Q' * b;

% 4C
[mod_Q, mod_R] = MGS(A);
mod_least_squares = mod_R\mod_Q' * b;

% 4D
[house_Q, house_R] = qr(A);
house_least_squares = house_R\house_Q' * b;

% 4E
x = A\b;

row = ["normal equations"; "classical"; "modified"; "householder"; "A\b"]';
result = [least_squares, gram_least_squares, mod_least_squares, house_least_squares, x];
result = [row; result];



