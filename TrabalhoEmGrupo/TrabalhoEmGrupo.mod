
param N; # Numero de Trabalhos Independentes
param M; #Numero de Maquinas

set Trabalhos:={1..N}; #Conjunto de trabalhos independentes
set Maquinas:={1..M}; #Conjunto de maquinas independentes
set H:={1..N};

param P{Maquinas,Trabalhos};
param T{Maquinas};
param D{Maquinas,Trabalhos};

param Maxsum{i in Maquinas}:= sum{j in Trabalhos} P[i,j]; 
param Maxprod{i in Maquinas}:= prod{j in Trabalhos} D[i,j];
#param Maxsum:=100000;
#param Maxprod:=1000000;

var x{Maquinas,Trabalhos,H}, binary;#1 se j  esta sendo executada no espaço h  da maquina i 
var s{Maquinas,H}, binary;# 1 se uma manutenção esta sendo executada no espaço h  da maquina i 
var q{Maquinas,H},>=1;# Incremendo de tempo causado pela deterioração
var Cmax,>=0;#Variavel espremedora 
var a{Maquinas,Trabalhos,H},>=0;#Valor minimo igual a P*Q quando quando o trabalho j e alocado para o espaço h  na maquina i 

minimize fo : Cmax;  

subject to
/*valorMinA {i in Maquinas,j in Trabalhos, h in H}:
	if a[i,j,h] > 0 then a[i,j,h]=P[i,j]*q[i,h]; 
	#and a[i,j,h] < P[i,j]*q[i,h]
*/
#Em cada espaço apenas um trabalho ou manutenção 
TrabalhosEspaco {i in Maquinas,h in H} : sum{j in Trabalhos} x[i,j,h]+s[i,h]<=1;#11
#Todo trabalho deve ser designado
AlocarTrabalho {j in Trabalhos} : sum{i in Maquinas,h in H} x[i,j,h]=1;#12
#As duas a seguir definir o tempo atual de processamento de um trabalho j no espaço h da maquina m, com Mia=SUM(j in J){p[i, j]} como uma constante suficientemente grande, para toda maquina i, desta forma fixando o valor de a[i, j, h] sempre que x[i, j, h] =1;
Fixador1 {i in Maquinas,j in Trabalhos, h in H} : a[i,j,h] - (Maxsum[i]*x[i,j,h]) <= 0;#13
Fixador2 {i in Maquinas,j in Trabalhos, h in H} : a[i,j,h] - (P[i,j]*q[i,h]-(Maxsum[i]*(1-x[i,j,h]))) >= 0;#14
#Tempo de produção
Makespan {i in Maquinas}: sum{j in Trabalhos,h in H} a[i,j,h] + sum{h in H}T[i]*s[i,h]-Cmax<=0;#15
#Calculo do incremento de tempo
IncrementodeTempo {i in Maquinas,j in Trabalhos, h in H : h!=1}:
#if h > 1 then 
q[i,h]-(D[i,j]*q[i,h-1]-Maxprod[i]*(s[i,h-1]+1-x[i,j,h-1]))>=0;#16
#Performance maxima no inicio da execução
Performance {i in Maquinas} : q[i,1]=1;#17

#printf:" \n\nMaxsum1=%.3f Maxsum2=%.3f\n\n",Maxsum[1],Maxsum[2];

solve;
/*data;
param N:=10;#numero de trabalhos
param M:=4;#numero de maquina
#P=Tempo de processamentodo trabalho j na maquina i, quando a maquina esta com a performance maxima
param P:  1  2  3  4  5  6  7  8  9  10:=
		1  10 6  5  3  7  9  6  12 4  5
		2  5  13 7  6  5  14 9  8  11 9
		3  7  8  15 9  10 7  4  5  8  14
		4  9  6  8  11 8  5  16 7  6  7;
#T=Tempo de manutenção da maquina i
param T:=
1	10
2	12
3	11
4	14;
#D=Incremento de tempo causado pela deterioração da maquina i apos o trabalho j
param D: 1 2 3 4 5 6 7 8 9 10:=
		1 1 2 4 2 3 1 1 4 5 2
		2 3 2 1 4 2 4 1 1 3 4
		3 2 3 3 1 2 2 4 1 3 1
		4 1 1 3 2 3 4 2 1 4 3; 
*/
data;
param N:=4;#numero de trabalhos
param M:=2;#numero de maquina
#P=Tempo de processamentodo trabalho j na maquina i, quando a maquina esta com a performance maxima
param P:  1  2  3  4 :=
		1 4  2  5  4  
		2 1  3  2  3;
#T=Tempo de manutenção da maquina i
param T:=
1	1
2	1;
#D=Incremento de tempo causado pela deterioração da maquina i apos o trabalho j
param D:  1   2   3   4:=
		1 2   2   2   2
		2 2   2   2   2;

/*data;
param N:=3;#numero de trabalhos
param M:=3;#numero de maquina
#P=Tempo de processamentodo trabalho j na maquina i, quando a maquina esta com a performance maxima
param P:  1  2  3 :=
		1 1  1  1
		2 1  1  1
		3 1  1  1;
#T=Tempo de manutenção da maquina i
param T:=
1	1
2	1
3	1;
#D=Incremento de tempo causado pela deterioração da maquina i apos o trabalho j
param  D: 1 2 3 :=
		1 1 1 1 
		2 1 1 1
		3 1 1 1; 
*/
end;
