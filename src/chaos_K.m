orig_data = readmatrix("../CSV Data/K/K1_origin_pos.csv");
origin = mean(orig_data, 1) + [-24.0504, -10.9529, -15.1941];

paths = dir("../CSV Data/K/K*_pos.csv");
time = 50;
t0 = 200;
absolute_errors = zeros(time * 100 + 1, 3, size(paths, 1));

real_output = zeros(time * 100 + 1, 3, size(paths, 1));
fake_output = zeros(time * 100 + 1, 3, size(paths, 1));

hold off
S = zeros(10,3);
std_start = zeros(10,3);
std_end = zeros(10,3);
% Do not include K11, K13, K16, K12, K7, K10, K8, K18, K19, K20
for p = [1,2,4:6,9,15]
    
    real_data = readmatrix(strcat("../CSV Data/K/", paths(p).name));
    real_data = real_data - origin;
    real_data = real_data * 0.001;
    real_data = real_data(t0:(t0 + time * 100),:);
    x0 = real_data(2,1);
    y0 = real_data(2,2);
    z0 = real_data(2,3);

    x_dot0 = (real_data(3,1) - real_data(1,1)) / 0.02;
    y_dot0 = (real_data(3,2) - real_data(1,2)) / 0.02;
    z_dot0 = (real_data(3,3) - real_data(1,3)) / 0.02;
    odeset('RelTol', 1e-3, 'AbsTol', 1e-6);
    [t,y] = ode45(@eulerllagrange, 0:0.01:time, [x0, x_dot0, y0, y_dot0, z0, z_dot0]);
  
    real_output(:,:,p) = real_data;
    fake_output(:,:,p) = horzcat(y(:,1), y(:,3), y(:,5));
    
    % ALBOS ÖVNING PÅ ATT SUMMERA SAKER
    %sum = zeros(5001,3);
    %
    %for i = 1:length(paths)
    %    sum = sum + real_output(:,:,i);
    %end
    %
    %sum = sum./length(paths);
    % SLUT PÅ ALBOS ÖVNING I ATT SUMMERA SAKER
    
    % Standard deviation of the curves
    S(p,:) = std(real_output(:,:,p));
    
    real_output_start = real_output(1:10,:,:);
    real_output_end = real_output(end-10:end,:,:);
    
    %std_start(p,:) = std(real_output_start(:,:,p));
    %std_end(p,:) = std(real_output_end(:,:,p)); 
    
    %diff_std = std_end - std_start;
    
    %{
    plot3(real_output(1,1,p), real_output(1,2,p), real_output(1,3,p), 'or');
    plot3(real_output(end,1,p), real_output(end,2,p), real_output(end,3,p), 'og');
    plot3(real_output(1:10,1,p), real_output(1:10,2,p), real_output(1:10,3,p), 'color', rand(1,3));
    plot3(real_output(end-10:end,1,p), real_output(end-10:end,2,p), real_output(end-10:end,3,p), 'color', rand(1,3));
    %plot3(real_output(:,1,p), real_output(:,2,p), real_output(:,3,p), 'color', rand(1,3));
    hold on
    % plot3(fake_output(:,1,p), fake_output(:,2,p), fake_output(:,3,p), 'color', rand(1,3));
    %}
    
    % Pictures for paper
    
    subplot(1,2,1)
    grid on
    box on
    axis([-0.2 0.4 -0.39 -0.34])
    xlabel('Position i x-led (m)')
    ylabel('Position i z-led (m)')
    hold on
    plot(real_output(1:10,1,p),real_output(1:10,3,p), 'color', 'b')
    plot(real_output(end-10:end,1,p),real_output(end-10:end,3,p),'color','r')
    subplot(1,2,2)
    grid on
    box on
    axis([-0.2 0.4 -0.39 -0.34])
    xlabel('Position i y-led (m)')
    ylabel('Position i z-led (m)')
    
    plot(real_output(1:10,2,p),real_output(1:10,3,p),'color', 'b')
    hold on
    plot(real_output(end-10:end,2,p),real_output(end-10:end,3,p),'color','r')
   
end

% Removes empty measurements
d = 1;
for k = 1:21
    sum = 0;
    for i = 1:size(real_output,1)
        for j = 1:size(real_output,2)
            sum = sum + real_output(i,j,k);
        end
    end
    if sum ~= 0
        useful_data(:,:,d) = real_output(:,:,k);
        d = d+1;
    end
end
%Calculates standard deviation along the third axis
stand_dev = std(useful_data,0,3);

stand_dev_start = stand_dev(10:20,:);
stand_dev_end = stand_dev(end-10:end,:);
%diff_stand_dev = stand_dev_end - stand_dev_start

vel_start = diff(useful_data(10:20,:,:));
vel_end = diff(useful_data(end-10:end,:,:));

stand_dev_vel_start = std(vel_start,0,3)./mean(vel_start,3);
stand_dev_vel_end = std(vel_end,0,3)./mean(vel_end,3);

mean_start = mean(stand_dev_start,1)
mean_end = mean(stand_dev_end,1)
norm_mean_start = norm(mean(stand_dev_start,1))
norm_mean_end = norm(mean(stand_dev_end,1))

mean_vel_start = mean(stand_dev_vel_start,1)
mean_vel_end = mean(stand_dev_vel_end,1)
norm_mean_vel_start = norm(mean_vel_start)
norm_mean_vel_end = norm(mean_vel_end)