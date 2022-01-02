function [P,D,m,n,fitness] = mutacao(P,D,fitness,Pm,X)
[L,B]=size(D);  

%Probabilidade de cada individuo
r = rand(L,B);

[m,n] = find(r<Pm); %Procura probabilidades inferiores a mutacao

for i = 1 : length(m)
    if n(i)>13
        n(i) = randi(13,1);
    end
    if D(m(i),n(i)) == '1'
        D(m(i),n(i))='0';
    else
        D(m(i),n(i))='1';
    end
end

%Separa as variaveis
    Freq1 = D(:,B-6:B);
   
    Po1 = D(:,1:B-14);
  
    B1 = D(:,B-13:B-10);
  
    Mo1 = D(:,B-9:B-7);
    
%Converte cada variavel em decimal
Freq = bin2dec(Freq1);
Po = bin2dec(Po1);
B = bin2dec(B1);
Mo = bin2dec(Mo1);

P = [Po B Mo Freq]; %Nova populacao apos mutacao em decimal

%Calculo do fitness
w = 0.33; %grau de importancia de cada variavel
for i = 1:length(P)
    for k = 1:3
        f(i,k) = (w*abs(P(i,k)-X(k)))/X(k);
    end
     fitness(i) = sum(f(i,:));
end
%fitness de todos os individuos
fitness = fitness';