%% sub function to get N and initial coordinates
function [x_min, x_max, y_min, y_max] = get_limits(Board,coord)

%% Inputs
% Board is the current Board, a 10x10 matrix
% coord are the current coordinates where we may place a ship

%% Outputs
% in the current row, x_min through x_max are all open spaces, and the
% current x value is between (or equal to one of) x_min and x_max

% in the current column, y_min through y_max are all open spaces, and the
% current y value is between (or equal to one of) y_min and y_max

%% code
x = coord(1);
y = coord(2);

dx = diff(Board(y,:));
dy = diff(Board(:,x));

if x == 1
    x_min = 1;
    x_max = min(find(dx(x:end)~=0))+x-1;
    if isempty(x_max)
        x_max = 10;
    end
elseif x == 10
    x_max = 10;
    x_min = max(find(dx(1:x-1)~=0))+1;
    if isempty(x_min)
        x_min = 1;
    end
else
    x_min = max(find(dx(1:x-1)~=0))+1;
    x_max = min(find(dx(x:end)~=0))+x-1;
    if isempty(x_min)
        x_min = 1;
    end
    if isempty(x_max)
        x_max = 10;
    end
end

if y == 1
    y_min = 1;
    y_max = min(find(dy(y:end)~=0))+y-1;
    if isempty(y_max)
        y_max = 10;
    end
elseif y == 10
    y_max = 10;
    y_min = max(find(dy(1:y-1)~=0))+1;
    if isempty(y_min)
        y_min = 1;
    end
else
    y_min = max(find(dy(1:y-1)~=0))+1;
    y_max = min(find(dy(y:end)~=0))+y-1;
    if isempty(y_min)
        y_min = 1;
    end
    if isempty(y_max)
        y_max = 10;
    end
end

end