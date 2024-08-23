clc
clear
close all

warning('off');

%    {--rules--*--------mfs--------*-----gains----}
LB = [1 1 1 1 1 0.01 0.01 0.01 0.01 0.01 0.01 0.01];
%    {----------rules---------*--------mfs--------*---gains---}
UB = [7.99 7.99 7.99 7.99 7.99 0.99 0.99 0.99 0.99 10 10 1000];

%    {--rules--*-------mfs-------*-gains-}
x0 = [1 2 3 3 4 0.5 0.5 0.33 0.67 1 1 200];

options = optimoptions(@ga,'InitialPopulation',x0,'Generation',20,'PopulationSize',40,'Display','iter');

x = ga(@flc_cost,12,[],[],[],[],LB,UB,[],options);
