function play()
    bookTable = load('bookTable.mat');

    % Example usage with the initial board state
    board = initialiseBoard();
    board = makeMove(74, 64, 11, board);
    board = makeMove(24, 44, 21, board);
    board = makeMove(87, 66, 12, board);
    board = makeMove(25, 35, 21, board);
    playerColour = 2;
    
    if playerColour == 1
        gameLoop2(board, bookTable);
    else
        gameLoop(board, bookTable);
    end
end

function gameLoop(board, bookTable)
    engine1 = @engine3;
    strength = 3;
    rng(5259408);
    zKeys = uint64(randperm(2^52, 800));
    hashTable1 = createHashTable();
    moves = 0;
    while (true)
        [bestMove, ~] = findBestMove(board, 1, strength, hashTable1, zKeys, engine1, 1, bookTable);
        zobristKey = calculateZobristKeys2_mex(board, zKeys);
        % Retrieve the stored information for the position
        
        storedData = retrieveFromHashTable(hashTable1, zobristKey);
        
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
                addToHashTable(hashTable1, zobristKey, 1, bestMove, 0, 1, "played");
            end
        else
            addToHashTable(hashTable1, zobristKey, 1, bestMove, 0, 1, "played");
        end

        board = makeMove(bestMove(1), bestMove(2), bestMove(3), board);
        key = isGameOver(board);
        
        if key == 1
            fprintf("White wins \n");
            return;
        elseif key == 2
            fprintf("Draw by stalemate \n");
            return;
        end
        
        loadBoard(board)
        
        %input player move
        move = input('Input move: ', 's');
        while (true)
            move = moveToComputer(move, board);

            if move(1) ~= 0
               board = makeMove(move(1), move(2), move(3), board); 
               digestableMove = convertToChess(move);
               fprintf("You moved %s! \n", digestableMove); 
               break;
            else
               fprintf("INVALID MOVE DINGUS \n"); 
               move = input('Input move: ', 's');
            end
        end
        
        bestMove = move;

        zobristKey = calculateZobristKeys2_mex(board, zKeys);
        % Retrieve the stored information for the position      
        storedData = retrieveFromHashTable(hashTable1, zobristKey);
        % Check if the current position is in the hash table
        if ~isempty(storedData)
            if storedData.flag == "played" && storedData.colour == 2
                depf = storedData.depth + 1;
                addToHashTable(hashTable1, zobristKey, depf, bestMove, 0, 2, "played");
                if depf == 3 
                    fprintf("Draw by repitition \n");
                    return;
                end  
            else
                addToHashTable(hashTable1, zobristKey, 1, bestMove, 0, 2, "played");
            end
        else
            addToHashTable(hashTable1, zobristKey, 1, bestMove, 0, 2, "played");
        end

        board = makeMove(bestMove(1), bestMove(2), bestMove(3), board);
        key = isGameOver(board);
        %loadBoard(board)
        if key == 1
            fprintf("Black wins \n");
            return;
        elseif key == 2
            fprintf("Draw by stalemate \n");
            return;
        end
        moves = moves + 1;
        
        if moves > 150
           fprintf("TOO MANY MOVES \n");
           return;
        end
        loadBoard(board)
        pause(0.1)
    end
end

function gameLoop2(board, bookTable)
    engine1 = @engine3;
    strength = 3;
    rng(5259408);
    zKeys = uint64(randperm(2^52, 800));
    hashTable1 = createHashTable();
    moves = 0;
    while (true)
        %input player move
        move = input('Input move: ', 's');
        while (true)
            move = moveToComputer(move, board);

            if move(1) ~= 0
               board = makeMove(move(1), move(2), move(3), board); 
               digestableMove = convertToChess(move);
               fprintf("You moved %s! \n", digestableMove); 
               break;
            else
               fprintf("INVALID MOVE DINGUS \n"); 
               move = input('Input move: ', 's');
            end
        end
        
        bestMove = move;

        zobristKey = calculateZobristKeys2_mex(board, zKeys);
        % Retrieve the stored information for the position      
        storedData = retrieveFromHashTable(hashTable1, zobristKey);
        % Check if the current position is in the hash table
        if ~isempty(storedData)
            if storedData.flag == "played" && storedData.colour == 2
                depf = storedData.depth + 1;
                addToHashTable(hashTable1, zobristKey, depf, bestMove, 0, 2, "played");
                if depf == 3 
                    fprintf("Draw by repitition \n");
                    return;
                end  
            else
                addToHashTable(hashTable1, zobristKey, 1, bestMove, 0, 2, "played");
            end
        else
            addToHashTable(hashTable1, zobristKey, 1, bestMove, 0, 2, "played");
        end

        board = makeMove(bestMove(1), bestMove(2), bestMove(3), board);
        key = isGameOver(board);
        %loadBoard(board)
        if key == 1
            fprintf("Black wins \n");
            return;
        elseif key == 2
            fprintf("Draw by stalemate \n");
            return;
        end
        moves = moves + 1;
        
        if moves > 150
           fprintf("TOO MANY MOVES \n");
           return;
        end
        loadBoard(board)
        pause(0.1)
    
    [bestMove, ~] = findBestMove(board, 1, strength, hashTable1, zKeys, engine1, 2, bookTable);
        zobristKey = calculateZobristKeys2_mex(board, zKeys);
        % Retrieve the stored information for the position
        
        storedData = retrieveFromHashTable(hashTable1, zobristKey);
        
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
                addToHashTable(hashTable1, zobristKey, 1, bestMove, 0, 1, "played");
            end
        else
            addToHashTable(hashTable1, zobristKey, 1, bestMove, 0, 1, "played");
        end

        board = makeMove(bestMove(1), bestMove(2), bestMove(3), board);
        key = isGameOver(board);
        
        if key == 1
            fprintf("White wins \n");
            return;
        elseif key == 2
            fprintf("Draw by stalemate \n");
            return;
        end
        
        loadBoard(board)
    end
end


function [bestMove, timeTaken] = findBestMove(board, colour, time, hashTable, zKeys, engineName, engineNum, bookTable)
    startTime = tic;
    depth = 1;
    prevBest = [];
    while toc(startTime) < time
        [bestMove, bestValue, ~, booked] = engineName(board, colour, @positionValue, depth, -inf, inf, [], prevBest, hashTable, zKeys, 1, bookTable, 0);
        depth = depth+1;
        prevBest = bestMove;
        if bestValue == inf || bestValue == -inf || booked == 1
            break
        end
    end
    
    timeTaken = toc(startTime);
    if engineNum == 1
        fprintf("%0.2f seconds, %d depth, engine1, %0.1f value\n", toc(startTime), depth, bestValue);
    else
        fprintf("%0.2f seconds, %d depth, engine2, %0.1f value\n", toc(startTime), depth, bestValue);
    end
end


function num = isGameOver(board)
   % 0 not game over, 1 current player wins, 2 is draw
   
    %Get all legal moves for the current player
    legalMoves = getLegalMoves3_mex(board);
    
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
