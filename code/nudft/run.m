disp('Input Signal :::');
%x=[0 1 2 3 4 2 0 2 4 2 0 2 4 3 2 1 0];
x=[1 1 1 1 1];
disp('Time :::');
%t=[-8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8];
t= [ 0 1 2 3 4];



myDiscreteFourierT = myDFT(x,0);
discreteFourierT= fft(x);
subplot(2,2,1);
plot(t,x);
title('Input signal');
legend('x(t), input signal');
%plot(t,discreteFourierT)
%plot(t,abs(discreteFourierT))

subplot(2,2,2);
plot(t,real(myDiscreteFourierT));
legend('myDFT');
title('real(DFT)  calculated with myDFT');


subplot(2,2,3);
plot(t,real(discreteFourierT),'r');
title('DFT  calculated with fft (Matlab)');
legend('real(DFT) (fft Matlab)');

nuDFT= nudft(x,t);
subplot(2,2,4);
plot(t,real(nuDFT),'r');
title('NUDFT  calculated with nudft');
legend('real(NUFDT)');