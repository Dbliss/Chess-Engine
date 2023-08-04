function loadBoard(board)
figure (1); clf;
% Load a white queen image
whiteQueenDark = imread('whiteQueenLight.JPG');
whiteQueenLight = imread('whiteQueenDark.JPG');
whiteKingDark = imread('whiteKingLight.JPG');
whiteKingLight = imread('whiteKingDark.JPG');
whiteRookDark = imread('whiteRookLight.JPG');
whiteRookLight = imread('whiteRookDark.JPG');
whiteBishopDark = imread('whiteBishopLight.JPG');
whiteBishopLight = imread('whiteBishopDark.JPG');
whitePawnDark = imread('whitePawnOnLight.JPG');
whitePawnLight = imread('whitePawnOnDark.JPG');
whiteKnightLight = imread('whiteKnightDark.JPG');
whiteKnightDark = imread('whiteKnightLight.JPG');

blackQueenDark = imread('blackQueenLight.JPG');
blackQueenLight = imread('blackQueenDark.JPG');
blackKingDark = imread('blackKingLight.JPG');
blackKingLight = imread('blackKingDark.JPG');
blackRookDark = imread('blackRookLight.JPG');
blackRookLight = imread('blackRookDark.JPG');
blackBishopDark = imread('blackBishopLight.JPG');
blackBishopLight = imread('blackBishopDark.JPG');
blackPawnDark = imread('blackPawnOnLight.JPG');
blackPawnLight = imread('blackPawnOnDark.JPG');
blackKnightLight = imread('blackKnightDark.JPG');
blackKnightDark = imread('blackKnightLight.JPG');

% Display the chess board with custom symbols
image(board, 'CDataMapping', 'scaled');
% axis ij; % Reverse the y-axis to match chessboard orientation

% Set the aspect ratio of the axes
pbaspect([1 1 1]);

% Add alternating gray and white squares
for i = 0:7
    for j = 0:7
        if mod(i+j, 2) == 0
            rectangle('Position', [j i 1 1], 'FaceColor', [232/256 238/256 208/256], 'EdgeColor', 'none');
        else
            rectangle('Position', [j i 1 1], 'FaceColor', [91/256 151/256 91/256], 'EdgeColor', 'none');
        end
    end
end

hold on;
for i = 1:size(board, 1)
    for j = 1:size(board, 2)
        if board(i, j) == 15
            x = j - 0.5;
            y = i - 0.5;
            if mod(i + j, 2) == 1
                image([x-0.5 x+0.5], [y-0.5 y+0.5], whiteQueenLight);
            else
                image([x-0.5 x+0.5], [y-0.5 y+0.5], whiteQueenDark);
            end
            
        elseif board(i, j) == 16
            x = j - 0.5;
            y = i - 0.5;
            if mod(i + j, 2) == 1
                image([x-0.5 x+0.5], [y-0.5 y+0.5], whiteKingLight);
            else
                image([x-0.5 x+0.5], [y-0.5 y+0.5], whiteKingDark);
            end
            
        elseif board(i, j) == 11
            x = j - 0.5;
            y = i - 0.5;
            if mod(i + j, 2) == 1
                image([x-0.5 x+0.5], [y-0.5 y+0.5], whitePawnLight);
            else
                image([x-0.5 x+0.5], [y-0.5 y+0.5], whitePawnDark); 
            end

        elseif board(i, j) == 14
            x = j - 0.5;
            y = i - 0.5;
            if mod(i + j, 2) == 1
                image([x-0.5 x+0.5], [y-0.5 y+0.5], whiteRookLight);
            else
                image([x-0.5 x+0.5], [y-0.5 y+0.5], whiteRookDark);
            end
            
        elseif board(i, j) == 13
            x = j - 0.5;
            y = i - 0.5;
            if mod(i + j, 2) == 1
                image([x-0.5 x+0.5], [y-0.5 y+0.5], whiteBishopLight);
            else
                image([x-0.5 x+0.5], [y-0.5 y+0.5], whiteBishopDark);
            end
            
        elseif board(i, j) == 12
            x = j - 0.5;
            y = i - 0.5;
            if mod(i + j, 2) == 1
                image([x-0.5 x+0.5], [y-0.5 y+0.5], whiteKnightLight);
            else
                image([x-0.5 x+0.5], [y-0.5 y+0.5], whiteKnightDark);
            end
        
        elseif board(i, j) == 25
            x = j - 0.5;
            y = i - 0.5;
            if mod(i + j, 2) == 1
                image([x-0.5 x+0.5], [y-0.5 y+0.5], blackQueenLight);
            else
                image([x-0.5 x+0.5], [y-0.5 y+0.5], blackQueenDark);
            end
            
        elseif board(i, j) == 26
            x = j - 0.5;
            y = i - 0.5;
            if mod(i + j, 2) == 1
                image([x-0.5 x+0.5], [y-0.5 y+0.5], blackKingLight);
            else
                image([x-0.5 x+0.5], [y-0.5 y+0.5], blackKingDark);
            end
            
        elseif board(i, j) == 21
            x = j - 0.5;
            y = i - 0.5;
            if mod(i + j, 2) == 0
                image([x-0.5 x+0.5], [y-0.5 y+0.5], blackPawnLight);
            else
                image([x-0.5 x+0.5], [y-0.5 y+0.5], blackPawnDark); 
            end

        elseif board(i, j) == 24
            x = j - 0.5;
            y = i - 0.5;
            if mod(i + j, 2) == 1
                image([x-0.5 x+0.5], [y-0.5 y+0.5], blackRookLight);
            else
                image([x-0.5 x+0.5], [y-0.5 y+0.5], blackRookDark);
            end
            
        elseif board(i, j) == 23
            x = j - 0.5;
            y = i - 0.5;
            if mod(i + j, 2) == 1
                image([x-0.5 x+0.5], [y-0.5 y+0.5], blackBishopLight);
            else
                image([x-0.5 x+0.5], [y-0.5 y+0.5], blackBishopDark);
            end
            
        elseif board(i, j) == 22
            x = j - 0.5;
            y = i - 0.5;
            if mod(i + j, 2) == 1
                image([x-0.5 x+0.5], [y-0.5 y+0.5], blackKnightLight);
            else
                image([x-0.5 x+0.5], [y-0.5 y+0.5], blackKnightDark);
            end
        end
    end
end

axis off;
% Add row labels to the left
for i = 1:8
    x = 0.2;
    y = i - 0.8;
    text(x, y, num2str(9-i), 'HorizontalAlignment', 'right', ...
        'VerticalAlignment', 'middle', 'FontSize', 12);
end

% Add column labels to the bottom
for j = 1:8
    x = j - 0.15;
    y = -0.5 + 8.1;
    text(x, y, char('a' + j - 1), 'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'top', 'FontSize', 12);
end

% Set the font size of the labels
ax = gca;
ax.FontSize = 12;

% Adjust figure properties for centering and removing extra white space
set(gcf, 'Units', 'normalized', 'Position', [0.2, 0.2, 0.6, 0.6]);
axis equal;
xlim([-1.5, 8]);
ylim([-1.5, 8]);
end