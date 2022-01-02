function [P,D,fitness,F] = populacao(L,X,df,dp,db,M)

E = linspace(1,100); %Espectro total de frequencias
O = randperm(100,30);

for i = 1:50
B = randi(100,1,1);
for j = 1:30
 while(B == O(j))
    B = randi(100,1,1);
 end
end
 x1(i) = B;
end
x1 = x1';
%Gera valores aleatorios dentro dos niveis de cada cromossomo ou variavel

x2 = randi(dp(50),L,1);
x3 = randi(db(8),L,1);
x4 = randi(M(4),L,1);

P = [x2 x3 x4 x1];%Populacao com 4 cromossomos

%Converte cada cromossomo para binario
x11 = dec2bin(x1);
x22 = dec2bin(x2);
x33 = dec2bin(x3);
x44 = dec2bin(x4);

D = [x22 x33 x44 x11]; %Populacao com 4 cromossomos em binario

%Elaboracao do fitness
w = 0.33; %grau de importancia de cada variavel
for i = 1:L
    for k = 1:3
        f(i,k) = (w*abs(P(i,k)-X(k)))/X(k); %funcao de cada variavel normalizada
    end
     fitness(i) = sum(f(i,:)); %fitness de cada individuo
end

%fitness de todos os individuos
fitness = fitness';

F = sum(fitness); %Somatorio dos fitness  