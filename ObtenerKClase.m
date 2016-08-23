function Clase = ObtenerKClase(KIdx, VectorBrilloCentral, VBCentralOrdenado)
% ObtenerKClase, devuelve el numero de region a la que pertenece el KIdx
% respecto al valor de brillo del centroide de la clase.
% Clase = ObtenerKClase(KIdx, VectorBrilloCentral, VBCentralOrdenado)
% Donde: 
% KIdx:                 Es el indice de la clase a la que pertenece el K patron.
% VectorBrilloCentral:  Vector con la columna de brillos de los centroides
% VBCentralOrdenado:    Vector con la columna de brillos de los centroides
% ordenado.
ValorCentral = VectorBrilloCentral(KIdx,1);
Clase = find(VBCentralOrdenado == ValorCentral);
end