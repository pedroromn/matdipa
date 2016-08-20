f = ones(64,1);
f = f./sum(f);

g = conv(f,f);
g = g ./ sum(g);

h = conv(g,g);
h = h ./ sum(h);

j = conv(h,h);
j = j ./ sum(j);

subplot(2,2,1), plot(f,'k '); axis square;
axis off;

subplot(2,2,2), plot(g,'k '); axis square;
axis off;

subplot(2,2,3), plot(h,'k '); axis square;
axis off;

subplot(2,2,4), plot(j,'k '); axis square;
axis off;