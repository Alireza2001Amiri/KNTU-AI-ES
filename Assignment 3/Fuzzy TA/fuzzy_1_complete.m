clc
clear
%% Membership function types

x = 0:0.01:100; % Input

mf1 = trapmf(x, [0 10 30 50]); %mf 1
mf2 = trimf(x, [20 50 70]); %mf 2
mf3 = gaussmf(x, [25 100]); %mf 3

plot(x, mf1);
hold on
plot(x, mf2);
hold on
plot(x, mf3);
ylim([0, 1.2]);
legend(["trapazoidal mf" "triangular mf" "gaussian mf"]);

%% Temperature fuzzification example

temp = 0:0.1:40;

low = trapmf(temp, [0 0 10 15]);
med = trapmf(temp, [6 16 26 31]);
high = trapmf(temp, [25 30 40 40]);

plot(temp, low);
hold on
plot(temp, med);
hold on
plot(temp, high);
ylim([0, 1.2]);
legend(["Low" "Medium" "High"]);

%% Not - And (T-norm) - Or (S-norm)

x = 0:0.1:100;

mf1 = trimf(x, [20 30 65]);
mf2 = trapmf(x, [35 70 80 85]);

plot(x, mf1);
hold on
plot(x, mf2);
ylim([0, 1.2]);
legend(["mf1" "mf2"]);

%% Not --> Not(A) = 1-A

not_mf1 = 1-mf1;

subplot(2,1,1);
plot(x, mf1);
ylim([0, 1.2]);
legend(["mf1"]);

subplot(2,1,2);
plot(x, not_mf1);
ylim([0, 1.2]);
legend(["Not(mf1)"]);

%% And (T-Norm) --> And(A,B) = min(A, B)

and_mf1mf2 = min(mf1,mf2);

subplot(2,1,1);
plot(x, mf1);
hold on
plot(x, mf2);
ylim([0, 1.2]);
legend(["mf1" "mf2"]);

subplot(2,1,2);
plot(x, and_mf1mf2);
ylim([0, 1.2]);
legend(["And(mf1,mf2)"]);
%% Or (S-Norm) --> Or(A,B) = max(A, B)

or_mf1mf2 = max(mf1,mf2);

subplot(2,1,1);
plot(x, mf1);
hold on
plot(x, mf2);
ylim([0, 1.2]);
legend(["mf1" "mf2"]);

subplot(2,1,2);
plot(x, or_mf1mf2);
ylim([0, 1.2]);
legend(["Or(mf1,mf2)"]);
%% Product (T-Norm) --> Prod(A,B) = A*B

prod_mf1mf2 = mf1.*mf2;

subplot(2,1,1);
plot(x, mf1);
hold on
plot(x, mf2);
ylim([0, 1.2]);
legend(["mf1" "mf2"]);

subplot(2,1,2);
plot(x, prod_mf1mf2);
ylim([0, 1.2]);
legend(["Prod(mf1,mf2)"]);