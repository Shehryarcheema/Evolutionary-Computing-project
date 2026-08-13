function z = rosenbrock(x)

x1 = x(1);
x2 = x(2);

z = (1-x1)^2 + 100*(x2-x1^2)^2;

% Add small noise to make harder
z = z + 0.001*rand;

end
