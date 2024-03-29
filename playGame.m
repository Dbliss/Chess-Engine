function playGame()
    % Example usage with the initial board state
    board = initialiseBoard();
    rng(5259408);
    zKeys = uint64(randperm(2^52, 800));
    hashTable = createHashTable();
    bookTable = load('bookTable.mat');
   
    % Select the colour you want to play as (1 = white, 2 = black)
    playersColour = 1;
    
    
    % Get the Zobrist key for the current board position
    zobristKey = calculateZobristKeys2_mex(board, zKeys);
    

    
    if playersColour == 1
        mainwhite(board, playersColour, hashTable, zKeys, bookTable); 
    else
        mainblack(board, playersColour, hashTable, zKeys, bookTable);
    end
end



function mainwhite(board, colour, hashTable, zKeys, bookTable)
engine1 = @engine2;
strength = 2;
pause(0.01);
[bestMove, ~] = findBestMove(board, 1, strength, hashTable, zKeys, engine1, 1, bookTable);

zobristKey = calculateZobristKeys2_mex(board, zKeys);
% Retrieve the stored information for the position

storedData = retrieveFromHashTable(hashTable, zobristKey);

% Check if the current position is in the hash table
if ~isempty(storedData)
    if storedData.flag == "played" && storedData.colour == 1
        depf = storedData.depth + 1;
        addToHashTable(hashTable1, zobristKey, depf, bestMove, 0, 1, "played");
        if depf == 3
            fprintf("Draw by repitition \n");
            return;
        end  
    else
        addToHashTable(hashTable, zobristKey, 1, bestMove, 0, 1, "played");
    end
else
    addToHashTable(hashTable, zobristKey, 1, bestMove, 0, 1, "played");
end

board = makeMove(bestMove(1), bestMove(2), bestMove(3), board);
key = isGameOver(board);
if key == 1
    fprintf("White wins! \n"); 
    return;
elseif key == 2
    fprintf("Draw by stalemate \n");
    return;
end
colour = otherColour(colour);
loadBoard(board, colour, hashTable, zKeys, bookTable);
end

function num = isGameOver(board)
   % 0 not game over, 1 current player wins, 2 is draw
   
    %Get all legal moves for the current player
    legalMoves = getLegalMoves_mex(board);
    
    % stalemate and checkmate
    if isempty(legalMoves)
        if (fastamIChecked_mex(board) == true)
           num = 1;
        else
            num = 2;
        end
    else
       num = 0; 
    end
end

function mainblack(board, colour, hashTable, zKeys, bookTable)
engine1 = @engine2;
strength = 2;
loadBoard(board, colour, hashTable, zKeys, bookTable);
colour = otherColour(colour);
pause(0.01);
[bestMove, ~] = findBestMove(board, 2, strength, hashTable, zKeys, engine1, 1, bookTable);
    
zobristKey = calculateZobristKeys2_mex(board, zKeys);
% Retrieve the stored information for the position

storedData = retrieveFromHashTable(hashTable, zobristKey);

% Check if the current position is in the hash table
if ~isempty(storedData)
    if storedData.flag == "played" && storedData.colour == 1
        depf = storedData.depth + 1;
        addToHashTable(hashTable1, zobristKey, depf, bestMove, 0, 2, "played");
        if depf == 3
            fprintf("Draw by repitition \n");
            return;
        end  
    else
        addToHashTable(hashTable, zobristKey, 1, bestMove, 0, 2, "played");
    end
else
    addToHashTable(hashTable, zobristKey, 1, bestMove, 0, 2, "played");
end

board = makeMove(bestMove(1), bestMove(2), bestMove(3), board);
key = isGameOver(board);
if key == 1
    fprintf("Black wins! \n"); 
    return;
elseif key == 2
    fprintf("Draw by stalemate \n");
    return;
end
colour = otherColour(colour);
loadBoard(board, colour, hashTable, zKeys, bookTable);
end

function [bestMove, timeTaken] = findBestMove(board, colour, time, hashTable, zKeys, engineName, engineNum, bookTable)
    startTime = tic;
    depth = 1;
    prevBest = [];
    while toc(startTime) < time
        [bestMove, bestValue, ~] = engineName(board, colour, @positionValue, depth, -inf, inf, [], prevBest, hashTable, zKeys, 1, bookTable, 0);
        depth = depth+1;
        prevBest = bestMove;
        if bestValue == inf || bestValue == -inf
            break
        end
    end
    move = convertToChess(bestMove);
    timeTaken = toc(startTime);
    if engineNum == 1
        fprintf("%0.2f seconds, %d depth, engine1. Eval = %d, %s\n", toc(startTime), depth, bestValue, move );
    else
        fprintf("%0.2f seconds, %d depth, engine2, Eval = %d, %s \n", toc(startTime), depth, bestValue, move);
    end
end

function loadBoard(board, colour, hashTable, zKeys, bookTable)
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
submitBtn = uicontrol('Style', 'pushbutton', 'String', 'Submit', 'Position', [240, 20, 80, 30], 'FontSize', 12, 'Callback', {@updateFigure, textInput, board, colour, hashTable, zKeys, bookTable});

end

% Callback function for the button
function updateFigure(~,~, textInput, board, colour, hashTable, zKeys, bookTable)
    move = get(textInput, 'String');
    move = moveToComputer(move, board);
    
    if move(1) ~= 0
       board = makeMove(move(1), move(2), move(3), board); 
       digestableMove = convertToChess(move);
       fprintf("You moved %s! \n", digestableMove); 
       if colour == 1
            colour = otherColour(colour);
            mainwhite(board, colour, hashTable, zKeys, bookTable);
       else
            mainblack(board, colour, hashTable, zKeys, bookTable);
       end
    else
       fprintf("INVALID MOVE DINGUS \n"); 
    end
    % Process the move and update the figure accordingly
    % Add your own code here to update the figure based on the move input
end