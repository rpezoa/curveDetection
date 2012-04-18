disp('Input Signal :::');
N=17;
N_irr=9;
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

subplot(4,1,1);
plot(t,x,'b',t_sub,x_sub,'om',t_irr,x_irr,'xg');
hold on;
%plot(t_sub,x_sub,'om');
title('Input signal');
legend('x(t) reg.','x(t) reg sub.','x(t), irr.');
%plot(t,discreteFourierT)
%plot(t,abs(discreteFourierT))

%%%% rpezoa function %%%%%%
subplot(4,1,2);
plot(t,real(myDiscreteFourierT),'b',t_sub,real(myDiscreteFourierT_sub),'m', t_irr,real(nuDFT),'g');
legend('myDFT reg', 'myDFT sub', 'NUDFT irr');
title('real(DFT)  calculated with myDFT');

%%%% Matlab function %%%%%%%%%%%%%%
subplot(4,1,3);
plot(t,real(discreteFourierT),'b',t_sub,real(discreteFourierT_sub),'r', t_irr,real(nuDFT),'g');
title('Matlab DFT')
legend('DFT reg', 'DFT sub', 'NUDFT irr');

subplot(4,1,4);
plot(0:1:16,real(discreteFourierT),'*b',0:1:16,real(myDiscreteFourierT),'or');
title('Matlab DFT')
legend('fft reg', 'myDFT reg');


figure;
plot(-(N-1)/2:1:(N-1)/2,abs(fftshift(discreteFourierT)),'b',-(N-1)/2:1:(N-1)/2,abs(fftshift(myDiscreteFourierT)),'*r', -4:1:4,abs(fftshift(nuDFT)),'g',-4:1:4, abs(fftshift(discreteFourierT_sub)),'m');
legend('fft reg cent.', 'myDFT reg. cent.','NUDFT  irreg. cent.', 'myDFT sub cent.');

myInvDiscreteFourierT = myInvDFT(myDiscreteFourierT,0);
myInvDiscreteFourierT_sub = myInvDFT(myDiscreteFourierT_sub,0);
invDiscreteFourierT= ifft(discreteFourierT);
invDiscreteFourierT_sub= ifft(discreteFourierT_sub);
invNUDFT = ifft(nuDFT);
%invNUDFT = myInvDFT(nuDFT,-8:2:8);

figure;
plot(-(N-1)/2:1:(N-1)/2,invDiscreteFourierT,'b',-(N-1)/2:1:(N-1)/2,myInvDiscreteFourierT,'r',  -8:2:8,invDiscreteFourierT_sub,'om',  -8:2:8,invNUDFT,'g');
legend('ifft reg', 'myInvDFT reg.', 'ifft sub', 'myInvDFT(NUDFT)');

%nuDFT= nudft(x_irr,t_irr);
%subplot(2,2,4);
%plot(t_irr,real(nuDFT),'r');
%title('NUDFT  calculated with nudft');
%legend('real(NUFDT)');