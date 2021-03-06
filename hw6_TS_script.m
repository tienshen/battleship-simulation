% "I discussed this homework problem with Tim Gong. 
% I certify that the assignment I am submitting represents my own work. Tien Li Shen"
% Tien-Li Shen, 03/6/2018, HW5, ID:30930512

% one Battleship board is generated by calling out the generate board function
[Board] = hw6_TS_board_gen();

%initialize variables
sum_ship_length = 17; % I calculated the total number of grids that ships occupy and assigned it into this variable
hit_percent = zeros(1,100); %for effiency, hit_percent vector is initialized

%this for loop plays the board setup 100 times by picking random grids to
%strike. Strikes are counted and the while loop within will continue to
%strike until all ships are completely destroyed.
for i = 1:100
    %board and shot-count are refreshed before every-loop
    Board2 = Board;
    shots = 0;
    while sum(sum(Board2 == -999)) < sum_ship_length 
        coordinate_guess = [randi(10), randi(10)];
            shots = shots + 1;
        if Board2(coordinate_guess(2) , coordinate_guess(1)) ~= 0
            Board2(coordinate_guess(2) , coordinate_guess(1)) = -999;
        end
    end
    hit_percent(1,i) = sum_ship_length /shots*100;
end

%all of the hit percentage statistics are recorded and calculated here
hit_mean = mean(hit_percent); 
hit_min = min(hit_percent); 
hit_max = max(hit_percent); 
hit_standard_deviation = std(hit_percent);
figure
hist(hit_percent);
title("Hit Percentage Histogram");
xlabel("Hit Percentage");
ylabel("Occurance Count");
%the histograms are generally going to be slightly skewed to the right, 
%unimodel, and with a mode of %30

%this for-loop uses my algorithm 100 times. The first half the code are the
%same from above.
HitPercent2 = zeros(1,100);
for i = 1:100
    Board2 = Board;
    shots = 0;
    %my algorithm will have the capability to record the shots it fired
    %on a new board, Board3. It will not target any grids it shot before.
    %Then, if the algorithm hits a part of a ship, it will
    %target the surrounding grids.
    Board3 = zeros(10);
    while sum(sum(Board2 == -999)) < sum_ship_length 
        coordinate_guess = [randi(10), randi(10)];
        %if the random coordinate has already been guessed, the algorithm
        %will not increase shot-count
        if Board2(coordinate_guess(2) , coordinate_guess(1)) == 0
            Board3(coordinate_guess(2) , coordinate_guess(1)) = 1;
            shots = shots + 1;
        elseif Board2(coordinate_guess(2) , coordinate_guess(1)) ~= 0 && Board3(coordinate_guess(2) , coordinate_guess(1)) == 0
            Board2(coordinate_guess(2) , coordinate_guess(1)) = -999;
            shots = shots + 1;
        end
    end
    HitPercent2(i) = sum_ship_length/shots*100;
    end

%all of the hit percentage statistics are recorded and calculated here
hit_mean2 = mean(HitPercent2); 
hit_min2 = min(HitPercent2); 
hit_max2 = max(HitPercent2); 
hit_standard_deviation2 = std(HitPercent2);
figure
hist(HitPercent2);
title("Hit Percentage for Algorithm Histogram");
xlabel("Hit Percentage");
ylabel("Occurance Count");
%The increased efficiency is almost negligible. Due to my
%personal time constraints, I could only execute this strategy. I did plan
%on making it target surrounding grids if the coordinate is a hit. And if
%the algorithm finds the direction of the ship is deployed it will target
%in that direction until either ends of the ship are miss.