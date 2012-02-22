function [newPuntos] = generaCadaNpuntos(puntos,N)
% puntos: vector de la forma [x1 x2 ... xn]
% N: the step to select elements of the vector puntos

d = length(puntos);
count=0;
newPuntos=zeros(1,round(d/N)); % new vector
j=2;
newPuntos(1)=puntos(1);
for i=2:d
    if mod(i,N) == 0 % if the element puntos(i) is a multiple of N, it is matained.
    newPuntos(j) = puntos(i);
    j=j+1;
    end
    count=count+N;
end
