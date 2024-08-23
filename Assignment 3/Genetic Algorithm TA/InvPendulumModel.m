function dxdt = InvPendulumModel(t,x,u)
dxdt = zeros(4,1);

x1 = x(1);
x2 = x(2);
x3 = x(3);
x4 = x(4);

M = 2;
m = 1;
l = 1;
g = 9.81;
ft = 0.5;

dxdt(1) = x2;
dxdt(2) = (-m*g*sin(x3)*cos(x3) + m*l*x4^2*sin(x3) + ft*m*x4*cos(x3) + u)/(M + (1 - cos(x3)^2)*m);
dxdt(3) = x4;
dxdt(4) = ((M + m)*(g*sin(x3) - ft*x4) - (l*m*x4^2*sin(x3) + u)*cos(x3))/(l*(M + (1 - cos(x3)^2)*m));

end

