orig_data = readmatrix("../CSV Data/L/L1_origin_pos.csv");
origin = mean(orig_data, 1) + [-24.0504, -10.9529, -15.1941];

paths = dir("../CSV Data/L/L*_pos.csv");
time = 50;
t0 = 200;
absolute_errors = zeros(time * 100 + 1, 3, size(paths, 1));

real_output = zeros(time * 100 + 1, 3, size(paths, 1));
fake_output = zeros(time * 100 + 1, 3, size(paths, 1));

hold off
% Do not use L11, 
for p = [1:10,12:20]
    real_data = readmatrix(strcat("../CSV Data/L/", paths(p).name));
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
    
    real_output_start = real_output(1:10,:,:);
    real_output_end = real_output(end-10:end,:,:);
    
    
    plot3(real_output(1,1,p), real_output(1,2,p), real_output(1,3,p), 'or');
    plot3(real_output(end,1,p), real_output(end,2,p), real_output(end,3,p), 'og');
    plot3(real_output(1:1000,1,p), real_output(1:1000,2,p), real_output(1:1000,3,p), 'color', rand(1,3));
    %plot3(real_output(end-10:end,1,p), real_output(end-10:end,2,p), real_output(end-10:end,3,p), 'color', rand(1,3));
    %tt = 100;
    %plot3(real_output(:,1,p), real_output(:,2,p), real_output(:,3,p), 'color', rand(1,3));
    hold on
    % plot3(fake_output(:,1,p), fake_output(:,2,p), fake_output(:,3,p), 'color', rand(1,3));
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
stand_dev = std(useful_data, 0, 3);

stand_dev_start = stand_dev(1:20,:);
stand_dev_end = stand_dev(end-19:end,3);
diff_stand_dev = stand_dev_end - stand_dev_start

summationvec = 0;
for i = length(diff_stand_dev)
    summationvec = summationvec + diff_stand_dev(i,:);    
end
summationvec
%Gives negative diff. That would mean that the points at the end are closer
%together in the end compared to the start 

% OBS: Inget är gjort för hastigheten än