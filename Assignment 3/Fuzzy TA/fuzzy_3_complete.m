clc;clear
%% input MFs: (This is just for show)

service_range = 0:0.1:10;
food_range = 0:0.1:10;

% Input 1 (service) mf's: poor-good-excellent
poor = gaussmf(service_range, [1.5 0]);
good = gaussmf(service_range, [1.5 5]);
excellent = gaussmf(service_range, [1.5 10]);

% Input 2 (food) mf's: rancid-delicious
rancid = trapmf(food_range, [0 0 1 3]);
delicious = trapmf(food_range, [7 9 10 10]);

subplot(2,1,1)
plot(service_range, poor, service_range, good, service_range, excellent)
ylim([0,1.1])
title('input 1 (Service) membership functions')
ylabel('\mu')
xlabel('Service')
legend(["poor" "good" "excellent"])

subplot(2,1,2)
plot(food_range, rancid, food_range, delicious)
ylim([0,1.1])
title('input 2 (Food) membership functions')
ylabel('\mu')
xlabel('Food')
legend(["rancid" "delicious"])
%% Output MFs:

tip_range = 0:0.1:30;

% Output mf's
cheap = trimf(tip_range, [0 5 10]);
average = trimf(tip_range, [10 15 20]);
generous = trimf(tip_range, [20 25 30]);

plot(tip_range, cheap, tip_range, average, tip_range, generous)
ylim([0,1.1])
title('output membership functions')
ylabel('\mu')
xlabel('Tip')
legend(["cheap" "average" "generous"])
%% Rules:
service = 3;
food = 8;

% Fuzzify Input 1 (Service) -> poor-good-excellent
poor = gaussmf(service, [1.5 0]);
good = gaussmf(service, [1.5 5]);
excellent = gaussmf(service, [1.5 10]);

% Fuzzify Input 2 (Food) -> rancid-delicious
rancid = trapmf(food, [0 0 1 3]);
delicious = trapmf(food, [7 9 10 10]);

%rule1: If (service is poor or food is rancid) then (tip is cheap)
%rule2: If (service is good) then (tip is average)
%rule3: If (service is excellent and food is delicious) then (tip is generous)

% rule 1: (or)
in1 = max(poor,rancid);
imp1 = min(cheap,in1);
% rule 2:
in2 = good;
imp2 = min(average,in2);
% rule 3: (and)
in3 = min(excellent,delicious);
imp3 = min(generous,in3);

figure
plot(tip_range, imp1, tip_range, imp2, tip_range, imp3)
ylim([0,1.1])
title('output membership functions after implication')
ylabel('\mu')
xlabel('Tip')
legend(["Rule 1" "Rule 2" "Rule 3"])
%% Aggregate outputs

% Aggregate using union
aggregated = max(imp1, max(imp2, imp3));

subplot(2,1,1)
plot(tip_range, imp1, tip_range, imp2, tip_range, imp3)
ylim([0,1.1])
title('output membership functions after implication')
ylabel('\mu')
xlabel('Tip')
legend(["cheap" "average" "generous"])

subplot(2,1,2)
plot(tip_range, aggregated)
ylim([0,1.1])
ylim([0,1.1])
title('output membership functions after implication')
ylabel('\mu')
xlabel('Tip')
legend(["Tip"])
%% Defuzzification: Center of area

% Calculate COG using equation
defuzzified = sum(aggregated.*tip_range)/sum(aggregated)
