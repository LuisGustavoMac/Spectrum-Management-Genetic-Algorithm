function [P,D,fitness] = selecao(P,D,F,fitness,L)
F = sum(fitness); %Somatorio dos fitness
Prob = (fitness)/(F); %Probabilidade de cada individuo 
q = cumsum(Prob); %Probabilidade cumulativa

r = rand(1,L); %Vetor de numeros aleatorios entre 0 e 1

%Comparamos q<=r para selecionar os novos individuos
for i = 1 : L
    [a,b] = find(r(i)<=q);
    indiceSelecionado(i) = a(1);
end

Pselecionado = P(indiceSelecionado',:);
DSelecionado = D(indiceSelecionado',:);
fitnessSelecionado = fitness(indiceSelecionado');

%Nova Populacao
P = Pselecionado;
D = DSelecionado;
fitness = fitnessSelecionado;

