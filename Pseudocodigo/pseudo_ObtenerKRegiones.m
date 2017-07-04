funcion [Img, Frec] = ObtenerKRegiones(mCent, vIndices, Filas, Columnas)
    VectorBrillo = ObtenerVectorBrillo(mCent);
    VectorBrilloOrd = OrdenarVector(VectorBrillo);
    Resultado = CrearImagenRGB(Filas, Columnas);
    IndiceActual = 0;
    para i = 0 hasta (Filas-1)
        para j = 0 hasta (Columnas-1)
            Clase = ObtenerClase(vIndices, IndiceActual++);
            Region = ObtenerRegion(Clase, VectorBrillo, VectorBrilloOrd);
            Resultado(i, j) = ObtenerColorRegion(Region);
            ContadorRegion[Region]++;
        fin para
    fin para
    Img = Resultado;
    Frec = ContadorRegion;
fin funcion