funcion [Img, Frec] = ObtenerRegionesFCM(U, mCentroides, Filas, Columnas)
    VectorBrillo = ObtenerVectorBrillo(mCentroides);
    UOrdenada = ReordenarFilasPorVectorBrillo(U, VectorBrillo);
    Resultado = CrearImagenRGB(Filas, Columnas);
    ColumnaActual = 1;
    para i = 0 hasta (Filas-1)
        para j = 0 hasta (Columnas-1)
            Clase = ObtenerClase(U, ColumnaActual);
            Region = ObtenerRegion(Clase);
            Resultado(i, j) = ObtenerColorRegion(Region);
            ContadorRegion[Region]++;
        fin para
    fin para
    Img = Resultado;
    Frec = ContadorRegion;
fin funcion