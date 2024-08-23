clc;clear
%% input MFs: (This is just for show)

inp_range = 0:0.1:100;

% Input mf's
in1 = trimf(inp_range, [0 0 40]);
in2 = trimf(inp_range, [18 40 70]);
in3 = trapmf(inp_range, [40 70 100 100]);

plot(inp_range, in1, inp_range, in2, inp_range, in3)
ylim([0,1.1])
title('input membership functions')
ylabel('\mu')
xlabel('F_{in}')
legend(["zero" "medium" "large"])
%% Output MFs:

out_range=0:0.01:3;

% Output mf's
out1 = trimf(out_range, [0 0 2]);
out2 = trapmf(out_range, [0.6 2 3 3]);

plot(out_range, out1, out_range, out2)
ylim([0,1.1])
title('output membership functions')
ylabel('\mu')
xlabel('h')
legend(["zero" "medium"])
%% Rules:
inp = 20;

% Fuzzify Inputs
in1 = trimf(inp, [0 0 40]);
in2 = trimf(inp, [18 40 70]);
in3 = trapmf(inp, [40 70 100 100]);

%rule1: if in1 then out1
%rule2: if in2 then out2
%rule3: if in3 then out2

% Implication
% rule 1:
imp1 = min(out1, in1);
% rule 2:
imp2 = min(out2, in2);
% rule 3:
imp3 = min(out2, in3);

figure
plot(out_range, imp1, out_range, imp2, out_range, imp3)
ylim([0,1.1])
title('output membership functions')
ylabel('\mu')
xlabel('h')
legend(["Zero" "Med" "Large"])
%% Aggregate outputs

% Aggregate using union
aggregated = max(imp1, max(imp2, imp3));

subplot(2,1,1)
plot(out_range, imp1, out_range, imp2, out_range, imp3)
ylim([0,1.1])
title('implications')
ylabel('\mu')
xlabel('h')
legend(["rule 1" "rule 2" "rule 3"])

subplot(2,1,2)
plot(out_range, aggregated)
ylim([0,1.1])
title('aggregated output')
ylabel('\mu')
xlabel('h')
%% Defuzzification: Center of area

% Calculate COG using equation
defuzzified = sum(aggregated.*out_range)/sum(aggregated)

