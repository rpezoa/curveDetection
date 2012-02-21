function [alTable,M,Angulos,magx,magy,newIm] = generateFullTable(nameImage)

newIm=imread(nameImage);
newIm=rgb2gray(newIm);

[Curvature,Mag1,M,Angulos,Next,magx,magy]=CurvConnect(newIm);


[alTable]=runAlongCurve(newIm,250,0,1);%(inputimage,t,p,isGray)



[rows]=size(alTable,1);

for i=2:rows-1
    
    Px=alTable(i,1); %coord x de pixel actual
    Py=alTable(i,2); %coord y de pixel actual
    Px_pre=alTable(i-1,1); %coord x de pixel anterior
    Py_pre=alTable(i-1,2); %coord y de pixel anterior
    Px_post=alTable(i+1,1); %coord x de pixel posterior
    Py_post=alTable(i+1,2); %coord y de pixel posterior
    curv=sqrt((Px_post - 2* Px + Px_pre)^2 +  (Py_post - 2* Py + Py_pre)^2);
    alTable(i,5)=curv; % curvatura
    alTable(i,6)=M(Px,Py); % magnitud gradiente
    alTable(i,7)=Angulos(Px,Py); % direccion gradiente
    difAngles=abs(Angulos(Px,Py) - Angulos(Px_pre,Py_pre));
    alTable(i,8)=difAngles;
    gradPost=[magx(Px_post, Py_post); magy(Px_post,Py_post)];
    grad=[magx(Px, Py); magy(Px,Py)];

    if norm(gradPost) ~= 0
        gradPost= gradPost/norm(gradPost);
    else
        gradPost= 0;
    end
    
    if norm(grad) ~=0
    grad=grad/norm(grad);
    else
        grad=0;
    end
    
    difGradiente = gradPost - grad;
    difGradiente = norm(difGradiente);
    alTable(i,9)=difGradiente;
    alTable(i,10)=magx(Px, Py);
   alTable(i,11)=magy(Px,Py);
   alTable(i,12)=Curvature(Px,Py);
    
end
 
figure;
subplot(2,1,1); plot(alTable(:,3), alTable(:,1));
title('coordinate x as function of arc length s');
xlabel('s (arc length)');
ylabel('x(s)');

subplot(2,1,2); plot(alTable(:,3), alTable(:,2));
title('coordinate y as function of arc length s');
xlabel('s (arc length)');
ylabel('y(s)');


%figure;
%plot(alTable(1:n,3),alTable(1:n,6), '*');

%figure;
%plot(alTable(1:n,3),alTable(1:n,7), '*');

%figure; % diferencia de angulos
%plot(alTable(:,3),alTable(:,8), 'g');
%hold on;
%figure; % diferencia de gradiente
%plot(alTable(:,3),alTable(:,9), 'r');
%hold on;

%figure; % curvatura
%plot(alTable(:,3),alTable(:,12), 'm');




