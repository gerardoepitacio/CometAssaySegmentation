Area = csvread('Validacion/Area.csv', 1,0);
p = anova1(Area);

AreaCola = csvread('Validacion/AreaCola.csv', 1,0);
pCola = anova1(AreaCola);

AreaHalo = csvread('Validacion/AreaHalo.csv', 1,0);
pHalo = anova1(AreaHalo);

Tiempo = csvread('Validacion/Tiempo.csv', 1,0);
pTiempo = anova1(Tiempo);

p
pCola
pHalo
pTiempo

