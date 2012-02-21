function [outputimage,Mag1,Mag,Ang,Next,magx,magy]=CurvConnect(inputimage)

[rows,columns]=size(inputimage);
outputimage=zeros(rows,columns);
[Mag1,Ang,magx,magy]=Edges(inputimage);
Mag=MaxSupr(Mag1,Ang);
Next=cont(Mag,Ang);

for x=1:columns-1
    for y=1:rows-1
        if Mag(y,x) ~=0
            n=Next(y,x,1);
            m=Next(y,x,2);
            if (n~=-1 && m~=-1)
                [px,py]=NextPixel(x,y,n);
                [qx,qy]=NextPixel(x,y,m);
                outputimage(y,x)=abs(Ang(py,px)-Ang(qy,qx));
            end
        end
    end
end