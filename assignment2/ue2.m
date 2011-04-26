clear;
close all;

load usps_all.mat;

avg = mean(double(data));



%plot averages as histograms:

% bins = linspace(10,190,60)
% 
% subplot(2,1,1);
% hist(avg(:,:,1), bins);
% h = findobj(gca,'Type','patch');
% set(h,'FaceColor', 'b');
% 
% subplot(2,1,2);
% hist(avg(:,:,8), bins);
% h = findobj(gca,'Type','patch');
% set(h,'FaceColor', 'r');
% 
% figure;
% 
% subplot(2,1,1);
% hist(avg(:,:,2), bins);
% h = findobj(gca,'Type','patch');
% set(h,'FaceColor', 'b');
% 
% subplot(2,1,2);
% hist(avg(:,:,5), bins);
% h = findobj(gca,'Type','patch');
% set(h,'FaceColor', 'r');


%fit gaussian distributions from training data only

train_data = data(:,1:550,:);
train_avg = mean(double(train_data));


mean_train = mean(train_avg(:,:,:));
mean_train_mat = repmat(mean_train, 1, 550);


var = sum( (train_avg(:,:,:)-mean_train_mat).^2 )./ size(train_data,2);


test_data = data(:,551:end,:);
test_avg = mean(double(test_data));

post = [normpdf(test_avg(:), mean_train(1,1,1), sqrt(var(1)))*0.5, ... 
        normpdf(test_avg(:), mean_train(1,1,8), sqrt(var(8)))*0.5];

%plot posterior for test data

% subplot(2,1,1);
% plot(post(:,1));
% subplot(2,1,2);
% plot(post(:,2));

test_small = [data(:,551:end,1),data(:,551:end,8)];
test_avg = mean(double(test_small));

post = [normpdf(test_avg(:), mean_train(1,1,1), sqrt(var(1)))*0.5, ... 
        normpdf(test_avg(:), mean_train(1,1,8), sqrt(var(8)))*0.5];


%plot posterior for 1 and 8 images only

% subplot(2,1,1);
% plot(post(:,1))
% subplot(2,1,2);
% plot(post(:,2))

[Y,I]= max(post, [], 2);

% error rate for 1 and 8
1.0-(sum(I(1:550)==1)+sum(I(551:end)==2))/size(I,1)


test_small = [data(:,551:end,2),data(:,551:end,5)];
test_avg = mean(double(test_small));
post = [normpdf(test_avg(:), mean_train(1,1,2), sqrt(var(2)))*0.5, ... 
        normpdf(test_avg(:), mean_train(1,1,5), sqrt(var(5)))*0.5];

[Y,I]= max(post, [], 2);
% error rate for 2 and 5
1.0-(sum(I(1:550)==1)+sum(I(551:end)==2))/size(I,1)

x = rand*255;

mean_train(:,:,:);



post = [normpdf(x, mean_train(1,1,1), sqrt(var(1)))*0.1, ... 
        normpdf(x, mean_train(1,1,2), sqrt(var(2)))*0.1, ... 
        normpdf(x, mean_train(1,1,3), sqrt(var(3)))*0.1, ... 
        normpdf(x, mean_train(1,1,4), sqrt(var(4)))*0.1, ... 
        normpdf(x, mean_train(1,1,5), sqrt(var(5)))*0.1, ... 
        normpdf(x, mean_train(1,1,6), sqrt(var(6)))*0.1, ... 
        normpdf(x, mean_train(1,1,7), sqrt(var(7)))*0.1, ...
        normpdf(x, mean_train(1,1,7), sqrt(var(8)))*0.1, ...
        normpdf(x, mean_train(1,1,7), sqrt(var(9)))*0.1, ...
        normpdf(x, mean_train(1,1,8), sqrt(var(10)))*0.1];

    

post = post ./sum(post);

assert(abs(sum(post)-1.0) < 10E-5)


% test on all data

test_avg = mean(double(test_data));

post = [normpdf(test_avg(:), mean_train(1,1,1), sqrt(var(1)))*0.1, ... 
        normpdf(test_avg(:), mean_train(1,1,2), sqrt(var(2)))*0.1, ... 
        normpdf(test_avg(:), mean_train(1,1,3), sqrt(var(3)))*0.1, ... 
        normpdf(test_avg(:), mean_train(1,1,4), sqrt(var(4)))*0.1, ... 
        normpdf(test_avg(:), mean_train(1,1,5), sqrt(var(5)))*0.1, ... 
        normpdf(test_avg(:), mean_train(1,1,6), sqrt(var(6)))*0.1, ... 
        normpdf(test_avg(:), mean_train(1,1,7), sqrt(var(7)))*0.1, ...
        normpdf(test_avg(:), mean_train(1,1,7), sqrt(var(8)))*0.1, ...
        normpdf(test_avg(:), mean_train(1,1,7), sqrt(var(9)))*0.1, ...
        normpdf(test_avg(:), mean_train(1,1,8), sqrt(var(10)))*0.1];
    
[Y,I]= max(post, [], 2);

% error rate for multi class predictions
1.0-(sum(I(1:550)==1) ...
    +sum(I(550*1+1:550*2)==2) ...
    +sum(I(550*2+1:550*3)==3) ...
    +sum(I(550*3+1:550*4)==4) ...
    +sum(I(550*4+1:550*5)==5) ...
    +sum(I(550*5+1:550*6)==6) ...
    +sum(I(550*6+1:550*7)==7) ...
    +sum(I(550*7+1:550*8)==8) ...
    +sum(I(550*8+1:550*9)==9) ...
    +sum(I(550*9+1:end)==10)) ...
    /size(I,1)


% which is a little bit better than chance

M = zeros(10,10);

for i=1:10
    M(:,i) = [sum(I(550*(i-1)+1:550*i)==1), sum(I(550*(i-1)+1:550*i)==2), ...
              sum(I(550*(i-1)+1:550*i)==3), sum(I(550*(i-1)+1:550*i)==4), ...
              sum(I(550*(i-1)+1:550*i)==5), sum(I(550*(i-1)+1:550*i)==6), ...
              sum(I(550*(i-1)+1:550*i)==7), sum(I(550*(i-1)+1:550*i)==8), ...
              sum(I(550*(i-1)+1:550*i)==9), sum(I(550*(i-1)+1:550*i)==10)];
end

M





    