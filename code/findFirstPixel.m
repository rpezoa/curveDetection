function [px,py,firstPix]=findFirstPixel(im,t)
[rows,columns]=size(im);
for x=1:rows
    for y=1:columns %si la intensidad esta bajo el threshold
        if im(x,y)<=t;
            firstPix=im(x,y);
            px=x;
            py=y;
            return
        end
        
    end
end
end