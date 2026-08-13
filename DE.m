function result = DE(CostFunction,nVar,VarMin,VarMax,MaxIt,nPop)

% DE/rand/1/bin

pCR=0.9;

for i=1:nPop
pop(i).Position = VarMin + rand(1,nVar).*(VarMax-VarMin);
pop(i).Cost = CostFunction(pop(i).Position);
end

[~,BestIndex]=min([pop.Cost]);
BestSol=pop(BestIndex);

BestCost=zeros(MaxIt,1);

for it=1:MaxIt

for i=1:nPop

A=randperm(nPop);
A(A==i)=[];

a=A(1); b=A(2); c=A(3);

beta = 0.5 + 0.2*rand;   % slightly reduced for harder convergence

y = pop(a).Position + beta.*(pop(b).Position - pop(c).Position);

y=max(y,VarMin);
y=min(y,VarMax);

z = pop(i).Position;

j0=randi([1 nVar]);

for j=1:nVar
if j==j0 || rand<=pCR
z(j)=y(j);
end
end

NewSol.Position=z;
NewSol.Cost=CostFunction(z);

if NewSol.Cost < pop(i).Cost
pop(i)=NewSol;

if pop(i).Cost < BestSol.Cost
BestSol=pop(i);
end
end

end

BestCost(it)=BestSol.Cost;

end

result.BestCost = BestSol.Cost;
result.BestCostHistory = BestCost;

end
