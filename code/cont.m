%Compute continous pixels
function Next = cont(Mag,Ang)  

%image size
	[rows,columns]=size(Mag);

%Next connected pixels
	Next=-1*ones(rows,columns,2); % two continuos pixels
	

  for x=2:columns-1
      for y=2:rows-1
         if Mag(y,x)>0
         		t=Ang(y,x); 
         		if t<.57 && t>-.57
         		
         		   % max 7,0,1
         		   if Mag(y-1,x+1)>Mag(y,x+1) && Mag(y-1,x+1)>Mag(y+1,x+1)
         		   		Next(y,x,1)=7;
         		   elseif Mag(y,x+1)>Mag(y+1,x)
         		   	  Next(y,x,1)=0;
         		   else
         		   	  Next(y,x,1)=1;
         		   end  
         		   
         		   % max 3,4,5
         		   if Mag(y+1,x-1)>Mag(y,x-1) && Mag(y+1,x-1)>Mag(y-1,x-1)
         		   		Next(y,x,2)=3;
         		   elseif Mag(y,x-1)>Mag(y-1,x)
         		   	  Next(y,x,2)=4;
         		   else
         		   	  Next(y,x,2)=5;
         		   end  
         		   
         		elseif t>1.04 || t<-1.04
         		   
         		   % max 1,2,3
         		   if Mag(y+1,x+1)>Mag(y+1,x) && Mag(y+1,x+1)>Mag(y+1,x-1)
         		    	Next(y,x,1)=1;
         		   elseif Mag(y+1,x)>Mag(y+1,x-1)
         		   	  Next(y,x,1)=2;
         		   else
         		   	  Next(y,x,1)=3;
         		   end
         		   
         		   % max 5,6,7
         		   if Mag(y-1,x-1)>Mag(y-1,x) && Mag(y-1,x-1)>Mag(y-1,x+1)
         		   		Next(y,x,2)=5;
         		   elseif Mag(y-1,x)>Mag(y-1,x+1)
         		   	  Next(y,x,2)=6;
         		   else
         		   	  Next(y,x,2)=7;
         		   end
         		   	  
         		elseif t>.57
         		   % max 0,1,2
         		   if Mag(y,x+1)>Mag(y+1,x+1) && Mag(y,x+1)>Mag(y+1,x)
         		   		Next(y,x,1)=0;
         		   elseif Mag(y+1,x+1)>Mag(y+1,x)
         		   	  Next(y,x,1)=1;
         		   else
         		   	  Next(y,x,1)=2;
         		   end
        
         		      	
         		   % max 4,5,6 
         		   if Mag(y,x-1)>Mag(y-1,x-1) && Mag(y,x-1)>Mag(y-1,x)
         		   		Next(y,x,2)=4;
         		   elseif Mag(y-1,x-1)>Mag(y-1,x)
         		   	  Next(y,x,2)=5;
         		   else
         		   	  Next(y,x,2)=6;
         		   end
         		      	
         		 else
         		   % max 6,7,0
         		   if Mag(y-1,x)>Mag(y-1,x+1) && Mag(y-1,x)>Mag(y,x+1)
         		   		Next(y,x,1)=6;
         		   elseif Mag(y-1,x+1)>Mag(y,x+1)
         		   	  Next(y,x,1)=7;
         		   else
         		   	  Next(y,x,1)=0;
         		   end
        		        
         		   %max 2,3,4
         		   if Mag(y+1,x)>Mag(y+1,x-1) && Mag(y+1,x)>Mag(y,x-1)
         		   		Next(y,x,2)=2;
         		   elseif Mag(y+1,x-1)>Mag(y,x-1)
         		   	  Next(y,x,2)=3;
         		   else
         		   	  Next(y,x,2)=4;
         		   end
         		   		
         		end         
          end	
       end
   end    
        
   % only if point to the same     
	 for x=2:columns-1
      for y=2:rows-1
         if Mag(y,x)>0
             for i=1:2
               if Next(y,x,i)~=-1
                 [xp,yp]=NextPixel(x,y,Next(y,x,i));
                 j=rem(Next(y,x,i)+4,8);
                 if Next(yp,xp,1)~=j &&	Next(yp,xp,2)~=j
                		Next(y,x,i)=-1;
                 end
                end   		
             end
          end
       end
   end            
          
           
         
         
         
         
