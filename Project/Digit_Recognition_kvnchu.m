% Kevin Chu
% 913077890


% Load the datafile into the workspace

load USPS.mat

% STEP 1A
% Rename matrices as instructed and remove the old matrices to avoid
% confusion later on

training_digits = train_patterns;
test_digits = test_patterns;
training_labels = train_labels;
clear train_patterns test_patterns train_labels


% STEP 1B
% First construct the figure then initiate a 16x1 cell to store the first
% 16 training images later.
% Next, loop through the first 16 columns and reshape and transpose each
% column and store it into a cell.
% Next create a subplot in the figure and plot the first 16 training images

figure(1);
first_16 = cell(16, 1);

for i = 1:16
    current_column = training_digits(:, i);
    first_16{i} = reshape(current_column, 16, 16)';
    subplot(4, 4, i);
    imagesc(first_16{i})
end


% STEP 2
% each_digit_samples is a 10x1 cell that contains the pooled training
% pattern matrices. sample_sizes is an array that contains the number of
% pooled training patterns for each unique digit. training_averages is a
% matrix that contains the average pattern for each unique digit.

% The loop first pools together all training patterns for each unique
% digit. Then it calculates the average pattern for each unique digit and
% then it plots the average patterns in a 2x5 subplot

figure(2);
each_digit_samples = cell(10, 1);
sample_sizes = zeros(1, 10);
training_averages = zeros(256, 10);

for i = 1:10
    each_digit_samples{i} = training_digits(:, training_labels(i, :) == 1);
    [row_count, column_count] = size(each_digit_samples{i});
    sample_sizes(i) = column_count;
    training_averages(:, i) = sum(each_digit_samples{i}, 2)/sample_sizes(i);
    
    subplot(2, 5, i);
    imagesc(reshape(training_averages(:, i), 16, 16)')
end


% STEP 3A
% The loop calculates euclidean distances of each testing digit from each
% average digit pattern from the training pattern data set.

test_classification = zeros(4649, 10);

for i = 1:10
    test_classification(:, i) = sum((test_digits-repmat(training_averages(:, i),[1 4649])).^2);
end


% STEP 3B
% Predict the label of each testing pattern based on the euclidean distance
% matrix calculated in the prior step. The loop iterates through each row
% the distance matrix, finds the minimum value and its column index
% position to classify the label. Next, the results are stored into a table
% for referencing purposes.


test_classification_res = zeros(1, 4649);

for i = 1:4649
    [tmp, ind] = min(test_classification(i, :));
    test_classification_res(i) = ind;
end

results_3b = tabulate(test_classification_res);


% STEP 3C
% The first loop constructs the confusion matrix by cross referencing the
% predicted testing labels with the actual testing labels. The next loop
% calculates the number of accurately predicted labels. Then the accuracy
% of the model is calculated by dividing the number of accurately predicted
% labels with the total number of labels that needed to be predicted.

confusion_matrix_3c = zeros(10, 10);

for i = 1:10
    for j = 1:10
        tmp = test_classification_res(test_labels(i, :) == 1);
        confusion_matrix_3c(i, j) = sum(tmp == j);
    end
end

disp(confusion_matrix_3c)

accurate_predictions_3c = 0;

for i = 1:10
    accurate_predictions_3c = accurate_predictions_3c + sum(confusion_matrix_3c(i, i));
end

accuracy_rate_3c = accurate_predictions_3c / 4649;


% STEP 4A
% Pool the images corresponding to each i = 0, 1, ..., 9 digit. Then
% compute the first 17 singular values for each pooled digit and store them
% into 3d matrix of size 256x17x10.

left_singular_vectors = zeros(256, 17, 10);

for i = 1:10
    [left_singular_vectors(:, :, i), ~, ~] = svds(training_digits(:, training_labels(i, :) == 1), 17);
end


% STEP 4B
% Compute the expansion coefficient of each testing pattern using the 17
% left_singular_vectors calculated in the step prior. In other words, an
% approximation of the test digits patterns is calculated using the 17 left
% singular vectors.

test_svd17 = zeros(17, 4649, 10);

for i = 1:10
    test_svd17(:, :, i) = left_singular_vectors(:, :, i)' * test_digits;
end


% STEP 4C
% Calculate the 2-norm of the residual error for each test digit.
% Next, construct a matrix of the residual errors. After the residual
% errors matrix is calculated, look for the lowest residual error for each
% column and find the index where the error is the lowest. The index found
% is the predicted label for the test digit pattern. After, this is done
% construct the confusion matrix the same way it was constructed in step
% 3C. Then calculate that accuracy rate using the confusion matrix using
% the same method it was done in step 3C.

test_digits_rank_17_approximation = zeros(10, 4649);
svd_classification = zeros(1, 4649);

for i = 1:10
    for j = 1:4649
        tmp  = norm(test_digits(:, j) - left_singular_vectors(:, :, i) * test_svd17(:, j, i));
        test_digits_rank_17_approximation(i, j) = tmp;
        [tmp, ind] = min(test_digits_rank_17_approximation(:, j));
        svd_classification(1, j) = ind;
    end
end

results_4c = tabulate(svd_classification);

confusion_matrix_4c = zeros(10, 10);

for i = 1:10
    for j = 1:10
        tmp = svd_classification(test_labels(i, :) == 1);
        confusion_matrix_4c(i, j) = sum(tmp == j);
    end
end

disp(confusion_matrix_4c)

accurate_predictions_4c = 0;

for i = 1:10
    accurate_predictions_4c = accurate_predictions_4c + sum(confusion_matrix_4c(i, i));
end

accuracy_rate_4c = accurate_predictions_4c / 4649;


% STEP 5C
% Calculate each algorithms accuracy for each digit using the confusion
% matrix by dividing each diagonal element with the sum of its row

each_digit_accuracy_3c = zeros(10, 1);
each_digit_accuracy_4c = zeros(10, 1);

for i = 1:10
    each_digit_accuracy_3c(i) = confusion_matrix_3c(i, i) / sum(confusion_matrix_3c(i, :));
    each_digit_accuracy_4c(i) = confusion_matrix_4c(i, i) / sum(confusion_matrix_4c(i, :));
end    