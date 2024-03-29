
param Maxint:=100000;
param N; # Numero de Trabalhos Independentes
param M; #Nuemro de Maquinas
#param h1;

set Trabalhos:={1..N}; #Conjunto de trabalhos independentes
set Maquinas:={1..M}; #Conjunto de maquinas independentes

param P{Maquinas,Trabalhos};
param T{Maquinas};
param D{Maquinas,Trabalhos},>=1;

set H:={1..H};

var x{Maquinas,Trabalhos,H}, binary;#1 se j  esta sendo executada no espa�o h  da maquina i 
var s{Maquinas,H}, binary;# 1 se uma manuten��o esta sendo executada no espa�o h  da maquina i 
var q{Maquinas,H},>=1;# Incremendo de tempo causado pela deteriora��o
var Cmax;#Variavel espremedora 
var a{Maquinas,Trabalhos,H},>=0;#Valor minimo igual a P*Q quando quando o trabalho j e alocado para o espa�o h  na maquina i 

minimize Cmax;  

subject to
#Em cada espa�o apenas um trabalho ou manuten��o 
TrabalhosEspaco {h in H,i in Maquinas} : sum{j in Trabalhos} X[i,j,h]+S[i,h]<=1;
#Todo trabalho deve ser designado
AlocarTrabalho {j in trabalhos} : sum{i in Maquinas,h in H} x[i,j,h]=1;
# Mia = sum{j in Trabalhos} p[i,j]
#As duas a seguir definir o tempo atual de processamento de um trabalho j no espa�o h da maquina m, com Mia=SUM(j in J){p[i, j]} como uma constante suficientemente grande, para toda maquina i, desta forma fixando o valor de a[i, j, h] sempre que x[i, j, h] =1;
Fixador1 {i in Maquinas,j in Trabalhos, h in H} : a[i,j,h] <= Maxint*x[i,j,h];
Fixador2 {i in Maquinas,j in Trabalhos, h in H} : a[i,j,h] <= P[i,j]*Q[i,j]-Maxint(1-x[i,j,h]);
#Tempo de produ��o
Makespan {i in Maquinas}: sum{j in trabalhos,h in H} a[i,j] + sum{h in H}t[i]*s[i,h]-Cmax<=0;
#Calculo do incremento de tempo
IncrementodeTempo {i in Maquinas,j in Trabalhos, h in H}:
	if h!= 1 then q[i,h]>=D[i,j]*q[i,h-1]-Maxint(s[i,h-1]+1-x[i,j,h-1])
#P�rformance maxima no inicio da execu��o
Performance {i in Maquinas}: q[i,1]=1;

solve;
data;
param N:= ;#numero de trabalhos
param M:= ;#numero de maquinas
#P=Tempo de processamentodo trabalho j naquina i, quando a maquina esta com a performance maxima
param P:= 1 2 3 4
1	
2	
3	;
#T=Tempo de manuten��o da maquina i
param T:=
1	
2	
3	;
#D=Incremento de tempo causado pela deteriora��o da maquina i apos o trabalho j
param D:= 1 2 3 4
1	
2	
3	;
end;