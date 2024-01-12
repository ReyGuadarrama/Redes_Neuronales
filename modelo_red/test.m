
x = linspace(-1, 1, 100);
n1 = max(-0.8665*x + 0.8030, 0);
n2 = max(-0.4218*x, 0);
n1_1 = -0.9427 * max(0, n1);
n2_1 = 1.3419 * max(0, n2);
figure;
plot(x, max(0, n1), LineWidth=3);
hold on
plot(x, max(0, n2), LineWidth=3);
hold off
xlim([-1.2, 1.2]), ylim([-0.2, 1]);