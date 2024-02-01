\* Problem: Atv5 *\

Minimize
 custo: + 1.2 x(D1,C1) + 0.8 x(D2,C1) + 1.4 x(D1,C2) + 1.2 x(D2,C2)
 + 0.8 x(D1,C3) + 1.1 x(D2,C3) + 0.15 x(DA,C3)

Subject To
 fluxoEqui(D1): + x(D1,C1) + x(D1,C2) + x(D1,C3) = 1000
 fluxoEqui(D2): + x(D2,C1) + x(D2,C2) + x(D2,C3) = 3000
 fluxoEqui(DA): + x(DA,C1) + x(DA,C2) + x(DA,C3) = 500
 fluxoEqui(C1): - x(D1,C1) - x(D2,C1) - x(DA,C1) = -1800
 fluxoEqui(C2): - x(D1,C2) - x(D2,C2) - x(DA,C2) = -1500
 fluxoEqui(C3): - x(D1,C3) - x(D2,C3) - x(DA,C3) = -1200
 requisitosClientes(C1): + x(D1,C1) + x(D2,C1) + x(DA,C1) >= 1800
 requisitosClientes(C2): + x(D1,C2) + x(D2,C2) + x(DA,C2) >= 1200
 requisitosClientes(C3): + x(D1,C3) + x(D2,C3) + x(DA,C3) >= -0

End
