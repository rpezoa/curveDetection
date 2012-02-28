function [x] = myInvDFT(X,t)
% x: input signal

disp('Calculating IDFT ::: ');

N = length(X);

x=zeros(1,N);

% the k index indicates the frequency and the i index indicates the
% ith-sample
if t == 0    
    for k=1:N
        for i=1:N
            x(k)= X(i)*exp(1j*2*pi*(k-1)*(i-1)/N) + x(k);
        end        
        x(k)=x(k)/N;
    end
else
    for n=1:N % (indice para el vector de la señal x)
        for m=1:N %(indice para el vector de la frecuencia)
            x(n) = X(m)*exp(1j*2*pi*t(m)*t(n)/N) + x(n);
        end
        x(n)=x(n)/N;
    end
end
    
