function plotContour(type)

[x,y]=meshgrid(-5:0.05:5);

if strcmp(type,'rosenbrock')
    z=(1-x).^2 + 100*(y-x.^2).^2;
    titleName = 'Rosenbrock Contour';
else
    z=(x.^2 + y - 11).^2 + (x + y.^2 - 7).^2;
    titleName = 'Himmelblau Contour';
end

figure
contour(x,y,z,40)
colorbar

xlabel('x')
ylabel('y')
title(titleName)

end
