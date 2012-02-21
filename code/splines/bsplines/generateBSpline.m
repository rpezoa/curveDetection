function [sp0,alTable] = generateBSpline(alTable)
misX=alTable(:,3);
misX=misX';
mis_knots= augknt(misX,1);
%spap2(mis_knots,4,alTable(:,3),alTable(:,1));
sp0=spap2(mis_knots,4,alTable(:,3),alTable(:,1))





