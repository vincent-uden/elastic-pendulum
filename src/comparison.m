real_data = readmatrix("../CSV Data/E/E3_mass.csv");
orig_data = readmatrix("../CSV Data/E/E3_origin.csv");

origin = mean(orig_data, 1) + [-24.0504, -10.9529, -15.1941];

real_data = real_data - origin;
real_data = real_data * 0.001;
real_data = real_data(5000:10000,:);


x0 = real_data(2,1);
y0 = real_data(2,2);
z0 = real_data(2,3);

x_dot0 = (real_data(3,1) - real_data(1,1)) / 0.02;
y_dot0 = (real_data(3,2) - real_data(1,2)) / 0.02;
z_dot0 = (real_data(3,3) - real_data(1,3)) / 0.02;
odeset('RelTol', 1e-3, 'AbsTol', 1e-6);
[t,y] = ode45(@eulerllagrange, 0:0.01:400, [x0, x_dot0, y0, y_dot0, z0, z_dot0]);

hold off
plot3(real_data(:,1), real_data(:,2), real_data(:,3));
hold on
plot3(y(:,1), y(:,3), y(:,5));
plot3(y(1,1), y(1,3), y(1,5), 'or');
axis([-0.2, 0.2, -0.2, 0.2, -1 0, 0.4])