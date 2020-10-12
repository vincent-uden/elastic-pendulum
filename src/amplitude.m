real_data = readmatrix("../CSV Data/I/I6_pos.csv");
orig_data = readmatrix("../CSV Data/I/origin_pos.csv");

%I6, I10

origin = mean(orig_data, 1) + [-24.0504, -10.9529, -15.1941];

real_data = real_data - origin;
real_data = real_data * 0.001;
real_data = real_data(500:6000,1:2);

norm = sqrt(sum(real_data.^2,2));

hold off
plot(1:size(norm(1:1000)),norm(1:1000));

hold on
plot(4501:5501,norm(end-1000:end));

amp_start = mean(norm(1:1000));
amp_end = mean(norm(end-1000:end));

loss = 1- amp_end/amp_start