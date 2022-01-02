function [P,D,fitness] = crossover(P,D,fitness,Pc,X)
[L,B] = size(D);  

%Probabilidade de cada individuo
r = rand(1,L);

[a,b] = find(r<Pc); %Procura probabilidades inferiores ao cruzamento


if length(b)>2  %Verifica se existem pelo menos 2 elementos para cruzamento
    if mod(length(b),2) == 0
        for i = 1 : length(b)/2
            %Pais selecionados
            P1 = D(b(i),:);
            P2 = D(b(i+1),:);
            %ponto de cruzamento
            D(b(i),:) = [P1(1:10) P2(11:B)]; %Conecta a frequencia e potencia de P1 com BER e Mod de P2
            D(b(i+1),:) = [P2(1:10) P1(11:B)]; %Conecta a frequencia e potencia de P2 com BER e Mod de P1
        end
    else 
        for i = 1 : (length(b)-1)/2
            P1 = D(b(i),:);
            P2 = D(b(i+1),:);
            %ponto de cruzamento
            D(b(i),:) = [P1(1:10) P2(11:B)]; %Conecta a frequencia e potencia de P1 com BER e Mod de P2
            D(b(i+1),:) = [P2(1:10) P1(11:B)]; %Conecta a frequencia e potencia de P2 com BER e Mod de P1
        end
    end  
end

%Separa as variaveis
    Fre1 = D(:,B-6:B);
  
    Pot1 = D(:,1:B-14);
  
    Be1 = D(:,B-13:B-10);
  
    Mod1 = D(:,B-9:B-7);
    
%Converte cada variavel de binario em decimal
Fre = bin2dec(Fre1);
Pot = bin2dec(Pot1);
Be = bin2dec(Be1);
Mod = bin2dec(Mod1);

P = [Pot Be Mod Fre]; %Nova populacao com cruzamento em decimal

%Calculo do novo fitness
w = 0.33; %grau de importancia de cada variavel
for i = 1:length(P)
    for k = 1:3
        f(i,k) = (w*abs(P(i,k)-X(k)))/X(k);
    end
     fitness(i) = sum(f(i,:));
end

%fitness de todos os individuos
fitness = fitness';