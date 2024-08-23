% Define the range of x
x_values = 0:0.01:10;

% Define the membership functions for Set A
set_A = zeros(size(x_values));
set_A(x_values >= 1 & x_values < 2) = x_values(x_values >= 1 & x_values < 2) - 1;
set_A(x_values >= 2 & x_values < 3) = 1;
set_A(x_values >= 3 & x_values < 4) = 4 - x_values(x_values >= 3 & x_values < 4);

% Define the membership functions for Set B
set_B = zeros(size(x_values));
set_B(x_values < 3) = exp(x_values(x_values < 3) - 3);
set_B(x_values >= 3 & x_values < 5) = 1;
set_B(x_values >= 5 & x_values <= 10) = 1 - (x_values(x_values >= 5 & x_values <= 10) - 5) / 5;

% Define the complement of sets A and B
set_A_complement = 1 - set_A;
set_B_complement = 1 - set_B;

% Plot the sets A and B
figure;
subplot(2, 2, 1);
plot(x_values, set_A);
title('Set A');
xlabel('x');
ylabel('\mu_A(x)');

subplot(2, 2, 2);
plot(x_values, set_B);
title('Set B');
xlabel('x');
ylabel('\mu_B(x)');

% Plot the complements of sets A and B
subplot(2, 2, 3);
plot(x_values, set_A_complement);
title('Complement of A');
xlabel('x');
ylabel('\mu_{A''}(x)');

subplot(2, 2, 4);
plot(x_values, set_B_complement);
title('Complement of B');
xlabel('x');
ylabel('\mu_{B''}(x)');

% Perform union and intersection operations
union_A_B = max(set_A, set_B);
intersection_A_B = min(set_A, set_B);
union_complements = max(set_A_complement, set_B_complement);
intersection_complement = min(set_A, set_B_complement);

% Plot the results of union and intersection operations
figure;
subplot(2, 2, 1);
plot(x_values, union_A_B);
title('A \cup B');
xlabel('x');
ylabel('\mu_{A \cup B}(x)');

subplot(2, 2, 2);
plot(x_values, intersection_A_B);
title('A \cap B');
xlabel('x');
ylabel('\mu_{A \cap B}(x)');

subplot(2, 2, 3);
plot(x_values, union_complements);
title('A'' \cup B''');
xlabel('x');
ylabel('\mu_{A'' \cup B''}(x)');

subplot(2, 2, 4);
plot(x_values, intersection_complement);
title('A \cap B''');
xlabel('x');
ylabel('\mu_{A \cap B''}(x)');

% Check if sets A and B are convex
is_A_convex = all(diff(set_A) >= 0) || all(diff(set_A) <= 0);
is_B_convex = all(diff(set_B) >= 0) || all(diff(set_B) <= 0);

% Display the results
fprintf('Is Set A a convex set? %d\n', is_A_convex);
fprintf('Is Set B a convex set? %d\n', is_B_convex);
