function [newPuntos] = generaCadaNpuntos(puntos,N)

d = size(puntos,2)
count=0;
newPuntos=zeros(1,round(d/N));
j=2;
newPuntos(1)=puntos(1);
for i=2:d
    if mod(i,N) == 0
    newPuntos(j) = puntos(i);
    j=j+1;
    end
    count=count+N;
end
