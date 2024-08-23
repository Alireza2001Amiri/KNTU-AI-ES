function [Estimated_Sallary] = Salary_Estimator(INPUT)
%% Define input membership functions: Years of experience
xp = 0:0.01:12;

mf1 = trapmf(xp, [0,0,2,4]);
mf2 = trimf(xp, [2,4,6]);
mf3 = trimf(xp, [4,6,8]);
mf4 = trimf(xp, [6,8,10]);
mf5 = trapmf(xp, [8,10,12,12]);

figure(1)
plot(xp, mf1);
hold on
plot(xp, mf2);
hold on
plot(xp, mf3);
hold on
plot(xp, mf4);
hold on
plot(xp, mf5);
ylim([0, 1.2]);
title('Input membership functions')

legend('Membership Function 1','Membership Function 2','Membership Function 3','Membership Function 4','Membership Function 5')

%% Define output membership functions: Salary

Salary = 30000:150000;

Salary_level_1 = trapmf(Salary , [30000,30000,50000,70000]);
Salary_level_2 = trimf(Salary,[50000,70000,90000]);
Salary_level_3 = trimf(Salary,[70000,90000,110000]);
Salary_level_4 = trimf(Salary,[90000,110000,130000]);
Salary_level_5 = trapmf(Salary,[110000,130000,150000,150000]);

figure(2)
plot(Salary, Salary_level_1);
hold on
plot(Salary, Salary_level_2);
hold on
plot(Salary, Salary_level_3);
hold on
plot(Salary, Salary_level_4);
hold on
plot(Salary, Salary_level_5);
ylim([0, 1.2]);
title('Output membership functions')
legend('Salary_level_1','Salary_level_2','Salary_level_3','Salary_level_4','Salary_level_5')

%% Define Rules

%Fuzzify the INPUT
inp1 = trapmf(INPUT, [0,0,2,4]);
inp2 = trimf(INPUT, [2,4,6]);
inp3 = trimf(INPUT, [4,6,8]);
inp4 = trimf(INPUT, [6,8,10]);
inp5 = trapmf(INPUT, [8,10,12,12]);

imp1 = min(Salary_level_1 ,inp1);
imp2 = min(Salary_level_2 ,inp2 );
imp3 = min(Salary_level_3 ,inp3 );
imp4 = min(Salary_level_4 ,inp4 );
imp5 = min(Salary_level_5 ,inp5 );

figure(3)
plot(Salary, imp1, Salary, imp2,Salary, imp3,Salary, imp4,Salary, imp5)

title('output membership functions')
ylabel('\mu')
xlabel('h')
legend(["Salary_level_1" "Salary_level_2" "Salary_level_3" "Salary_level_4" "Salary_level_5"])

%% Aggregation
aggregated = max(imp1,max(imp2,max(imp3 ,max(imp4 ,imp5))));


figure(4)
subplot(2,1,1)
plot(Salary, imp1, Salary, imp2,Salary, imp3,Salary, imp4,Salary, imp5)

title('implications')
ylabel('\mu')
xlabel('h')
legend(["rule 1" "rule 2" "rule 3" "rule 4" "rule 5"])

subplot(2,1,2)
plot(Salary, aggregated)

title('aggregated output')
ylabel('\mu')
xlabel('h')

%% Defuzzification

% Calculate COG using equation
defuzzified = sum(aggregated.*Salary)/sum(aggregated);
Estimated_Sallary = defuzzified
end