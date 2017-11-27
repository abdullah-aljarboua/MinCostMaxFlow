clear all, close all, clc
format long eng
num_samples = 5;

%%
%{
    Theoretical Timing
%}
m = [256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072, 262144];
n = [1024, 2048, 4096, 8192, 16384, 32768, 65536, 131072, 262144, 524288, 1048576];
U = 10;
C = 100;
MaxFlow = [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 2000];
alg_1_theoretical = zeros(length(m), 1);
alg_2_theoretical = zeros(length(m), 1);
for i = 1:length(m)
	alg_1_theoretical(i) = m(i)^2 * n(i) * U * C;
	alg_2_theoretical(i) = m(i) * n(i) * MaxFlow(i);
end
%%

alg_1_noOptimization = [[256,1024,56285,43];[256,1024,11281,31];[256,1024,17966,35];[256,1024,17426,29];[256,1024,8768,26];[512,2048,248383,146];[512,2048,75385,116];[512,2048,17226,68];[512,2048,137308,114];[512,2048,47571,93];[1024,4096,177410,300];[1024,4096,78745,191];[1024,4096,260354,315];[1024,4096,194324,281];[1024,4096,52631,192];[2048,8192,42087,452];[2048,8192,791493,1043];[2048,8192,839115,1091];[2048,8192,288943,870];[2048,8192,268470,565];[4096,16384,1523828,2037];[4096,16384,652237,2271];[4096,16384,1081065,2292];[4096,16384,364661,1639];[4096,16384,1822,384];[8192,32768,669695,4326];[8192,32768,212244,3185];[8192,32768,1263716,4742];[8192,32768,538260,4376];[8192,32768,630552,4318];[16384,65536,1015558,11535];[16384,65536,968397,8545];[16384,65536,800764,11406];[16384,65536,9209,2490];[16384,65536,769518,11560];[32768,131072,47249,14374];[32768,131072,1077713,30284];[32768,131072,2965992,34128];[32768,131072,1557301,32327];[32768,131072,549368,18916];[65536,262144,412117,62114];[65536,262144,1437544,71034];[65536,262144,1144968,53541];[65536,262144,2356955,83662];[65536,262144,1327353,64600];[131072,524288,1760186,210254];[131072,524288,2849928,213252];[131072,524288,643173,132784];[131072,524288,1739206,137334];[131072,524288,1383905,206129];[262144,1048576,12797633,941430];[262144,1048576,7720105,904840];[262144,1048576,6062946,915442];[262144,1048576,5175257,675437];[262144,1048576,10735360,696506]];
alg_1_noOptimization_ave = zeros(length(alg_1_noOptimization)/num_samples, 1);
for i = 1:length(alg_1_noOptimization)/num_samples
	% Converting from milliseconds to seconds
    alg_1_noOptimization_ave(i) = mean(alg_1_noOptimization((i-1)*num_samples+1:i*num_samples, 4)) * 1000;
end


alg_1_Ofast = [[256,1024,56285,7];[256,1024,11281,5];[256,1024,17966,6];[256,1024,17426,4];[256,1024,8768,4];[512,2048,248383,24];[512,2048,75385,20];[512,2048,17226,12];[512,2048,137308,19];[512,2048,47571,17];[1024,4096,177410,52];[1024,4096,78745,36];[1024,4096,260354,54];[1024,4096,194324,53];[1024,4096,52631,38];[2048,8192,42087,97];[2048,8192,791493,196];[2048,8192,839115,215];[2048,8192,288943,174];[2048,8192,268470,122];[4096,16384,1523828,447];[4096,16384,652237,523];[4096,16384,1081065,529];[4096,16384,364661,391];[4096,16384,1822,92];[8192,32768,669695,1183];[8192,32768,212244,878];[8192,32768,1263716,1238];[8192,32768,538260,1176];[8192,32768,630552,1175];[16384,65536,1015558,3203];[16384,65536,968397,2268];[16384,65536,800764,3313];[16384,65536,9209,765];[16384,65536,769518,3315];[32768,131072,47249,4494];[32768,131072,1077713,9127];[32768,131072,2965992,9750];[32768,131072,1557301,9423];[32768,131072,549368,5953];[65536,262144,412117,20323];[65536,262144,1437544,22523];[65536,262144,1144968,17404];[65536,262144,2356955,27534];[65536,262144,1327353,21019];[131072,524288,1760186,77982];[131072,524288,2849928,77091];[131072,524288,643173,50472];[131072,524288,1739206,51698];[131072,524288,1383905,76718];[262144,1048576,12797633,381662];[262144,1048576,7720105,369615];[262144,1048576,6062946,369183];[262144,1048576,5175257,307099];[262144,1048576,10735360,325940]];
alg_1_Ofast_ave = zeros(length(alg_1_Ofast)/num_samples, 1);
for i = 1:length(alg_1_Ofast)/num_samples
    alg_1_Ofast_ave(i) = mean(alg_1_Ofast((i-1)*num_samples+1:i*num_samples, 4)) * 1000;
end


alg_1_O3 = [[256,1024,56285,6];[256,1024,11281,5];[256,1024,17966,5];[256,1024,17426,4];[256,1024,8768,4];[512,2048,248383,23];[512,2048,75385,19];[512,2048,17226,12];[512,2048,137308,18];[512,2048,47571,16];[1024,4096,177410,50];[1024,4096,78745,35];[1024,4096,260354,52];[1024,4096,194324,52];[1024,4096,52631,37];[2048,8192,42087,92];[2048,8192,791493,187];[2048,8192,839115,206];[2048,8192,288943,168];[2048,8192,268470,117];[4096,16384,1523828,427];[4096,16384,652237,497];[4096,16384,1081065,500];[4096,16384,364661,373];[4096,16384,1822,87];[8192,32768,669695,1119];[8192,32768,212244,834];[8192,32768,1263716,1170];[8192,32768,538260,1111];[8192,32768,630552,1117];[16384,65536,1015558,3158];[16384,65536,968397,2411];[16384,65536,800764,3146];[16384,65536,9209,723];[16384,65536,769518,3158];[32768,131072,47249,4272];[32768,131072,1077713,8724];[32768,131072,2965992,9303];[32768,131072,1557301,8977];[32768,131072,549368,5685];[65536,262144,412117,19443];[65536,262144,1437544,21693];[65536,262144,1144968,16933];[65536,262144,2356955,26287];[65536,262144,1327353,19982];[131072,524288,1760186,75627];[131072,524288,2849928,74526];[131072,524288,643173,48627];[131072,524288,1739206,50075];[131072,524288,1383905,74179];[262144,1048576,12797633,368961];[262144,1048576,7720105,359624];[262144,1048576,6062946,360067];[262144,1048576,5175257,270230];[262144,1048576,10735360,277843]];
alg_1_O3_ave = zeros(length(alg_1_O3)/num_samples, 1);
for i = 1:length(alg_1_O3)/num_samples
    alg_1_O3_ave(i) = mean(alg_1_O3((i-1)*num_samples+1:i*num_samples, 4)) * 1000;
end


alg_2_noOptimization = [[256,1024,56285,5];[256,1024,11281,1];[256,1024,17966,1];[256,1024,17426,1];[256,1024,8768,0];[512,2048,248383,42];[512,2048,75385,13];[512,2048,17226,3];[512,2048,137308,24];[512,2048,47571,14];[1024,4096,177410,79];[1024,4096,78745,48];[1024,4096,260354,102];[1024,4096,194324,91];[1024,4096,52631,24];[2048,8192,42087,62];[2048,8192,791493,633];[2048,8192,839115,623];[2048,8192,288943,304];[2048,8192,268470,294];[4096,16384,1523828,2333];[4096,16384,652237,1379];[4096,16384,1081065,2042];[4096,16384,364661,1062];[4096,16384,1822,8];[8192,32768,669695,2837];[8192,32768,212244,1344];[8192,32768,1263716,4616];[8192,32768,538260,2804];[8192,32768,630552,3031];[16384,65536,1015558,8303];[16384,65536,968397,8381];[16384,65536,800764,7993];[16384,65536,9209,100];[16384,65536,769518,7753];[32768,131072,47249,1765];[32768,131072,1077713,21426];[32768,131072,2965992,40564];[32768,131072,1557301,24889];[32768,131072,549368,12288];[65536,262144,412117,31206];[65536,262144,1437544,61532];[65536,262144,1144968,58455];[65536,262144,2356955,86570];[65536,262144,1327353,63004];[131072,524288,1760186,257126];[131072,524288,2849928,316837];[131072,524288,643173,113504];[131072,524288,1739206,244602];[131072,524288,1383905,226238];[262144,1048576,12797633,2524814];[262144,1048576,7720105,1911320];[262144,1048576,6062946,1754705];[262144,1048576,5175257,1709149];[262144,1048576,10735360,2541797]];
alg_2_noOptimization_ave = zeros(length(alg_2_noOptimization)/num_samples, 1);
for i = 1:length(alg_2_noOptimization)/num_samples
    alg_2_noOptimization_ave(i) = mean(alg_2_noOptimization((i-1)*num_samples+1:i*num_samples, 4)) * 1000;
end


alg_2_O3 = [[256,1024,56285,2];[256,1024,11281,0];[256,1024,17966,0];[256,1024,17426,0];[256,1024,8768,0];[512,2048,248383,20];[512,2048,75385,6];[512,2048,17226,1];[512,2048,137308,12];[512,2048,47571,6];[1024,4096,177410,39];[1024,4096,78745,24];[1024,4096,260354,51];[1024,4096,194324,45];[1024,4096,52631,12];[2048,8192,42087,35];[2048,8192,791493,352];[2048,8192,839115,358];[2048,8192,288943,172];[2048,8192,268470,164];[4096,16384,1523828,1435];[4096,16384,652237,854];[4096,16384,1081065,1232];[4096,16384,364661,643];[4096,16384,1822,5];[8192,32768,669695,1823];[8192,32768,212244,919];[8192,32768,1263716,3063];[8192,32768,538260,1796];[8192,32768,630552,1959];[16384,65536,1015558,6023];[16384,65536,968397,6082];[16384,65536,800764,5845];[16384,65536,9209,68];[16384,65536,769518,5604];[32768,131072,47249,1744];[32768,131072,1077713,23359];[32768,131072,2965992,42511];[32768,131072,1557301,27372];[32768,131072,549368,12999];[65536,262144,412117,44058];[65536,262144,1437544,88122];[65536,262144,1144968,81143];[65536,262144,2356955,127642];[65536,262144,1327353,91760];[131072,524288,1760186,205869];[131072,524288,2849928,306028];[131072,524288,643173,114341];[131072,524288,1739206,245006];[131072,524288,1383905,228406];[262144,1048576,12797633,2051841];[262144,1048576,7720105,1429357];[262144,1048576,6062946,1303354];[262144,1048576,5175257,1201190];[262144,1048576,10735360,1861922]];
alg_2_O3_ave = zeros(length(alg_2_O3)/num_samples, 1);
for i = 1:length(alg_2_O3)/num_samples
    alg_2_O3_ave(i) = mean(alg_2_O3((i-1)*num_samples+1:i*num_samples, 4)) * 1000;
end


alg_2_Ofast = [[256,1024,56285,2];[256,1024,11281,0];[256,1024,17966,0];[256,1024,17426,0];[256,1024,8768,0];[512,2048,248383,21];[512,2048,75385,6];[512,2048,17226,1];[512,2048,137308,12];[512,2048,47571,7];[1024,4096,177410,40];[1024,4096,78745,24];[1024,4096,260354,53];[1024,4096,194324,44];[1024,4096,52631,12];[2048,8192,42087,35];[2048,8192,791493,350];[2048,8192,839115,353];[2048,8192,288943,175];[2048,8192,268470,168];[4096,16384,1523828,1447];[4096,16384,652237,858];[4096,16384,1081065,1255];[4096,16384,364661,650];[4096,16384,1822,5];[8192,32768,669695,1841];[8192,32768,212244,937];[8192,32768,1263716,3082];[8192,32768,538260,1809];[8192,32768,630552,1974];[16384,65536,1015558,5762];[16384,65536,968397,5846];[16384,65536,800764,5579];[16384,65536,9209,66];[16384,65536,769518,5389];[32768,131072,47249,1348];[32768,131072,1077713,18303];[32768,131072,2965992,34749];[32768,131072,1557301,20701];[32768,131072,549368,9913];[65536,262144,412117,38030];[65536,262144,1437544,75992];[65536,262144,1144968,70731];[65536,262144,2356955,106906];[65536,262144,1327353,77384];[131072,524288,1760186,213455];[131072,524288,2849928,248679];[131072,524288,643173,89551];[131072,524288,1739206,190454];[131072,524288,1383905,179928];[262144,1048576,12797633,1914527];[262144,1048576,7720105,1417036];[262144,1048576,6062946,1317888];[262144,1048576,5175257,1351420];[262144,1048576,10735360,2002754]];
alg_2_Ofast_ave = zeros(length(alg_2_Ofast)/num_samples, 1);
for i = 1:length(alg_2_Ofast)/num_samples
    alg_2_Ofast_ave(i) = mean(alg_2_Ofast((i-1)*num_samples+1:i*num_samples, 4)) * 1000;
end



x = alg_1_noOptimization(1:num_samples:length(alg_1_noOptimization), 1);
figure(1)
plot(x, alg_1_noOptimization_ave)
xlabel('Problem Size')
ylabel('Time (ms)')
title('Time vs. Problem Size')
hold on
plot(x, alg_2_noOptimization_ave)
legend('Cycle Canceling', 'Extended Shortest Augmenting Path')
grid on
%%
figure(2)
semilogx(x, alg_1_noOptimization_ave)
xlabel('log(Problem Size)')
ylabel('Time (ms)')
title('Time vs. Problem Size')
hold on
semilogx(x, alg_2_noOptimization_ave)
legend('Cycle Canceling', 'Extended Shortest Augmenting Path')
grid on
%%
figure(3)
plot(x, alg_1_Ofast_ave)
xlabel('Problem Size')
ylabel('Time (ms)')
title('O-Fast Optimization')
hold on
plot(x, alg_2_Ofast_ave)
legend('Cycle Canceling', 'Extended Shortest Augmenting Path')
grid on
%%
figure(4)
plot(x, alg_1_O3_ave)
xlabel('Problem Size')
ylabel('Time (ms)')
title('O-3 Optimization')
hold on
plot(x, alg_2_O3_ave)
legend('Cycle Canceling', 'Extended Shortest Augmenting Path')
grid on