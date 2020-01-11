% 4A

A = [1 0 1 1; 0 1 0 1; 1 0 0 1; 0 -1 1 1]; % Matrix of vectors in the problem

B = zeros(size(A));                                 % Create a matrix of the same size as A to store results
y_norm = zeros(1, length(A));                       % Create a vector to store norm values
n = size(A, 2);                                     % # Of orthogonal basis to calculate 

y(:, 1) = A(:, 1);                                  % Lines 9-11 find the orthonormal basis for the first vector using gram schmidt
y_norm(1) = norm(y(:, 1));
B(:, 1) = A(:, 1)/y_norm(1);

for i = 2:n                                         
    tmp_vec = A(:, i);                                  % tmp_vec = Summation of projections
    
    for j = 1:i                                     % Loop to tmp_vec up projections
        projection = -dot(A(:, i), B(:, j)) * B(:, j);    
        tmp_vec = tmp_vec + projection;
    end
    
    y(:, i) = tmp_vec;                                  % Lines 21-23 find the orthonormal basis for the i'th vector
    y_norm(i) = norm(y(:, i));
    B(:, i) = y(:, i)/y_norm(i);
end

fprintf('Problem 4A \n');
disp(B)                                             % Displays the final result in command window


% 4B 

A2 = [1 4 1 0; 0 1 0 2; 0 0 2 0; 1 0 1 1];

B2 = zeros(size(A2));
y_norm2 = zeros(1, length(A2));
n = size(A2, 2);

y2(:, 1) = A2(:, 1);
y_norm2(1) = norm(y2(:, 1));
B2(:, 1) = A2(:, 1)/y_norm2(1);

for i = 2:n
    tmp_vec = A2(:, i);

    for j = 1:i
        projection = -dot(A2(:, i), B2(:, j)) * B2(:, j);
        tmp_vec = tmp_vec + projection;
    end

    y2(:, i) = tmp_vec;
    y_norm2(i) = norm(y2(:, i));
    B2(:, i) = y2(:, i)/y_norm2(i);
end

fprintf('Problem 4B \n');
disp(B2)