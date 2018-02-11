%% plots_rollobserver
close all;
figure;
plot(tout,y,tout,sin(tout));
xlabel('tout')
ylabel('output and reference')


figure; 
plot(tout,sin(tout)-y)
xlabel('tout')
ylabel('error')

figure;
plot(tout,d+dhat)
xlabel('tout')
ylabel('error disturbance')

figure
subplot(2,1,1)
plot(tout,d)
xlabel('tout')
ylabel('d')
subplot(2,1,2)
plot(tout,dhat)
xlabel('tout')
ylabel('dhat')