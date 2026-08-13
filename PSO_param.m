function result = PSO_param(CostFunction,nVar,VarMin,VarMax,MaxIt,nPop,w)

wdamp = 0.98;
c1 = 2;
c2 = 2;

for i=1:nPop
particle(i).Position = VarMin + rand(1,nVar).*(VarMax-VarMin);
particle(i).Velocity = zeros(1,nVar);
particle(i).Cost = CostFunction(particle(i).Position);
particle(i).Best = particle(i);
end

GlobalBest = particle(1).Best;

for it=1:MaxIt

for i=1:nPop

particle(i).Velocity = w*particle(i).Velocity ...
+ c1*rand(1,nVar).*(particle(i).Best.Position - particle(i).Position) ...
+ c2*rand(1,nVar).*(GlobalBest.Position - particle(i).Position);

particle(i).Position = particle(i).Position + particle(i).Velocity;

particle(i).Position = max(particle(i).Position,VarMin);
particle(i).Position = min(particle(i).Position,VarMax);

particle(i).Cost = CostFunction(particle(i).Position);

if particle(i).Cost < particle(i).Best.Cost
particle(i).Best = particle(i);

if particle(i).Best.Cost < GlobalBest.Cost
GlobalBest = particle(i).Best;
end
end

end

w = w*wdamp;

end

result.BestCost = GlobalBest.Cost;

end
