function [x_fila, y_columna,plantilla] = generateTemplate(px,py,epsilon)

x_fila=zeros(1,8*epsilon);
y_columna=zeros(1,8*epsilon);

% right-vertical line
for i=1:epsilon+1
    x_fila(i)=px-i+1;
    y_columna(i)=py+epsilon;
    
end


% up-horizontal line
pos=0;
for i=1:2*epsilon
    x_fila(i+epsilon+1)=px-epsilon;
    y_columna(i+epsilon+1)=py+epsilon-i;
    pos=i+epsilon+1;
end


% left-vertical line
posF=0;
for i=1:2*epsilon
    x_fila(i+pos)=px-epsilon+i;
    y_columna(i+pos)=py-epsilon;
    posF=i+pos;
end
%disp(['PosF ::: ', num2str(posF)]);
    
% bottom-horizontal line
posE=0;
for i=1:(2*epsilon)
    %disp(['-->', num2str(i+posF)])
    x_fila(i+posF)=px+epsilon;
    y_columna(i+posF)=py-epsilon+i;
    posE=i+posF;
    
end



for i=1:epsilon-1
    %disp(['-->', num2str(i+posE)])
    x_fila(i+posE)=px+epsilon-i;
    y_columna(i+posE)=py+epsilon;    
end


d=size(x_fila,2);
A=zeros((epsilon*2)+1);

for i=1:d
    A(x_fila(i),y_columna(i))=1;
    %plot(y_columna(i),x_fila(i))
    %hold on;
end

plantilla = A;
    


    
