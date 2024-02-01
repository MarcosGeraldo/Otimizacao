param m;
set Tam:= {1..m};
param demandaMinima{m};
param CustoNormal{m};
param CustoExtra{m};

var x{1..m} >=0,integer;
var y{1..m} >=0,integer;

minimize custo: sum{i in Tam} (CustoNormal[i] * x[i] + CustoExtra[i] * y[i]);

turno{i in Tam}:
	if i=1 then x[i] + x[m]+y[m-1]
	else
		if i=2 then x[i]+x[i-1]+y[m]
		else x[i] + x[i-1] +y[i-2]>=demandaMinima[i];

turnoExtra{i in Tam}:
	if i=1 then y[m-1] -(0.2*( x[i] +x[m] + y[m-1]))
	else
		if i=2 then y[m] - (0.2 * ( x[i] + x[i-1] + y[m]))
		else y[i-2] - (0.2 * ( x[i] + x[i-1] + y[i-2})) <= 0;

extra {i in Tam}: x[i]>=y[i];

solve;
data;
param m:=6;
param CustoNormal:=
	1 1000
	2 900
	3 800
	4 800
	5 900
	6 1000;

param CustoExtra:=
	1 750
	2 750
	3 600
	4 600
	5 600
	6 750;

param demandaMinima:=
	1 7
	2 6
	3 8
	4 18
	5 16
	6 20;
