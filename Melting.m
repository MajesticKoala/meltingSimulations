clc
clear all
close all
hold on


%% Constant
k = 0.5;

%% Matrix
x = 70;
y = 70;
matrix = zeros(x:y);

% 'Tom' design

matrix(25:30,1:15) = 1;
matrix(5:25,5:10) = 1;

matrix(5:25,20:25) = 2;
matrix(5:25,30:35) = 2;
matrix(20:25,25:30) = 2;
matrix(5:10,25:30) = 2;

matrix(5:25,40:45) = 1;
matrix(5:25,50:55) = 1;
matrix(5:25,60:65) = 1;
matrix(20:25,40:65) = 1;
%{
% blocks
matrix(20:50,20:50) = 1;
matrix(25:30,25:30) = 1.5;
matrix(35:40,40:45) = 2;
matrix(30:35,32:37) = 0.2;
matrix(45:50,20:25) = 0.5;
%}
melt = matrix;

%% Timer
axis off
axis([0 x 0 y 0 4]);
txtTime = text(0, y+3, 's', 'fontsize', 16);

%% Melting
for stop = 1:1000
    for i =1:x
            for j = 1:y
                if matrix(i,j) > 0
                    loss = matrix(i,j) - k.*matrix(i,j);
                    gain = loss/8;
                    melt(i,j) = melt(i,j) - loss;

                    if i ~= 1
                            melt(i-1,j) =  melt(i-1,j)+gain;
                    end
                    if i ~= x
                            melt(i+1,j) = melt(i+1,j)+gain;
                    end
                    if j ~= 1
                            melt(i,j-1) = melt(i,j-1)+gain;
                    end
                    if j ~= y
                        
                        melt(i,j+1) = melt(i,j+1) + gain;
                    end
                    if i ~= 1 && j ~= 1
                        melt(i-1,j-1) = melt(i-1,j-1) + gain;
                    end
                    if i ~= 1 && j ~= y
                        melt(i-1,j+1) = melt(i-1,j+1) + gain;
                    end
                    if i ~= x && j ~= 1
                        melt(i+1,j-1) = melt(i+1,j-1) + gain;
                    end
                    if i ~= x && j ~= y
                        melt(i+1,j+1) = melt(i+1,j+1) + gain;
                    end
                end
            end
    end
    matrix = matrix + melt;
    s = surf((matrix), 'EdgeColor', 'none');
    view(-stop*2, 40);
    pause(0.1);
    delete(s);
    melt = melt*0;
    set(txtTime , 'string', ['Time: ' num2str(stop)]);
end