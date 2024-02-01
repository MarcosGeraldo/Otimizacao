#Marcos Geraldo Braga Emiliano 19.1.4012

set N;# Numero de nos
set C;# Numero de clientes
set A, within N cross N;#Conjunto de arcos

param ofertaDeman{N};#Ofertas e demandas da rede


param requisitos{C};
param custos{(i,j) in A}; #Matriz de custos
check sum{i in N} ofertaDeman[i]=0;#Confere se a rede é balanceada

var x{(i,j) in A}>=0; #Variavel de decisão

minimize custo: sum{(i,j) in A} custos[i,j]*x[i,j]; #minimizando o custo

subject to

fluxoEqui{i in N}: sum{(i,j) in A} x[i,j] - sum{(j,i) in A} x[j,i]=ofertaDeman[i];#Equação de fluxo balanceado

requisitosClientes{j in C}: sum {(i,j) in A} x[i,j]>=requisitos[j];#requisitos dos clientes

solve;

data;

set C := C1,C2,C3;
set N := D1, D2, DA, C1, C2, C3; 
param: ofertaDeman:=
D1 1000
D2 3000
DA 500
C1 -1800
C2 -1500
C3 -1200;
param: A : custos:=
D1 C1 1.2
D2 C1 0.8
DA C1 0
D1 C2 1.4
D2 C2 1.2
DA C2 0
D1 C3 0.8
D2 C3 1.1
DA C3 0.15;

param: requisitos:=
C1 1800
C2 1200
C3 0;

end;
