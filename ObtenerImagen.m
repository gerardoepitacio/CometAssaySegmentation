function  Img = ObtenerImagen(Patrones, m, n)
Img = uint8(zeros(m,n));
k=1;
    for i = 1:m
        for j= 1:n  
            Img(i, j) = Patrones(k,2);
            k = k + 1;
        end
    end
end