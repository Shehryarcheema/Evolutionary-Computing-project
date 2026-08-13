clc;
clear;
close all;

%% ================= FINAL SETTINGS =================
MaxIt = 250;        % Reduced (harder problem)
nPop = 25;          % Reduced population
nRuns = 15;         % Keep median reliable

VarMin = -5;
VarMax = 5;
nVar = 2;

%% ================= ROSENBROCK =================
CostFunction = @(x) rosenbrock(x);

for r=1:nRuns
    PSO_R(r)=PSO(CostFunction,nVar,VarMin,VarMax,MaxIt,nPop);
    DE_R(r)=DE(CostFunction,nVar,VarMin,VarMax,MaxIt,nPop);
end

PSO_R_costs = [PSO_R.BestCost];
DE_R_costs  = [DE_R.BestCost];

% ✅ FIXED MEDIAN + INDEX
medPSO_R = median(PSO_R_costs);
medDE_R  = median(DE_R_costs);

[~, idx1] = min(abs(PSO_R_costs - medPSO_R));
[~, idx2] = min(abs(DE_R_costs - medDE_R));

fprintf('\nMedian Rosenbrock PSO = %e\n', medPSO_R);
fprintf('Median Rosenbrock DE  = %e\n', medDE_R);

%% ================= HIMMELBLAU =================
CostFunction = @(x) himmelblau_penalty(x);

for r=1:nRuns
    PSO_H(r)=PSO(CostFunction,nVar,VarMin,VarMax,MaxIt,nPop);
    DE_H(r)=DE(CostFunction,nVar,VarMin,VarMax,MaxIt,nPop);
end

PSO_H_costs = [PSO_H.BestCost];
DE_H_costs  = [DE_H.BestCost];

% ✅ FIXED MEDIAN + INDEX
medPSO_H = median(PSO_H_costs);
medDE_H  = median(DE_H_costs);

[~, idx3] = min(abs(PSO_H_costs - medPSO_H));
[~, idx4] = min(abs(DE_H_costs - medDE_H));

fprintf('\nMedian Himmelblau PSO = %e\n', medPSO_H);
fprintf('Median Himmelblau DE  = %e\n', medDE_H);

%% ================= CONVERGENCE =================
plotConvergence(PSO_R(idx1).BestCostHistory, DE_R(idx2).BestCostHistory, ...
    'Median Convergence - Rosenbrock');

plotConvergence(PSO_H(idx3).BestCostHistory, DE_H(idx4).BestCostHistory, ...
    'Median Convergence - Himmelblau');

%% ================= CONTOUR =================
plotContour('rosenbrock');
plotContour('himmelblau');

%% ================= EVOLUTION =================
plotEvolution(PSO_R(idx1).History, 'rosenbrock');
plotEvolution(PSO_H(idx3).History, 'himmelblau');

%% ================= PARAMETER STUDY =================
fprintf('\n===== PARAMETER STUDY (PSO inertia) =====\n');

w_values = [0.4 0.7 0.9];

for i=1:length(w_values)
    result = PSO_param(@rosenbrock,nVar,VarMin,VarMax,MaxIt,nPop,w_values(i));
    fprintf('w = %.1f  -> Best Cost = %e\n', w_values(i), result.BestCost);
end
