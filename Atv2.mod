set DH:={1..3};
set PRO:={1..4};

param PV{PRO};
param disp{DH};
param mat{DH,PRO};

var x{PRO},>=0,integer;

maximize lucro: sum{j in PRO} x[j]*PV[j];

subject to
dis_Horas{i in DH}: sum{j in PRO} mat[i,j]*x[j]<=disp[i];
solve;

data;
param PV:= 
	1 100
	2 80
	3 120 
	4 20;

param disp:=
	1 250 
	2 600
	3 500;


param mat: 1 2 3 4:=
	1 1 2 1 4
	2 0 1 3 2
	3 3 2 4 0;

end;