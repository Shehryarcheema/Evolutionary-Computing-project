function plotConvergence(PSO, DE, plotTitle)

figure

plot(PSO,'LineWidth',2)
hold on
plot(DE,'LineWidth',2)

set(gca,'YScale','log','FontSize',12,'FontWeight','bold')

xlabel('Iterations')
ylabel('Best Cost (log scale)')

legend('PSO','DE')
title(plotTitle)

grid on
box on

end
