set HM :={1..2};
set DH :={1..4};

param PV{HM};
param disp{DH};
param mat{DH,HM};

var x1{HM},>=0,integer;


maximize lucro: sum{j in HM} x1[j]*PV[j];

subject to
Disp_MP{i in DH}:sum{j in HM} mat[i,j]*x1[j]<=disp[i];
solve;


data;
param PV :=
	1 50
	2 40;

param disp :=
	1 300
	2 540
	3 440
	4 300;

param mat : 1 2 :=
	1 2 1
	2 1 2.5
	3 2 2 
	4 0.2 0.5;

end;