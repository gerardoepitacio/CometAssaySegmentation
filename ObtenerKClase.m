function Clase = ObtenerKClase(KCluster, VectorBrilloCentral, VBCentralOrdenado)
ValorCentral = VectorBrilloCentral(KCluster,1);
Clase = find(VBCentralOrdenado == ValorCentral);
end