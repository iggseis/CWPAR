function butttonDownFcn(src,event)
pt = get(gca,'CurrentPoint');
x = pt(1,1);
y = pt(1,2);
fprintf('%f \n',floor(x+0.5));