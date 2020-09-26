fake = readmatrix("fake.csv");
real = readmatrix("real.csv");

offset = mean(real - fake, 1)/1000;