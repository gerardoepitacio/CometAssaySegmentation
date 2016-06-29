function img = ObtenerRegiones(Clases, centro,m, n)
    img = uint8(zeros(m,n,3));
    k = 1;
    Clases(:,m*n+1)= centro(:,1);
    B = sortrows(Clases,m*n+1);
    B(:,m*n+1) = [];
    for i = 1 : m
        for j = 1 : n
           Clase =  ObtenerClase(B(:,k));
          switch Clase
           case 1
             % img(i,j) = (centro(1,1));
              img(i,j,:) = [0 0 0];
           case 2
            %img(i,j) = (centro(2,1));
            img(i,j,:) = [0 255 0];
          case 3
             %img(i,j) = (centro(3,1));
             img(i,j,:) = [0 0 255];
          case 4
             %img(i,j) = (centro(4,1));
             img(i,j,:) = [255 0 0];
          end
            k=k+1;
        end
    end
end

