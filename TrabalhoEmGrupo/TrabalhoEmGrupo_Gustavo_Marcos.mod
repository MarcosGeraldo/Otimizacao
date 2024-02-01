param N; # Numero de Trabalhos Independentes
param M; #Numero de Maquinas

set Trabalhos:={1..N}; #Conjunto de trabalhos independentes
set Maquinas:={1..M}; #Conjunto de maquinas independentes
set H:={1..N};#Conjunto de espaços a serem preenchidos com trabalho ou manutenção

param P{Maquinas,Trabalhos};#Tempo de processamento de um trabalho i na maquina j 
param T{Maquinas};#Tempo de manutenção em uma maquina i
param D{Maquinas,Trabalhos},>=1;#Incremento de tempo causado pelo trabalho i na maquina j

param Maxsum{i in Maquinas}:= sum{j in Trabalhos} P[i,j];
#Somatorio de todos os tempos dos trabalhos de cada maquina 
param Maxprod{i in Maquinas}:= prod{j in Trabalhos} D[i,j];
#Produtorio de todos os incrementos de tempo de cada maquina

var x{Maquinas,Trabalhos,H}, binary;#1 se j  esta sendo executada no espaço h  da maquina i 
var s{Maquinas,H}, binary;# 1 se uma manutenção esta sendo executada no espaço h  da maquina i 
var q{Maquinas,H},>=1;# Incremendo de tempo causado pela deterioração

var Cmax,>=0;#Variavel espremedora 

var a{Maquinas,Trabalhos,H},>=0;#Valor minimo igual a P*Q quando quando o trabalho j e alocado para o espaço h  na maquina i 

minimize fo : Cmax;  

subject to

#Em cada espaço apenas um trabalho ou manutenção 
TrabalhosEspaco {i in Maquinas,h in H} : sum{j in Trabalhos} x[i,j,h]+s[i,h]<=1;#11
#X[i,j,h] sendo 1 se o trabalho j esta acontecendo na maquina i no slot h * S[i,h] 1 se uma manutenção esta sendo executada no espaço h  da maquina i <=1

#Todo trabalho deve ser designado
AlocarTrabalho {j in Trabalhos} : sum{i in Maquinas,h in H} x[i,j,h]=1;#12
#Para todo trabalho j, o somatorio de todas as maquinas i e todos os espaços h deve ser == 1

#As duas restriçoes a seguir definem o tempo atual de processamento de um trabalho j no espaço h da maquina i
F1 {i in Maquinas,j in Trabalhos, h in H} : a[i,j,h] <= (Maxsum[i]*x[i,j,h]);#13
#Caso x[i,j,h] seja 0, a[i,j,h] deve ser 0, caso contrario a[i,j,h] pode assumir qualquer valor
F2 {i in Maquinas,j in Trabalhos, h in H} : a[i,j,h] >= P[i,j]*q[i,h]-(Maxsum[i]*(1-x[i,j,h]));#14
#Caso x[i,j,h] seja 1, a[i,j,h] deve ser maior que P[i,j]*q[i,h], sendo P[i,j] tempo de processamento e q[i,j] o incremento de tempo

#Tempo de produção
Makespan {i in Maquinas}: sum{j in Trabalhos,h in H} a[i,j,h] + sum{h in H}T[i]*s[i,h]<= Cmax;#15
#Aqui é feito o calculo do tempo de produção, ou seja, a[i,j,h] sendo 0 ou >=P[i,j]*q[i,h](Tempo de produção + incremento) + o somatorio dos tempos de manutenção

#Calculo do incremento de tempo
IncrementodeTempo {i in Maquinas,j in Trabalhos, h in H : h!=1}: q[i,h] >= (D[i,j])*q[i,h-1] - Maxprod[i]*(s[i,h-1] + 1 - x[i,j,h-1]);#16
#Sendo Q o incremento de tempo temos que o incremento de tempo atual deve ser >= a D[i,j](Incremento de tempo atual)*q[i,h](Incremento do trabalho anterior) - 
#Valor arbitrariamente grande, caso tenha ocorrido uma manutenção 
#0 caso tenha ocorrido trabalho no espaço anterior

#Performance maxima no inicio da execução
Performance {i in Maquinas} : q[i,1]=1;#17
#Iniciando todas as maquinas com performance maxima

#Variavel adicionada pelo Gustavo, todos os espaços deve ser dispostos de forma continua  
tarefas_continuas{j in Trabalhos, i in Maquinas, h in H: h > 1}: sum{j1 in Trabalhos} x[i, j1, h-1]+s[i,h-1]>= x[i, j, h]+s[i,h];#Adaptação Marcos
#tarefas_continuas{j in Trabalhos, i in Maquinas, h in H: h > 1}: sum{j1 in Trabalhos} x[i, j1, h-1]>= x[i, j, h];

#printf:" \n\nMaxsum1=%.3f Maxsum2=%.3f\n\n",Maxsum[1],Maxsum[2];

solve;
/*
data;

param N:= 5;#numero de trabalhos
param M:=2;#numero de maquina
#P=Tempo de processamentodo trabalho j na maquina i, quando a maquina esta com a performance maxima
param P:  1  2  3  4  5:=
		1 4  2  5  1  2
		2 5  3  1  10 2;
#T=Tempo de manutenção da maquina i
param T:=
1	2
2	2;
#D=Incremento de tempo causado pela deterioração da maquina i apos o trabalho j
param D:  1   2   3   4  5 :=
		1 1.2   1.5   1.7   1.8  1.2  
		2 1.8   1.4   1.3   1.4  1.1;

# Maquina 1 fez Trabalho 1 espaço 1 = 4
# Maquina 1 fez Trabalho 4 espaço 2 = 1*1.2
# Maquina 2 fez Trabalho 5 espaço 1 = 2
# Maquina 2 fez Trabalho 2 espaço 2 = 3*1.1
# Maquina 2 fez Trabalho 3 espaço 3 = 1*1.4*1.1

#Tempo total Maquina 1 = 5.2
#Tempo total Maquina 2 = 6.84
*/

data;
param N:= 5;#numero de trabalhos
param M:=2;#numero de maquina
#P=Tempo de processamentodo trabalho j na maquina i, quando a maquina esta com a performance maxima
param P:  1  2  3  4  5:=
		1 10  10  10  10  10  
		2 10  10  10  10  10;
#T=Tempo de manutenção da maquina i
param T:=
1	1
2	1;
#D=Incremento de tempo causado pela deterioração da maquina i apos o trabalho j
param D:  1     2     3     4     5:=
		1 1.4   1.5   1.7   1.8   1.4
		2 1.8   1.4   1.5   1.7   1.8;
# Maquina 1 fez Trabalho 3 no espaço 1 = 10
# Maquina 1 fez Manutenção no espaço 2 =1
# Maquina 1 fez Trabalho 5 no espaço 3= 10
# Maquina 2 fez Trabalho 4 no espaço 1 =10
# Maquina 2 fez Manutenção no espaço 2=1
# Maquina 2 fez Trabalho 2 no espaço 3 =10
# Maquina 2 fez Manutenção no espaço 4 =1
# Maquina 2 fez Trabalho 1 no espaço 5 =10
#Tempo total Maquina 1 = 21
#Tempo total Maquina 2 = 32

#Tempo total dos trabalhos = 32

end;
