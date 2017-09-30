clc
clear all
close all
hold on

x=50;
y=50;
forest = zeros(x, y);
gump = forest*0;
flamabilibility = 0.01;
forest(5, 5) = 1;
forest(49, 42) = 1;
forest(37, 30) = 1;
for z = 1:100
    for j =1:x
        for i = 1:y
            if forest(j, i)>0
                gump(j, i) = gump(j, i) +flamabilibility.*(1 - gump(j, i));
                if j ~= 1 && j ~= x
                    gump(j+1, i) = gump(j+1, i) +flamabilibility.*(1 - gump(j+1, i));
                    gump(j-1, i) = gump(j-1, i) +flamabilibility.*(1 - gump(j-1, i));
                end
                if i ~= 1 && i ~= y
                gump(j, i+1) = gump(j, i+1) +flamabilibility.*(1 - gump(j, i+1));
                gump(j, i-1) = gump(j, i-1) +flamabilibility.*(1 - gump(j, i-1));
                end
            end
        end
    end
    pause(0.05)
    forest=gump;
    view(0, 90);
    surf(forest)
    %disp(forest)
end
