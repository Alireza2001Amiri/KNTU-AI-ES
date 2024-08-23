clc;clear;
%%
flc = readfis('InvPendulum.fis');

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
    
    u = 150 * evalfis(flc,[e x(4)]);
    
    X = [X; x];
    Y = [Y; y];
    U = [U; u];
    
end

subplot(2,1,1)
plot(t,Y);
title('\theta')

subplot(2,1,2)
plot(t,U);
title('u')