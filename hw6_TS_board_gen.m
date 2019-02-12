% "I discussed this homework problem with Tim Gong. 
% I certify that the assignment I am submitting represents my own work. Tien Li Shen"
% Tien-Li Shen, 03/6/2018, HW5, ID:30930512

%The get_limit function caused my a lot of confusion but I eventually got my
%code to work, although at some places I lost track of my variables.
function [Board] = hw6_TS_board_gen()
    Board = zeros(10);
    ship_num_assign = [1, 2, 3, 4, 5];
    ship_length = [5, 4, 3, 3, 2];
    initial_coord = zeros(1,2);
    success = 0;
    for Q = 1:5
        success = 0;
        while  success == 0
            %while ship is unsuccessful deployed, the while-loop will
            %generate another coordinate to deploy a ship untill the ship is
            %successfully deployed
            initial_coord = [randi(10), randi(10)];
            %since the get_limit function uses [x, y], I must input (y, x)
            %to deploy the ships.
            if Board(initial_coord(2), initial_coord(1)) == 0
                [Board, success] = CheckSpaces(Board, ship_length(Q), initial_coord, ship_num_assign(Q));
                %if the current ship is successfully deployed, the while-loop
                %will return to the for-loop and continue to place down the
                %next ship
            end
        end
    end
end

%sub-function
function [Board, success] = CheckSpaces(Board, length, coordinate, ship_num)
    %initialize some variables
    placeX = 0;
    placeY = 0;
    [x_min, x_max, y_min, y_max] = get_limits(Board, coordinate);
    %calculate the amount of space available in either direction, a "+ 1"
    %is added to each direction since both min and max are available spaces
    x_displacement = x_max - x_min+1;
    y_displacement = y_max - y_min+1;
    %if there is enough space in either direction, success returns logical
    if x_displacement >= length || y_displacement >= length
        success = 1;
        Board(coordinate(2), coordinate(1)) = ship_num;
    else
        success = 0;
        return
    end
    %this determines the feasibility of place ships on x and y axises
    if x_displacement >= length
        x_placement = 1;
    else
        x_placement = 0;
    end
    if y_displacement >= length
        y_placement = 1;
    else
        y_placement = 0;
    end
    %this determines if we should deploy the ship vertically or horizontally
    %if it is possible to place the ship both vertically and horizontally,
    %the if statement will perform a coinflip to decide which direction to
    %go
    if x_placement == 1 && y_placement == 1
        coinflip = rand(1);
        if coinflip > 0.5
            placeX = 1;
            placeY = 0;
        else
            placeX = 0;
            placeY = 1;
        end
    end
    if x_placement == 1 && y_placement == 0
        placeX = 1;
        placeY = 0;
    elseif x_placement == 0 && y_placement == 1
        placeX = 0;
        placeY = 1;
    end
    %once the direction of placement is decided, this places the ships on the board
    %this works by extending the ships grid by grid, the ships will
    %continue to extend until it reaches its assigned length or hits the
    %boarder or another ship. in case of hitting another ship or boarder,
    %it will go back to its original coordinate and extend in the opposite
    %direction
    if placeX == 1
        L = 1;
        A = 1;
        B = 1;
        %placing ship horizontaly
        while L < length && coordinate(1)+A <= x_max
            Board(coordinate(2), coordinate(1)+A) = ship_num;
            A = A + 1;
            L = L + 1;   
        end
        while L < length && coordinate(1)-B >= x_min
            Board(coordinate(2), coordinate(1)-B) = ship_num;
            B = B + 1;
            L = L + 1; 
        end
    end
    if placeY == 1
        L = 1;
        A = 1;
        B = 1;
        %placing ship vertically
        while L < length && coordinate(2)+A <= y_max
            Board(coordinate(2)+A, coordinate(1)) = ship_num;
            A = A + 1;
            L = L + 1;
        end
        while L < length && coordinate(2)-B >= y_min
            Board(coordinate(2)-B, coordinate(1)) = ship_num;
            B = B + 1;
            L = L + 1;
        end
    end
end