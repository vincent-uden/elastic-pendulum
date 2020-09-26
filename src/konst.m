vel = readmatrix("springconst_vel.csv");

diffs = [];
dt = 0.01;

pos = sign(vel(2,1));
last_t = 2;

for i = 3:size(vel,1)
    z_vel = vel(i,3);
    if sign(z_vel) ~= pos
        diffs(length(diffs)+1) = i - last_t;
        last_t = i;
        pos = sign(z_vel);
    end
end

diffs = diffs(1:length(diffs)-1);

period = mean(diffs) * dt * 2;
k = 4*pi^2*0.5311/(period^2)