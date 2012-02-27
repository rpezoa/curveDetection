disp('Input Signal :::');
x=[0 1 2 3 4 2 0 2 4 2 0 2 4 3 2 1 0];
x_sub=[0 2  4 0 4  0 4 2 0];
x_irr=[0 1 4 0 2 2 3 2 0];
%x=[1 1 1 1 1];
disp('Time :::');
t=[-8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8];
t_sub=[-8 -6 -4 -2 0 2 4 6 8];
t_irr=[-8 -7 -4 -2 -1 1 5 6 8];
%t= [ 0 1 2 3 4];



myDiscreteFourierT = myDFT(x,0);
myDiscreteFourierT_sub = myDFT(x_sub,0);
discreteFourierT= fft(x);
discreteFourierT_sub= fft(x_sub);

nuDFT= nudft(x_irr,t_irr);

subplot(3,1,1);
plot(t,x,'b',t_sub,x_sub,'om',t_irr,x_irr,'xg');
hold on;
%plot(t_sub,x_sub,'om');
title('Input signal');
legend('x(t) reg.','x(t) reg sub.','x(t), irr.');
%plot(t,discreteFourierT)
%plot(t,abs(discreteFourierT))

%%%% rpezoa function %%%%%%
subplot(3,1,2);
plot(t,real(myDiscreteFourierT),'b',t_sub,real(myDiscreteFourierT_sub),'m', t_irr,real(nuDFT),'g');
legend('myDFT reg', 'myDFT sub', 'NUDFT irr');
title('real(DFT)  calculated with myDFT');

%%%% Matlab function %%%%%%%%%%%%%%
subplot(3,1,3);
plot(t,real(discreteFourierT),'b',t_sub,real(discreteFourierT_sub),'r', t_irr,real(nuDFT),'g');
title('Matlab DFT')
legend('DFT reg', 'DFT sub', 'NUDFT irr');


figure;
plot(real(discreteFourierT),'b');
figure;

figure;
plot(t,real(myDiscreteFourierT),'m');
legend('real');


figure;
plot(t,abs(myDiscreteFourierT),'g');

%nuDFT= nudft(x_irr,t_irr);
%subplot(2,2,4);
%plot(t_irr,real(nuDFT),'r');
%title('NUDFT  calculated with nudft');
%legend('real(NUFDT)');