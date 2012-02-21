function [X] = nudft(x,t)
% x: input signal

N = length(x);

X=zeros(1,N);

if t == 0
    for i=1:N
        t(i)=i-1;
    end
end


% the k index indicates the frequency and the i index indicates the
% ith-sample

T=t(N);
deltaK=2*pi/T;

for k=1:N
    for i=1:N
        X(k)= x(i)* exp(-1j*(k-1)*deltaK*t(i)) + X(k);
    end
    X(k)=X(k)/N;
end