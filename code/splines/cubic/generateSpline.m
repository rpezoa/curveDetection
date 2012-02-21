function [pp,alTable] = generateSpline(alTable,nameIm)

x_curv=alTable(:,1);
y_curv=alTable(:,2);
arcCoord = alTable(:,3);
N=5;
absisa5=generaCadaNpuntos(arcCoord',N);
X_5=generaCadaNpuntos(x_curv',N);


pp=spline(absisa5,X_5);% genera splines cubicos, en este caso 247 polinomios cubicos
genx = ppval(pp,absisa5);
figure; plot(absisa5,genx);
set(gca,'Fontsize',11)
legend('spline interpolation of x(s)');


figure;
plot(absisa5,X_5,'r');
set(gca,'Fontsize',11)
xlim([0,1500]);
ylim([0,1500]);
legend('x(s)');



%p_der=fnder(pp,2); %aca tambien se obtiene la seg. derivada
%x_prime=ppval(p_der,absisa5);

% testing
xx=linspace(absisa5(1),absisa5(2));
x_s(1,:)=pp.coefs(1,4)+pp.coefs(1,3)*(xx-absisa5(1))+pp.coefs(1,2)*(xx-absisa5(1)).^(2)+pp.coefs(1,1)*(xx-absisa5(1)).^(3);
%x_s=pp.coefs(1,4)+pp.coefs(1,3)*(9.8284-absisa5(1))+pp.coefs(1,2)*(9.8284-absisa5(1))^(2)+pp.coefs(1,1)*(9.8284-absisa5(1))^(3);
x_s_prima(1,:)=pp.coefs(1,3) + 2* pp.coefs(1,2)*(xx-absisa5(1)) + 3* pp.coefs(1,1)*(xx-absisa5(1)).^(2);
x_s_prima_prima(1,:)= 2* pp.coefs(1,2)  + 6* pp.coefs(1,1)*(xx-absisa5(1));
%disp(x_s);


xx=linspace(absisa5(2),absisa5(3));
x_s(2,:)=pp.coefs(2,4)+pp.coefs(2,3)*(xx-absisa5(2))+pp.coefs(2,2)*(xx-absisa5(2)).^(2)+pp.coefs(2,1)*(xx-absisa5(2)).^(3);
x_s_prima(2,:)=pp.coefs(2,3) + 2* pp.coefs(2,2)*(xx-absisa5(2)) + 3* pp.coefs(2,1)*(xx-absisa5(2)).^(2);
x_s_prima_prima(2,:)= 2* pp.coefs(2,2)  + 6* pp.coefs(2,1)*(xx-absisa5(2));


n = size(absisa5,2);
for i = 1:n-1
    xx=linspace(absisa5(i),absisa5(i+1));
    x_s(i,:)=pp.coefs(i,4)+pp.coefs(i,3)*(xx-absisa5(i))+pp.coefs(i,2)*(xx-absisa5(i)).^(2)+pp.coefs(i,1)*(xx-absisa5(i)).^(3);
    x_s_prima(i,:)=pp.coefs(i,3) + 2* pp.coefs(i,2)*(xx-absisa5(i)) + 3* pp.coefs(i,1)*(xx-absisa5(i)).^(2);
    x_s_prima_prima(i,:)= 2* pp.coefs(i,2)  + 6* pp.coefs(i,1)*(xx-absisa5(i));
end
    
figure;

for j = 1: n-1
    
    hold on; plot(linspace(absisa5(j),absisa5(j+1)),x_s(j,:),'g');
    hold on; plot(linspace(absisa5(j),absisa5(j+1)),x_s_prima(j,:),'m');
    hold on; plot(linspace(absisa5(j),absisa5(j+1)),x_s_prima_prima(j,:),'c');

end

% getting coefs. of the second derivative
% which is a line, therefore, A(:,1)=0, A(:,2)=0,
% which have the coef. of the the cubic and cuadratic exponent, respec.

Z=zeros(size(pp.coefs));
Z(:,2)=3*pp.coefs(:,1);
Z(:,3)=2*pp.coefs(:,2);
Z(:,4)=pp.coefs(:,3);

A=zeros(size(pp.coefs));
A(:,3)=6*pp.coefs(:,1);
A(:,4)=2*pp.coefs(:,2);

% builds a piecewise poly.
ppp=mkpp(absisa5,A);

x=ppval(ppp,absisa5(1):0.01:absisa5(n));

for i=1:n-1
    ese=absisa5(i);
    xpp(i,:)=ppp.coefs(i,3)*(ese - absisa5(i)) + ppp.coefs(i,4);
end;


xpp(n,:)=ppp.coefs(n-1,1)*(absisa5(n) - ese) + ppp.coefs(n-1,2);

% figure; 
% plot(absisa5(1):0.01:absisa5(n),x,'m');
% set(gca,'Fontsize',11)
% legend(['second derivative of x(s), ', nameIm])
% hold on;
%plot(100,100)
% figure;
% plot(absisa5(1):0.01:absisa5(n),x);
% xlim([0,1500])
% ylim([0,9])
% 
% figure;
% plot(absisa5(1:5),x(1:5));
% xlim([0,10])
% ylim([0,10])




Y_5=generaCadaNpuntos(y_curv',N);
rr=spline(absisa5,Y_5);
geny = ppval(rr,absisa5);
% figure; plot(absisa5,geny);
% set(gca,'Fontsize',11)
% legend('spline interpolation of y(s)');

% figure;
% plot(absisa5,Y_5,'r');
% set(gca,'Fontsize',11)
% legend('y(s)');

% getting coefs. of the second derivative
B=zeros(size(rr.coefs));
B(:,3)=6*rr.coefs(:,1);
B(:,4)=2*rr.coefs(:,2);

rrr=mkpp(absisa5,B);
y=ppval(rrr,absisa5(1):0.01:absisa5(n)); % !!!!!!!!!!!!

 
% figure; 
% plot(absisa5(1):0.01:absisa5(n),y,'m');
% set(gca,'Fontsize',11)
% legend(['second derivative of y(s), ', nameIm])
% hold on;
% xlim([0,1500])
% ylim([0,1500])


%!!!!!!! OJO QUE LA NORMA DE LOS VECTORES TANGENTES DEBE SER 1
kap=sqrt(x.^2 + y.^2);
figure;plot(absisa5(1):0.01:absisa5(n),kap,'k');
xlim([0,800])
ylim([0,800])
set(gca,'Fontsize',11);
legend('curvature sqrt(x_{pp}^2 + y_{pp}^2)');


figure;plot((absisa5(1):0.01:absisa5(n)),kap,'k');
set(gca,'Fontsize',11);
legend('curvature sqrt(x_{pp}^2 + y_{pp}^2) - v2');
ylim([0,1])
xlim([0,1500])


% 
% 
% 
% n=size(A,1);
% count=1;
% 
% for i=1:n
%     c=A(i,1);
%     b=A(i,2);
%     e=B(i,1);
%     f=B(i,2);
%     
%     first=count;
%     if (first) > size(alTable,1)
%         disp('yes');
%         break
%     end
%     
%     values = alTable(first:first+N-1,3); % valores de long de arco
%     firstS=values(1);
%     x_dotdot= b + c*(values - firstS);
%     
%     y_dotdot= e + f*(values - firstS);
%     alTable(first:first+N-1,13)=x_dotdot;
%     alTable(first:first+N-1,14)=y_dotdot;
%     
%     %disp(['first: ', num2str(first)]);
%     %disp(['first+N-1: ',num2str(first+N-1)]);
%     count=count+N;
% end
%     
% 
% for i=1:size(alTable(:,1),1)
%     kappa=sqrt(alTable(i,13)^2 + alTable(i,14)^2);
%     alTable(i,15)=kappa;
% end   
% 
% figure;
% plot(alTable(:,3),alTable(:,15));
% set(gca,'Fontsize',14);
% legend(['curvature, whole evaluation, ', nameIm]);   
% 
% end
