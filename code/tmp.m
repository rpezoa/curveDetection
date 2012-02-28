
N=8;
omega_N=zeros(1,N);
omega_mag=zeros(1,N);

omega_N2=zeros(1,N);
omega_mag2=zeros(1,N);
k=-13;
for n=1:N
xomega_N(n)=exp(-1j*2*pi*k*(n-1)/N);
omega_mag(n)=abs(omega_N(n));
end


for n=1:N
omega_N2(n)=exp(-1j*2*pi*k*(n-5)/N);
omega_mag2(n)=abs(omega_N(n));
end