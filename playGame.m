function playGame()
    % Example usage with the initial board state
    board = initialiseBoard();
    rng(5259408);
    zKeys = uint32(randperm(2^32, 798));
    hashTable = createHashTable();
    load('bookTable.mat');
   
    % Select the colour you want to play as (1 = white, 2 = black)
    playersColour = 1;
    
    
    % Get the Zobrist key for the current board position
    zobristKey = calculateZobristKey(board, zKeys);
    
    if playersColour == 2
        bestMove = [75, 55, 11, 10, 1];
        % Store the result in the hash table
        addToHashTable(hashTable, zobristKey, 99, bestMove, 0, 1, "exact");
    end
    
    if playersColour == 1
        mainwhite(board, playersColour, hashTable, zKeys); 
    else
        mainblack(board, playersColour, hashTable, zKeys);
    end
end



function mainwhite(board, colour, hashTable, zKeys)
loadBoard(board, colour, hashTable, zKeys);
if colour == 2
    pause(0.01);
    depth = 1;
    moveSequence = [];
    startTime = tic;
    tic;
    bestMove = [];
    book = 1;
    while toc(startTime) < 4 || depth < 5
        depth = depth+1;
        [bestMove, bestValue, ~] = alphaBetaPruning(board, colour, @positionValue, depth, -inf, inf, moveSequence, bestMove, hashTable, zKeys, book);
        if bestValue == inf || bestValue == -inf
            break
        end
    end
    if (size(bestMove) == 0)
       fprintf("You win! \n"); 
    else
        fprintf("depth reach %d \n", floor(depth));
        time = toc();
        board = makeMove(bestMove(1), bestMove(2), bestMove(3), board);
        colour = otherColour(colour);
        zobristKey = calculateZobristKey(board, zKeys);
        addToHashTable(hashTable, zobristKey, 0, bestMove, bestValue, colour, "played");
        digestableMove = convertToChess(bestMove);
        evaluation = double(bestValue/100);
        if (evaluation > 0)
            fprintf("Computer thinks it is up %.2f points! \n", evaluation);
        elseif evaluation < 0
            fprintf("Computer thinks it is down %.2f points! \n", evaluation);
        else   
            fprintf("Computer thinks the game is even! \n");
        end

        fprintf("Computer moved %s! And it took it %.4f seconds to think of it!\n", digestableMove, time); 
        loadBoard(board, colour, hashTable, zKeys);
    end
end
end

function mainblack(board, colour, hashTable, zKeys)
loadBoard(board, colour, hashTable, zKeys);
colour = otherColour(colour);
pause(0.01);
depth = 1;
moveSequence = [];
startTime = tic;
book = 1;
tic;
bestMove = [];
while toc(startTime) < 4  || depth < 5
    depth = depth+1;
    [bestMove, bestValue, ~, booked] = alphaBetaPruning(board, colour, @positionValue, depth, -inf, inf, moveSequence, bestMove, hashTable, zKeys, book);
    if bestValue == inf || bestValue == -inf || booked == true
        break
    end
end
if (size(bestMove) == 0)
   fprintf("You win! \n"); 
else
    fprintf("depth reach %d \n", depth);
    time = toc();
    board = makeMove(bestMove(1), bestMove(2), bestMove(3), board);
    colour = otherColour(colour);
    zobristKey = calculateZobristKey(board, zKeys);
    addToHashTable(hashTable, zobristKey, 0, bestMove, bestValue, colour, "played");
    digestableMove = convertToChess(bestMove);
    evaluation = double(bestValue/100);
    if (evaluation > 0)
        fprintf("Computer thinks it is up %.2f points! \n", evaluation);
    elseif evaluation < 0
        fprintf("Computer thinks it is down %.2f points! \n", evaluation);
    else   
        fprintf("Computer thinks the game is even! \n");
    end
    fprintf("Computer moved %s! And it took it %.4f seconds to think of it!\n", digestableMove, time); 
    loadBoard(board, colour, hashTable, zKeys);
end
end

function loadBoard(board, colour, hashTable, zKeys)
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

% Create a text input field (uicontrol)
textInput = uicontrol('Style', 'edit', 'Position', [20, 20, 200, 30], 'FontSize', 12);

% Create a button to submit the move
submitBtn = uicontrol('Style', 'pushbutton', 'String', 'Submit', 'Position', [240, 20, 80, 30], 'FontSize', 12, 'Callback', {@updateFigure, textInput, board, colour, hashTable, zKeys});

end

% Callback function for the button
function updateFigure(~,~, textInput, board, colour, hashTable, zKeys)
    move = get(textInput, 'String');
    move = moveToComputer(move, board, colour);
    
    if move(1) ~= 0
       board = makeMove(move(1), move(2), move(3), board); 
       digestableMove = convertToChess(move);
       fprintf("You moved %s! \n", digestableMove); 
       if colour == 1
            colour = otherColour(colour);
            mainwhite(board, colour, hashTable, zKeys);
       else
            mainblack(board, colour, hashTable, zKeys);
       end
    else
       fprintf("INVALID MOVE DINGUS \n"); 
    end
    % Process the move and update the figure accordingly
    % Add your own code here to update the figure based on the move input
end