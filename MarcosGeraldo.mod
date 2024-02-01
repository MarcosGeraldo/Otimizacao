#Marcos Geraldo Braga Emiliano 19.1.4012
param tr;
param muni;
set Tra:={1..tr};
set Mun:={1..muni};

param popMun{Mun};
param coefMun{Tra,Mun};
param custo{Tra};
param verba;

var x{Tra},>=0,binary;

maximize popAten: sum{j in Tra,i in Mun} x[j]*(popMun[i]*coefMun[j,i]);

subject to
verbaLimite: sum{i in Tra} custo[i]*x[i]<=verba;
solve;

data;
/*
param tr:= 6;
param verba:= 12;
param muni:= 12;

param popMun:=
	1 4
	2 3
	3 10
	4 14
	5 6
	6 7
	7 9
	8 10
	9 13
	10 11
	11 6
	12 12;

param custo:=
	1 3.6
	2 2.3
	3 4.1
	4 3.15
	5 2.8
	6 2.65;

param coefMun: 1 2 3 4 5 6 7 8 9 10 11 12:=
	1	 1 1 0 0 0 0 0 0 0 0 0 0
	2	 0 1 1 0 1 0 0 0 0 0 0 0
	3	 1 0 0 0 0 0 1 0 1 1 0 0
	4	 0 0 0 1 0 1 0 1 1 0 0 0
	5	 0 0 0 0 0 1 1 0 1 0 1 0
	6	 0 0 0 0 1 0 1 0 0 0 0 1;
*/
param tr:= 5;
param verba:= 18;
param muni:= 14;

param popMun:=
	1 6
	2 5
	3 10
	4 15
	5 9
	6 7
	7 9
	8 11
	9 13
	10 20
	11 6
	12 12
	13 11
	14 6;

param custo:=
	1 3.6
	2 2.3
	3 8.1
	4 3.15
	5 2.8;

param coefMun: 1 2 3 4 5 6 7 8 9 10 11 12 13 14:=
	1	 1 1 0 0 0 0 0 0 0 0 0 0 0 1
	2	 0 1 1 0 1 0 0 0 0 0 0 0 1 0
	3	 1 0 0 0 0 0 1 0 1 1 0 0 0 0
	4	 0 0 0 1 0 1 0 1 1 0 0 0 1 0
	5	 0 0 0 0 0 1 1 0 1 0 1 0 0 1;
end;

