clc
clear all
close all
hold on


%% Varialbes
finalTime = 1400;
x=200;
y=200;

%% Timer, plot and counters
colormap(hot);
axis off
view(0, 90);

txtTime = text(0, y.*1.05, 's', 'fontsize', 16);
txtTree = text(x.*0.38, y.*1.05, 's', 'fontsize', 16);
txtFire = text(x.*0.8, y.*1.05, 's', 'fontsize', 16);

%% Dialogue box
prompt={'Enter combustion level 0.001 - 1'};
dlg_title = 'Combustion';
num_lines = 1;
defaultans = {'0.005'};
k = str2double(inputdlg(prompt, dlg_title, num_lines, defaultans));

forest = zeros(x, y);
gump = forest*0;
burnt = ones(x,y);

timer = (1:1:finalTime);
trees = timer*0;
trees(1) = x.*y;
fire = timer*0;
rate = timer*0;

%% Initial fire and barrier locations

burnt(1,1) = 0;
burnt(1:50, 100:102) = 0;
burnt(52:100, 100:102) = 0;
burnt(102:150, 100:102) = 0;
burnt(152:199, 100:102) = 0;

forest(50:59, 5:5) = 0.8;
forest(89, 2) = 0.8;
forest(61:65, 2:3) = 0.8;
forest(25:29, 1:5) = 0.8;

%% Create Fire
z = 1;
tic
while trees(z) > 0
    for i =1:x
        for j = 1:y
            if forest(i,j)>0.9
               burnt(i,j) = 0;
            end
            
            r = round(randi(4));
            if forest(i, j)>0
                gump(i,j) = gump(i,j) +k.*(1 - gump(i,j));
                
                if i ~= 1 && r==1
                    gump(i-1,j) = gump(i-1,j) +k.*(1 - gump(i-1,j));
                end
                if i ~= x && r==2
                    gump(i+1,j) = gump(i+1,j) +k.*(1 - gump(i+1,j));
                end
                if j ~= 1 && r==3
                    gump(i, j-1) = gump(i,j-1) +k.*(1 - gump(i,j-1));
                end
                if j ~= y && r==4
                    gump(i, j+1) = gump(i,j+1) +k.*(1 - gump(i,j+1));
                end
            end
        end
        time = z;
        set(txtTime , 'string', ['Time: ' num2str(time)]);
    end
    forest=gump.*burnt;
    s = surf((forest), 'EdgeColor', 'none');
    pause(0.0)
    delete(s);
    rate(z) = (forest(40, 5));
    trees(z+1) = round(sum(burnt(:)));
    fire(z+1) = round(sum(forest(:)));
    set(txtTree , 'string', ['Trees: ' num2str(trees(z))]);
    set(txtFire , 'string', ['Fire: ' num2str(fire(z))]);
    z = z+1;
end
toc

surf(forest, 'EdgeColor', 'none');

%% Graphs    
figure
plot(timer, rate);
title('Burning Tree');
xlabel('Time');
ylabel('Heat');
figure
hold on
plot(timer, fire, '-')
plot(timer, trees, 'g-')
title('Trees and Flames');
xlabel('Time');
ylabel('Number');
legend('Fire', 'Trees');