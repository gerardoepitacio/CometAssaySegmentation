function Clase = ObtenerClase(ColumnaPertenencia)
% ObtenerClase, devuelve la clase a la que pertenece el patron k, basado en
% el grado de pertenencia mas alto que se tenga el patron con todas las
% clases.
% Clase = ObtenerClase(ColumnaPertenencia)
% Donde: 
% ColumnaPertenencia: es un vector [1-C] con los grados de pertenencia en
% cada clase, donde C es el numero de clases.
[~, Clase] =  max(ColumnaPertenencia);
end