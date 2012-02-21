function [alTable,M,Mag1,Angulos,magx,magy,newIm,Px_5,Py_5,ab5,newCurv] = generateFullTable(nameImage)

newIm=imread(nameImage);
newIm=rgb2gray(newIm);

[Curvature,Mag1,M,Angulos,Next,magx,magy]=CurvConnect(newIm);

[alTable]=runAlongCurve(newIm,250,0,1);%(inputimage,t,p,isGray)

[rows]=size(alTable,1);

N=10;
%absisa5=generaCadaNpuntos(alTable(:,1)',N)Px_5=generaCadaNpuntos(alTable(:,1)',N);;
Px_5=generaCadaNpuntos(alTable(:,1)',N)';
Py_5=generaCadaNpuntos(alTable(:,2)',N)';
ab5=generaCadaNpuntos(alTable(:,3)',N)';

[newRows]=size(Px_5,1);
newCurv=zeros(newRows,1);
for i=2:newRows-1
  
    Px5=Px_5(i,1); %coord x de pixel actual
    Py5=Py_5(i,1); %coord y de pixel actual
    Px5_pre=double(Px_5(i-1,1)); %coord x de pixel anterior
    Py5_pre=double(Py_5(i-1,1)); %coord y de pixel anterior
    Px5_post=double(Px_5(i+1,1)); %coord x de pixel posterior
    Py5_post=double(Py_5(i+1,1)); %coord y de pixel posterior
    c=sqrt((Px5_post - 2* Px5 + Px5_pre)^2 +  (Py5_post - 2* Py5 + Py5_pre)^2);
    newCurv(i,1)=c;
    

end


for i=2:rows-1
  
    Px=alTable(i,1); %coord x de pixel actual
    Py=alTable(i,2); %coord y de pixel actual
    Px_pre=double(alTable(i-1,1)); %coord x de pixel anterior
    Py_pre=double(alTable(i-1,2)); %coord y de pixel anterior
    Px_post=double(alTable(i+1,1)); %coord x de pixel posterior
    Py_post=double(alTable(i+1,2)); %coord y de pixel posterior
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
   alTable(i,13)=Mag1(Px,Py);
    
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


figure;
subplot(3,1,1); plot(alTable(:,3),alTable(:,5), '*');
title('Curvature: "sqrt((Px_{post} - 2* Px + Px_{pre})^2 +  (Py_{post} - 2* Py + Py_{pre})^2)"');
xlabel('s (arc length)');
ylabel('curvature(s)');

subplot(3,1,2);plot(alTable(:,3),alTable(:,8), '*');
title('Diferencia de Angulos');
xlabel('s (arc length)');
ylabel('Dif. angles');

subplot(3,1,3);plot(alTable(:,3),alTable(:,9));
title('Diferencia de Gradiente');
xlabel('s (arc length)');
ylabel('Dif. grad.');


%figure; % diferencia de angulos
%plot(alTable(:,3),alTable(:,8), 'g');
%hold on;

%hold on;

figure; % curvatura
plot(alTable(:,3),alTable(:,12), 'm');
title('Curvature');
xlabel('s (arc length)');
ylabel('curvature(s)');




