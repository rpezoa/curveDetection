function [X] = myDFT(x,t)
% x: input signal
% t: vector of time
disp('Calculating DFT ::: ');

N = length(x);

X=zeros(1,N);



% the k index indicates the frequency and the i index indicates the
% ith-sample
if t == 0
    for k=1:N
        for i=1:N
            X(k)= x(i)* exp(-1j*2*pi*(k-1)*(i-1)/N) + X(k);
        end
        %X(k)=X(k);
    end
else
    for k=1:N
        for i=1:N % fijo el k
            X(k)= x(i)* exp(-1j*2*pi*(t(k))*t(i)/N) + X(k);
        end
        %X(k)=X(k)/N;        
    end
end
    
omega_N=zeros(1,N);

for k=1:N
    for n=1:N
    omega_N(n)=exp(-1j*2*pi*k*(n-1)/N);
    end
end
