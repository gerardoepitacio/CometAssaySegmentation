funcion Patrones = ObtenerPatrones(SubImagen, Filas, Columnas)
    SubImagen = TransformarADouble(SubImagen);
    SubImagen = ExtrecharHistograma(SubImagen, 0, 1);
    stdImg = ObtenerDesvStdPorVecindad(SubImagen, 11, 11);
    meanImg = ObtenerPromedioPorVecindad(SubImagen, 11, 11);
    Tam = Filas * Columnas;
    Respuesta = zeros(Tam, 3);
    k = 1;
    para i = 0 hasta (Filas - 1), 
        para j = 0 hasta (Columnas - 1) ,  
            Respuesta(k, 1) = SubImagen(i,j);
            Respuesta(k, 2) = stdImg(i,j);
            Respuesta(k, 3) = meanImg(i,j);
            k = k+1;
        fin para
    fin para
    Patrones = Respuesta;
fin function