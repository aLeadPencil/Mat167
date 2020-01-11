load HW_02                          % load data file into workspace

% 1A
whos                                % check variable information in current workspace


% 1B
plot(x, y);                         % plot the data
grid;                               % add a grid to the plot


% 1C
A = [x.^0 x.^1];                    % Create the vandermonde matrix


% 1D
sol = inv(A'*A)*A'*y;               % Compute the least squares line


% 1E
hold on;                            % hold the current plot
plot(x, sol(1)+sol(2)*x, '--');     % plot least squares line using the original data x over the current plot with a -- pattern
title('Least Squares Linear Fit');  % title the plot
xlabel('x');                        % x axis label
ylabel('y');                        % y axis label


% 5A
A = [1 2; 0 2; 1 3];
format long
norm(A)


% 5B
sqrt(max(eig(A'*A)))
rel_err = (sqrt(max(eig(A'*A))) - norm(A))/norm(A)

% 5C
norm_1 = norm(A, 1)
norm_inf = norm(A, Inf)
norm_f = norm(A, 'fro')

% 5D

load HW_01

a = U'*x;

x_norm_1 = norm(x, 1)
x_norm_inf = norm(x, Inf)
x_norm_2 = norm(x, 2)

a_norm_1 = norm(a, 1)
a_norm_inf = norm(a, Inf)
a_norm_2 = norm(a, 2)

U_norm_1 = norm(U, 1)
U_norm_inf = norm(U, Inf)
U_norm_2 = norm(U, 2)
U_norm_f = norm(U, 'fro')
