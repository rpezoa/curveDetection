% Maximal supression
function  outputimage= MaxSupr(Mag,Ang) 
 
%image size
[rows,columns]=size(Mag);

%Max supression image
outputimage=zeros(rows,columns);
 
%Compute max suppresion 
for x=2:columns-1
    for y=2:rows-1
        if Mag(y,x)>0
            t=Ang(y,x);   %angle of edge
            if (t<.57 && t>-.57)
                if (Mag(y,x)>=Mag(y+1,x) && Mag(y,x)>Mag(y-1,x))
                    outputimage(y,x)=Mag(y,x);
                end
            elseif t>1.04 || t<-1.04
                if Mag(y,x)>=Mag(y,x+1) && Mag(y,x)>Mag(y,x-1)
                    outputimage(y,x)=Mag(y,x);
                end
            elseif t>.57
                if Mag(y,x)>=Mag(y+1,x-1) && Mag(y,x)>Mag(y-1,x+1)
                    outputimage(y,x)=Mag(y,x);
                end
            else
                if Mag(y,x)>=Mag(y-1,x-1) && Mag(y,x)>Mag(y+1,x+1)
                    outputimage(y,x)=Mag(y,x);
                end
            end
        end
    end
end