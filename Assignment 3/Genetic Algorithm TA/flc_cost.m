function [cost,out] = flc_cost(p)

flc = readfis('InvPendulum.fis');

s = floor(p(1:5));

ix1 = {1;
      [2 6];
      [3 7 11];
      [4 8 12 16]};
  
ix2 = {25;
      [20 24];
      [15 19 23];
      [10 14 18 22]};

for i = 1:numel(ix1)
    for j = 1:numel(ix1{i})
        flc.rule(ix1{i}(j)).consequent = s(i);
        flc.rule(ix2{i}(j)).consequent = 8 - s(i);
    end
end

for i = [5 9 13 17 21]
    flc.rule(i).consequent = s(5);
end


flc.inputs(1).mf(1).params = [-1 -1 -p(6)];
flc.inputs(1).mf(2).params = [-1 -p(6) 0];
flc.inputs(1).mf(3).params = [-p(6) 0 p(6)];
flc.inputs(1).mf(4).params = [0 p(6) 1];
flc.inputs(1).mf(5).params = [p(6) 1 1];

flc.inputs(2).mf(1).params = [-1 -1 -p(7)];
flc.inputs(2).mf(2).params = [-1 -p(7) 0];
flc.inputs(2).mf(3).params = [-p(7) 0 p(7)];
flc.inputs(2).mf(4).params = [0 p(7) 1];
flc.inputs(2).mf(5).params = [p(7) 1 1];

p(8:9) = sort(p(8:9));

flc.output.mf(1).params = [-1 -1 -p(9)];
flc.output.mf(2).params = [-1 -p(9) -p(8)];
flc.output.mf(3).params = [-p(9) -p(8) 0];
flc.output.mf(4).params = [-p(8) 0 p(8)];
flc.output.mf(5).params = [0 p(8) p(9)];
flc.output.mf(6).params = [p(8) p(9) 1];
flc.output.mf(7).params = [p(9) 1 1];

ki1 = p(10);
ki2 = p(11);
ko = p(12);

t = 0:0.01:10;
yr = 0;

x = [0 0 0.2 0];
y = x(3);
e = y-yr;
u=0;

X = x;
Y = y;
U = u;

for i=1:length(t)-1
    
    [T,s] = ode45(@(t,x)InvPendulumModel(t,x,u),[t(i) t(i+1)],x);
    
    x = s(end,:);
    y = x(3);
    e = y-yr;
    
    u = ko * evalfis(flc,[ki1*e ki2*x(4)]);
    
    X = [X; x];
    Y = [Y; y];
    U = [U; u];
    
end

cost = sum(Y.^2);

out.Y = Y;
out.X = X;
out.U = U;
out.flc = flc;
end
