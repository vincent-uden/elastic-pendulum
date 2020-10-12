real_data = readmatrix("../CSV Data/I/I13_pos.csv");
orig_data = readmatrix("../CSV Data/I/origin_pos.csv");

origin = mean(orig_data, 1) + [-24.0504, -10.9529, -15.1941];

real_data = real_data - origin;
real_data = real_data * 0.001;
real_data = real_data(500:6000,:);

x0 = real_data(2,1);
y0 = real_data(2,2);
z0 = real_data(2,3);

x_dot0 = (real_data(3,1) - real_data(1,1)) / 0.02;
y_dot0 = (real_data(3,2) - real_data(1,2)) / 0.02;
z_dot0 = (real_data(3,3) - real_data(1,3)) / 0.02;
odeset('RelTol', 1e-3, 'AbsTol', 1e-6);
[t,y] = ode45(@eulerllagrange, 0:0.01:55, [x0, x_dot0, y0, y_dot0, z0, z_dot0]);

t0 = 1;
t_end = 5000;

hold off
plot3(real_data(t0:t_end,1), real_data(t0:t_end,2), real_data(t0:t_end,3));
grid on
axis([-0.32, 0.32, -0.32, 0.32, -0.5, 0])
xlabel("X position (m)");
ylabel("Y position (m)");
zlabel("Z position (m)");
