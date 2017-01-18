funcion LimpiarBordes(Imagen, Regiones)
    m = ObtenerNumeroFilas(Imagen);
    n = ObtenerNumeroColumnas(Imagen);

    CantidadRegiones = ObtenerCantidadRegiones(Regiones);
    para i = 0 hasta CantidadRegiones
    Region = Regiones(i)
    VectorPixeles = ObtenerPixeles(Region)
    CantidadPixeles = ObtenerCantidadPixeles(VectorPixeles)
        para k = 0 hasta CantidadPixeles
            CoordenadaPixel = ObtenerCoordenadaPixel(VectorPixeles(k))
            si CoordenadaPixel en rango ([0 (m-1)], 0) ó (0, [0 n-1] ó (m-1, [0 n-1] ó ([0 (m-1)], n-1))
                EliminarRegion(Regiones(i))
                terminar para k
            fin si
        fin para
    fin para
fin funcion