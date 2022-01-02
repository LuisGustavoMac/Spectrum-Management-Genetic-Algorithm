function [P,D,fitness,Pbest,m,n] = elitismo(P,D,fitness,P1,D1,fitness1)
%fitness = resultado do processo de evolucao - filhos
%fitness1 = avaliacao da populacao inicial - pais

[L,B]=size(D);  

%Ordenamento de menor ao maior
[m,n] = sort(fitness,'ascend');
Pbest = P(n(1),:);
fitnessbest = fitness(n(1)); %melhor filho apos a mutacao
Ibest = D(n(1),:);

%Ordenamento de menor ao maior 
[m1,n1] = sort(fitness1,'ascend');
P1worst = P1(n1(end),:);  %o pior pai da populacao inicial, antes da selecao
fitness1worst = fitness1(n1(end));
I1worst = D1(n1(end),:);


%Substituicao do Melhor Filho pelo Pior Pai
D1(n1(end),:) = D(n(1),:);
fitness1(n1(end)) = fitness(n(1));
P1(n1(end),:) = P(n(1),:);

P = P1;
fitness = fitness1;
D = D1;