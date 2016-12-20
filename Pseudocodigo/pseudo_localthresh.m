function Respuesta = uLocal(Imagen, Vecindario, a, b, TipoPromedio)
mDesvStd = CalcularMatrizDStd(Imagen, Vecindario)
si TipoPromedio == "global"
mPromedios = CalcularValorProm(Imagen)
si no
mPromedios = CalcularMatrizProm(Imagen)
fin si

m = ObtenerFilas(Imagen);
n = ObtenerColumnas(Imagen);
para i = 0 hasta m-1
    para j = 0 hasta n-1
        MayorDStd = Imagen(i,j) > a * mDesvStd(i,j)
        MayorMPromedios = (Imagen(i,j) > b * mPromedios(i,j)
        g(i,j) = (MayorDStd & MayorMPromedios) ? 1 : 0
    fin para
fin para
ImagenBinaria = g
