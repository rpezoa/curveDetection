function [arcLength]=runAlongCurve(inputimage,t,p,isGray)
% inputimage: a RGB image or a gray image
% t: threshold of the image
% p: if p=1 the the points will be plot
% isGray: if isGray=1, the input image is gray, if isGray=0, the image is
% not gray so the conversion to gray is performed.

% inputimage: name of the image
if ~isGray
    im=imread(inputimage);
    imgris=rgb2gray(im);
else
    imgris=inputimage;
end



% show figure
figure;
imshow(imgris);
hold on;

%[a,b]=find(imgris ~= 255);
%size(a,1)
%arcLength=zeros(size(a,1),9);

% Find first pixel P0 
[x0,y0]=findFirstPixel(imgris,t);
plot(y0,x0,'*b');
disp(['::::: P0 ::::: [',num2str(x0),',',num2str(y0),'] ::::: AZUL']);


% Store the arc length of first each pixel
prevArcLength=0;
arcLength(1,1)=x0;
arcLength(1,2)=y0;
arcLength(1,3)=0;
arcLength(1,4)=0;


marcadaAnterior(1)=x0;
marcadaAnterior(2)=y0;
% create neighborhood of P0
[filas,cols]=generateTemplate(x0,y0,1);
markedRows=filas;
markedCols=cols;


posicion=buscaSiguiente(filas,cols,filas(1),cols(1));
[P1,P2] = getPixel(posicion,filas,cols,imgris,t);
disp(['::::: P1 ::::: [',num2str(P1),',',num2str(P2),']']);
%plot(P2,P1,'*g');
% marca pixel MASLEJANO que corresponde a P1



disp(':::: LOOP ::::');
i=2;
while 1
    
    %disp(['Neighborhood of P: ',  num2str(P1),',',num2str(P2) ,':: ']);
    [filas,cols]=generateTemplate(P1,P2,1);
    
    % eliminate neighborghs of P0 in the copy of the image
    
    %disp(['::::: Previous pixel of P ::::: [',num2str(marcadaAnterior(1)),',',num2str(marcadaAnterior(2)),'] ::::: ']);
    posicion=buscaSiguiente(filas,cols,marcadaAnterior(1),marcadaAnterior(2));
    
    current=sqrt((P1-marcadaAnterior(1))^2 + (P2-marcadaAnterior(2))^2);
    currentArcLength= prevArcLength + current;
    prevArcLength= currentArcLength;
    
    % Store the arc length of each each pixel
    arcLength(i,1)=P1;
    arcLength(i,2)=P2;
    arcLength(i,3)=currentArcLength;
    arcLength(i,4)=current;

    marcadaAnterior(1)=P1;
    marcadaAnterior(2)=P2;
    [P1,P2] = getPixel(posicion,filas,cols,imgris,t);
    if isMarked(P1,P2,markedRows,markedCols)
        disp(['::::: last P ::::: [',num2str(P1),',',num2str(P2),']']);
        break
    end
    %disp(['::::: nuevo P ::::: [',num2str(P1),',',num2str(P2),']']);
    if p==1
        pause(0.05);
        plot(P2,P1,'*b');
    end
    i=i+1;
end
    disp(['::::: ultimo P ::::: [',num2str(P1),',',num2str(P2),']']);    
    plot(P2,P1,'*r');
end

function [marked] =  isMarked(P1,P2,markedRows,markedCols)
for i=1:5
    if markedRows(i) == P1 && markedCols(i) == P2
        marked=1;
        return
    end
end
marked=0;   
end


function [P1,P2] = getPixel(posicion,filas,cols,imgris,t)
sizeFilas=size(filas,2);
for i=posicion:sizeFilas
    %disp('Recorriendo vecinos');
    %disp(['Posicion:',num2str(filas(i)),',',num2str(cols(i)),':::',num2str(imgris(filas(i)),cols(i))]);
    if imgris(filas(i),cols(i)) < t
    %busca sgte. pixel de P1
    P1=filas(i);
    P2=cols(i);
    return
    end
end
for j=1:posicion-1
    %disp('Recorriendo vecinos');
    %disp(['Posicion:',num2str(filas(j)),',',num2str(cols(j)),':::',num2str(imgris(filas(j)),cols(j))]);
    if imgris(filas(j),cols(j)) < t
    %busca sgte. pixel de P1
    P1=filas(j);
    P2=cols(j);
    return
    end
end

end

function [pos]= buscaSiguiente(filas,cols,marcAntX,marcAntY)
sizeFilas=size(filas,2);
for i=1:sizeFilas+1;
    if ((filas(i)== marcAntX) && (cols(i)==marcAntY))
        pos=i+1;
        %disp(['Buscar desde: (',num2str(filas(pos)),',',num2str(cols(pos))]);
        return
    end
end
end




