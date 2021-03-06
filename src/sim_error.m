orig_data = readmatrix("../CSV Data/I/origin_pos.csv");
origin = mean(orig_data, 1) + [-24.0504, -10.9529, -15.1941];

paths = dir("../CSV Data/I/I*_pos.csv");
time = 70;
t0 = 50;
absolute_errors = zeros(time * 100 + 1, 3, size(paths, 1));

real_output = zeros(time * 100 + 1, 3, size(paths, 1));
fake_output = zeros(time * 100 + 1, 3, size(paths, 1));

for p = 1:size(paths, 1)
    real_data = readmatrix(strcat("../CSV Data/I/", paths(p).name));
    real_data = real_data - origin;
    real_data = real_data * 0.001;
    real_data = real_data(t0:t0 + time * 100,:);
    x0 = real_data(2,1);
    y0 = real_data(2,2);
    z0 = real_data(2,3);

    x_dot0 = (real_data(3,1) - real_data(1,1)) / 0.02;
    y_dot0 = (real_data(3,2) - real_data(1,2)) / 0.02;
    z_dot0 = (real_data(3,3) - real_data(1,3)) / 0.02;
    odeset('RelTol', 1e-3, 'AbsTol', 1e-6);
    [t,y] = ode45(@eulerllagrange, 0:0.01:time, [x0, x_dot0, y0, y_dot0, z0, z_dot0]);
    
    diffs = abs(real_data - horzcat(y(:,1), y(:,3), y(:,5)));
    absolute_errors(:, :, p) = reshape(diffs, 1, size(diffs,1), size(diffs,2));
    
    real_output(:,:,p) = real_data;
    fake_output(:,:,p) = horzcat(y(:,1), y(:,3), y(:,5));
end

err_mean = squeeze(mean(absolute_errors, [1, 2]));
err_std = squeeze(std(absolute_errors(:,:,:)));
err_norm = zeros(time * 100 +1, size(paths, 1));

real_mag = zeros(time * 100 +1, size(paths, 1));

for i = 1:size(paths, 1)
    for t = 1:time * 100 + 1
        err_norm(t, i) = norm(absolute_errors(t,:,i));
        real_mag(t,i) = norm(real_output(t,:,i));
    end
end

figure
hold off
subplot(2,2,1);
scatter(real_mag(:,4), err_norm(:,4), '.');
xlabel("Position Magnitude");
ylabel("Norm of error");
grid on
subplot(2,2,2);
scatter(real_output(:,1,4), err_norm(:,4), '.');
xlabel("Position X");
ylabel("Norm of error");
grid on
subplot(2,2,3);
scatter(real_output(:,2,4), err_norm(:,4), '.');
xlabel("Position Y");
ylabel("Norm of error");
grid on
subplot(2,2,4);
scatter(real_output(:,3,4), err_norm(:,4), '.');
xlabel("Position Z");
ylabel("Norm of error");
grid on

figure
subplot(3,3,1);
scatter(real_output(:,1,4), absolute_errors(:,1,4),".");
xlabel("X");
ylabel("X");
grid on
subplot(3,3,2);
scatter(real_output(:,1,4), absolute_errors(:,2,4),".");
xlabel("X");
ylabel("Y");
grid on
subplot(3,3,3);
scatter(real_output(:,1,4), absolute_errors(:,3,4),".");
xlabel("X");
ylabel("Z");
grid on
subplot(3,3,4);
scatter(real_output(:,2,4), absolute_errors(:,1,4),".");
xlabel("Y");
ylabel("X");
grid on
subplot(3,3,5);
scatter(real_output(:,2,4), absolute_errors(:,2,4),".");
xlabel("Y");
ylabel("Y");
grid on
subplot(3,3,6);
scatter(real_output(:,2,4), absolute_errors(:,3,4),".");
xlabel("Y");
ylabel("Z");
grid on
subplot(3,3,7);
scatter(real_output(:,3,4), absolute_errors(:,1,4),".");
xlabel("Z");
ylabel("X");
grid on
subplot(3,3,8);
scatter(real_output(:,3,4), absolute_errors(:,2,4),".");
xlabel("Z");
ylabel("Y");
grid on
subplot(3,3,9);
scatter(real_output(:,3,4), absolute_errors(:,3,4),".");
xlabel("Z");
ylabel("Z");
grid on

