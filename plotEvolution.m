function plotEvolution(History, type)

[x,y]=meshgrid(-5:0.05:5);

if strcmp(type,'rosenbrock')
    z=(1-x).^2 + 100*(y-x.^2).^2;
    titleName = 'PSO Evolution - Rosenbrock';
else
    z=(x.^2 + y - 11).^2 + (x + y.^2 - 7).^2;
    titleName = 'PSO Evolution - Himmelblau';
end

figure
contour(x,y,z,40)
hold on

plot(History{1}(:,1),History{1}(:,2),'ro')
plot(History{round(end/2)}(:,1),History{round(end/2)}(:,2),'go')
plot(History{end}(:,1),History{end}(:,2),'bo')

legend('Contour','Initial','Middle','Final')
title(titleName)

end
