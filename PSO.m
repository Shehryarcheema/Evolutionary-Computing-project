function result = PSO(CostFunction,nVar,VarMin,VarMax,MaxIt,nPop)

w = 0.9;
wdamp = 0.98;
c1 = 2;
c2 = 2;

empty_particle.Position=[];
empty_particle.Velocity=[];
empty_particle.Cost=[];
empty_particle.Best.Position=[];
empty_particle.Best.Cost=[];

particle=repmat(empty_particle,nPop,1);

GlobalBest.Cost=inf;

%% Initialization
for i=1:nPop

particle(i).Position = VarMin + rand(1,nVar).*(VarMax-VarMin);
particle(i).Velocity = zeros(1,nVar);

particle(i).Cost = CostFunction(particle(i).Position);

particle(i).Best.Position = particle(i).Position;
particle(i).Best.Cost = particle(i).Cost;

if particle(i).Best.Cost < GlobalBest.Cost
GlobalBest = particle(i).Best;
end

end

BestCost=zeros(MaxIt,1);

%% MAIN LOOP
for it=1:MaxIt

positions = zeros(nPop,nVar);

for i=1:nPop

particle(i).Velocity = w*particle(i).Velocity ...
+ c1*rand(1,nVar).*(particle(i).Best.Position - particle(i).Position) ...
+ c2*rand(1,nVar).*(GlobalBest.Position - particle(i).Position);

particle(i).Position = particle(i).Position + particle(i).Velocity;

particle(i).Position = max(particle(i).Position,VarMin);
particle(i).Position = min(particle(i).Position,VarMax);

particle(i).Cost = CostFunction(particle(i).Position);

if particle(i).Cost < particle(i).Best.Cost

particle(i).Best.Position = particle(i).Position;
particle(i).Best.Cost = particle(i).Cost;

if particle(i).Best.Cost < GlobalBest.Cost
GlobalBest = particle(i).Best;
end
end

positions(i,:) = particle(i).Position;

end

History{it} = positions;
BestCost(it)=GlobalBest.Cost;

w=w*wdamp;

end

result.BestCost = GlobalBest.Cost;
result.BestCostHistory = BestCost;
result.History = History;

end
