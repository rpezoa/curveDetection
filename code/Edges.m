% Edges images
function [Magnitud,Angle,mx,my] = Edges(inputimage) 
 
 %kernel
 w=2;                %window=2w+1
 kx=[+1 +1 0 -1 -1
     +2 +2 0 -2 -2
     +2 +2 0 -2 -2
     +2 +2 0 -2 -2
     +1 +1 0 -1 -1];
     
 ky=[+1 +2 +2 +2 +1
     +1 +2 +2 +2 +1
      0  0  0  0  0
     -1 -2 -2 -2 -1
     -1 -2 -2 -2 -1]; 
 
 %image size
 [rows,columns]=size(inputimage); 
 
 %result image
 Magnitud=zeros(rows,columns);
 mx=zeros(rows,columns);
 my=zeros(rows,columns);
 Angle=zeros(rows,columns);
   
  %compute edges
  for x=w+1:columns-w
      for y=w+1:rows-w
        %compute gradient
       m=double(inputimage(y-2:y+2,x-2:x+2)); 
       GradX=sum(sum(m.*kx));  %element by element
       GradY=sum(sum(m.*ky));
       
       %edge vector
       Magnitud(y,x)=sqrt(GradX^2+GradY^2);
       mx(y,x)=GradX;
       my(y,x)=GradY;
       if(GradY~=0)
        Angle(y,x)=atan(GradX/-GradY); %???????????
       else
        Angle(y,x)=1.57; % pi/2
       end
      
      end
  end    
  