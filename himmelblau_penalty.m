function z = himmelblau_penalty(x)

x1 = x(1);
x2 = x(2);

f = (x1^2 + x2 - 11)^2 + (x1 + x2^2 - 7)^2;

% Constraints
g1 = x1 + x2 - 5;
g2 = x1^2 + x2^2 - 20;

penalty = 0;

if g1 > 0
    penalty = penalty + 50*g1^2;
end

if g2 > 0
    penalty = penalty + 50*g2^2;
end

z = f + penalty;

% Add noise (important)
z = z + 0.001*rand;

end
