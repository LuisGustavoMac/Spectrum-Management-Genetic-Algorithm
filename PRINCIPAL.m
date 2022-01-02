clc
clear all
%Valor corrspondente a geracao aleatoria 
G = 2.1567e+03
%soma do clock com melhor minimizacao do fitness
%2.1246e+03;
%soma do clock com pior minimizacao do fitness
%2.1567e+03
rand('seed',G);

fmax = 840; %frequecia maxima em MHz
fmin = 40;  %frequecia minima em MHz
fpasso = 8; %Passo de frequencia em MHz
Pmax = -40; %Potencia maxima em dBm
Pmin = -90; %Potencia minima em dBm
Ppasso = 1; %Passo de potencia em dBm
BERmax = 1e-1; %BER maxima 
BERmin = 1e-8; %BER minima
BERpasso = 1e-2; % Passo da BER
Modulacao = char('BPSK','QPSK','8QAM','16QAM'); %Modulacoes
%Parametros QoS desejados
X = [41 4 2];
Pc = 0.8; %Probabilidade de cruzamento
Pm = 0.06; %Probabilidade de Mutacao
L = 50; %Tamanho da populacao

Geracoes = 160; %Numero de geracoes
%Codificacao dos cromossomos
a = 8;
j = 1;
%Dividindo a frequencia em 100 niveis
for i = fmin:fpasso:fmax-fpasso
    df(j) = ((i + fpasso)-40)/fpasso; %vetor com niveis de 1 a 100 correspondente a banda de frequencia
    j = j + 1;
end
p = 1;
%%Dividindo a potencia em 50 niveis
for i = Pmin:Ppasso:Pmax-Ppasso
    dp(p) = p; %vetor com niveis de 1 a 50 correspondente a potencia
    p = p + 1;
end
b = 1;
%Dividindo a BER em 8 niveis
for i = BERmin:BERpasso:BERmax-2*BERpasso
    db(b) = b; %vetor com niveis de 1 a 8 correspondente a BER
    b = b + 1;
end
m = 1;
%Dividindo a Modulacao em 4 niveis
for i = 1:length(Modulacao)-1
    M(m) = m; %vetor com niveis de 1 a 4 correspondente a Modulacao
    m = m + 1;
end

%Populacao
[P,D,fitness,F] = populacao(L,X,df,dp,db,M);

loop = 1;
D2 = D;
P2 = P;
fitness2 = fitness;
while (max(fitness)>= 0)
 
%f1(loop) = min(fitness);
P1 = P; %Populacao inicial
D1 = D; %Populacao binaria inicial
fitness1 = fitness; %fitness inicial

%selecao
[P,D,fitness] = selecao(P,D,F,fitness,L);

%Cruzamento;
[P,D,fitness] = crossover(P,D,fitness,Pc,X);

%Mutacao
[P,D,m,n,fitness] = mutacao(P,D,fitness,Pm,X);

%elitismo
[P,D,fitness,Pbest,m,n] = elitismo(P,D,fitness,P1,D1,fitness1);
Pbest;
f2(loop) = min(fitness); %Melhor fitness
[a,b] = sort(fitness,'descend');

freq(loop) = P(b(end),4); %Melhor cromossomo de frequencia
Pot(loop) = P(b(end),1); %Melhor cromossomo de potencia
BE(loop) = P(b(end),2); %Melhor cromossomo de BER
MO(loop) = P(b(end),3); %Melhor cromossomo de modulacao
loop = loop + 1;

if loop == Geracoes
    break;
end
end

figure (1)
plot(f2,'k','linewidth',1.5)
xlabel('Generations')
ylabel('Fitness Assessment')
grid on

figure (2)
plot(freq,'r','linewidth',1.5)
xlabel('Generations')
ylabel('Best Individual')
legend('Frequency')
grid on

figure (3)
plot(Pot,'b','linewidth',1.5)
hold on
plot(BE,'-.g','linewidth',1.5)
plot(MO,'--m','linewidth',1.5)
hold off
axis([0 160 0 80])
xlabel('Generations')
ylabel('Best Individuals')
grid on
legend('Power','BER','Modulation')