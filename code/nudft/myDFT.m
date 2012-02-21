function [X] = myDFT(x,t)
% x: input signal

disp('Calculating DFT ::: ');

N = length(x);

X=zeros(1,N);



% the k index indicates the frequency and the i index indicates the
% ith-sample
if t == 0
    
    for k=1:N
        for i=1:N
            X(k)= x(i)* exp(-1j*2*pi*(k-1)*(i-1)/N) + X(k)
        end
        X(k)=X(k)/N;
    end
else
    for k=1:N
        for i=1:N
            X(k)= x(i)* exp(-1j*2*pi*(t(k))*(i-1)/N) + X(k);
        end
        X(k)=X(k)/N;
    end
end
    
