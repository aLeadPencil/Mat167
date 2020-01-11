load HW_01; % Loads HW_01 data


% Problem 1A f
figure(1);                                      % Creates a new figure window

stem(x);                                        % Plots discrete sequence of the data x
hold on;                                        % Keeps current figure
plot(x);                                        % Plots 2D line plot of the data x
grid;                                           % Displays axes grid lines


% Problem 1B
figure(2)                                       % Creates a new figure window

for k = 1:8                                     % For loop to index numbers 1 through 8
    subplot(8, 1, k);                           % Creates an 8 row by 1 column grid of subplots 
    stem(U(:, k));                              % Plots discrete sequence of each column of the data U
    axis([0 9 -0.5 0.5]);                       % Set axis limits for x: 0 to 9 and y: -0.5 to 0.5
    axis off;                                   % Turns off axis lines
    hold on;                                    % Keeps current plot for next loop
end 

for k = 1:8                                     % For loop to index numbers 1 through 8
    subplot(8, 1, k);                           % Creates an 8 row by 1 column grid of subplots
    plot(U(:, k));                              % Plots 2D line plots for every row of the data U
end 


% Problem 1C

a = U' * x;                                     % Computes the expansion coefficients of x with respect to the basis vectors in matrix U


% Problem 1D

a2 = zeros(length(a), 1);                       % Create a zero vector of length 8
[B, I] = maxk(a, 2, 'ComparisonMethod', 'abs'); % Find the 2 largest numbers and their indices

for i = 1:length(I)                             % Sequence through the number of largest indices
    for j = 1:length(a2)                        % Sequence through the zero vector
        if j == I(i)                            % Check if index # is the same as the index # of the largest integer
            a2(j) = B(i);                       % Replace the zero with the next largest integer
        end
    end
end


% Problem 1E

x2 = inv(U') * a2;                              % Calculate an approximation of the original signal x using a2
figure(1);                                      % Revisit figure 1 to plot the approximation x2
stem(x2, 'r*'); 
plot(x2, 'r');


% Problem 1F

a4 = zeros(length(a), 1);                       % Create a zero vector of length 8
[B, I] = maxk(a, 4, 'ComparisonMethod', 'abs'); % Find the 2 largest numbers and their indices

for i = 1:length(I)                             % Sequence through the number of largest indices
    for j = 1:length(a4)                        % Sequence through the zero vector
        if j == I(i)                            % Check if index # is the same as the index # of the largest integer
            a4(j) = B(i);                       % Replace the zero with the next largest integer
        end
    end
end

x4 = inv(U') * a4;                              % Calculate an approximation of the original signal x using a4


% Problem 1G

figure(1);                                      % Revisit figure 1 to plot the approximation x4
stem(x4, 'gx');
plot(x4, 'g');


% Problem 1H

x8 = U*a;                                             % Calculate full reconstruction of signal x with all coefficients
relative_error_x8 = sqrt(sum((x-x8).^2) / sum(x.^2))  % Calculate relative error of full reconstruction
relative_error_x4 = sqrt(sum((x-x4).^2) / sum(x.^2))  % Calculate relative error of approximation x4
relative_error_x2 = sqrt(sum((x-x2).^2) / sum(x.^2))  % Calculate relative error of approximation x2


