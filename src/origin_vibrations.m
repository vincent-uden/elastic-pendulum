oE = readmatrix("../CSV Data/E/E10_origin.csv");
oF = readmatrix("../CSV Data/F/origin.csv");
oG = readmatrix("../CSV Data/G/origin_pos.csv");
oH = readmatrix("../CSV Data/H/origin_pos.csv");
oI = readmatrix("../CSV Data/I/origin_pos.csv");
oJ = readmatrix("../CSV Data/J/J1_origin_pos.csv");
oK = readmatrix("../CSV Data/K/K1_origin_pos.csv");
oL = readmatrix("../CSV Data/L/L1_origin_pos.csv");

origins = [];
origins(1,:,:) = oE(1:6000,:);
origins(2,:,:) = oF(1:6000,:);
origins(3,:,:) = oG(1:6000,:);
origins(4,:,:) = oH(1:6000,:);
origins(5,:,:) = oI(1:6000,:);
origins(6,:,:) = oJ(1:6000,:);
origins(7,:,:) = oK(1:6000,:);
origins(7,:,:) = oL(1:6000,:);

biggest = squeeze(max(origins,[],2));
smallest = squeeze(min(origins,[],2));
diff = biggest - smallest;

hold off
plot3(oE(:,1), oE(:,2), oE(:,3));
hold on
axis equal
grid on
plot3(oF(:,1), oF(:,2), oF(:,3));
plot3(oG(:,1), oG(:,2), oG(:,3));
plot3(oH(:,1), oH(:,2), oH(:,3));
plot3(oI(:,1), oI(:,2), oI(:,3));
plot3(oJ(:,1), oJ(:,2), oJ(:,3));
plot3(oK(:,1), oK(:,2), oK(:,3));
plot3(oL(:,1), oL(:,2), oL(:,3));

legend([ "E", "F", "G", "H", "I", "J", "K", "L" ]);
