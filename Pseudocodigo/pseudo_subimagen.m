funcion Respuesta = ObtenerSubImagen(Imagen, BoundingBox)
    m = ObtenerNumeroFilas(Imagen)
    n = ObtenerNumeroColumnas(Imagen)
    x1,y1 = ObtenerCoordenadasP1(BoundingBox)
    x2,y2 = ObtenerCoordenadasP2(BoundingBox)
    AltoSubimagen = ObtenerAlto(BoundingBox)
    AnchoSubimagen = ObtenerAncho(BoundingBox)
    g = CrearMatrizZeros(AltoSubimagen, AnchoSubimagen);

    para i = 0 hasta m-1
        para j = 0 hasta n-1
        si i,j >= x1,y1 & i,j <= x2,y2
            g(i,j) = Imagen(i,j)
        fin para
    fin para
    Respuesta = g;
fin funcion