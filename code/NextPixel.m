%Next pixel in a freeman chain
function [xp,yp] = NextPixel(x,y,c)  
if  c==0
  xp=x+1; yp=y;
elseif c==1
	xp=x+1; yp=y+1;
elseif c==2
	xp=x; yp=y+1;
elseif c==3
	xp=x-1; yp=y+1;
elseif c==4
	xp=x-1; yp=y;
elseif c==5
	xp=x-1; yp=y-1;
elseif c==6
	xp=x; yp=y-1;		
elseif c==7
	xp=x+1; yp=y-1;
end
