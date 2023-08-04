function testEnginess()
    bookTable = load('bookTable.mat');

    % Example usage with the initial board state
    board1 = initialiseBoard();
    board1 = makeMove(75, 55, 11, board1);
    board1 = makeMove(25, 45, 21, board1);
    board2 = initialiseBoard2();
    board3 = initialiseBoard3();
    board4 = initialiseBoard4();
    board5 = initialiseBoard5();
    board6 = initialiseBoard6();
    board7 = initialiseBoard7();
    board8 = initialiseBoard8();
    board9 = initialiseBoard9();
    board10 = initialiseBoard10();
    boards1 = initialiseBoards();
    boards2 = {board10, board1, board2, board3, board4, board5, board6, board7, board8, board9};
    boards = [boards1, boards2];
    
    engine1 = @engine3;
    engine2 = @engine2;
    baseStrength = 0.02;
    draws = 0;
    engine1Wins = 0;
    engine2Wins = 0;
    engine1Time = 0;
    engine2Time = 0;
    
    % Run the gameLoop switching sides after each game
    for j = 1:3
        strength = baseStrength * j;
        for i = 1:56
            board = boards{i};
            loadBoard(board);
            [whiteWins, blackWins, drawss, time1, time2] = gameLoop(board, engine1, engine2, strength, bookTable);
            draws = draws + drawss
            engine1Wins = engine1Wins + whiteWins
            engine2Wins = engine2Wins + blackWins
            engine1Time = engine1Time + time1;
            engine2Time = engine2Time + time2;
            [whiteWins, blackWins, drawss, time1, time2] = gameLoop(board, engine2, engine1, strength, bookTable);
            draws = draws + drawss
            engine2Wins = engine2Wins + whiteWins
            engine1Wins = engine1Wins + blackWins
            engine2Time = engine2Time + time1;
            engine1Time = engine1Time + time2;
        end
    end

    % Display the final results
    disp("Engine1 Wins: " + engine1Wins);
    disp("Engine2 Wins: " + engine2Wins);
    disp("Draws: " + draws);
    disp("Engine1 Time: " + engine1Time);
    disp("Engine2 Time: " + engine2Time);
end

function [whiteWins, blackWins, draws, engine1Time, engine2Time] = gameLoop(board, engine1, engine2, strength, bookTable)
    rng(5259408);
    zKeys = uint64(randperm(2^52, 800));
    hashTable1 = createHashTable();
    hashTable2 = createHashTable();
    moves = 0;
    whiteWins = 0;
    blackWins = 0;
    draws = 0;
    engine1Time = 0;
    engine2Time = 0;
    while (true)
        [bestMove, timeTaken] = findBestMove(board, 1, strength, hashTable1, zKeys, engine1, 1, bookTable);
        engine1Time = engine1Time + timeTaken;
        zobristKey = calculateZobristKeys2_mex(board, zKeys);
        % Retrieve the stored information for the position
        
        storedData = retrieveFromHashTable(hashTable1, zobristKey);
        
        % Check if the current position is in the hash table
        if ~isempty(storedData)
            if storedData.flag == "played" && storedData.colour == 1
                depf = storedData.depth + 1;
                addToHashTable(hashTable1, zobristKey, depf, bestMove, 0, 1, "played");
                if depf == 3
                    draws = 1; 
                    fprintf("Draw by repitition \n");
                    return;
                end  
            else
                addToHashTable(hashTable1, zobristKey, 1, bestMove, 0, 1, "played");
            end
        else
            addToHashTable(hashTable1, zobristKey, 1, bestMove, 0, 1, "played");
        end
        
        storedData = retrieveFromHashTable(hashTable2, zobristKey);
        
        % Check if the current position is in the hash table
        if ~isempty(storedData)
            if storedData.flag == "played" && storedData.colour == 1
                depf = storedData.depth + 1;
                addToHashTable(hashTable2, zobristKey, depf, bestMove, 0, 1, "played");
                if depf == 3
                    draws = 1; 
                    fprintf("Draw by repitition \n");
                    return;
                end  
            else
                addToHashTable(hashTable2, zobristKey, 1, bestMove, 0, 1, "played");
            end
        else
            addToHashTable(hashTable2, zobristKey, 1, bestMove, 0, 1, "played");
        end

        board = makeMove(bestMove(1), bestMove(2), bestMove(3), board);
        key = isGameOver(board);

        if key == 1
            whiteWins = 1;
            return;
        elseif key == 2
            draws = 1;
            fprintf("Draw by stalemate \n");
            return;
        end
        

        [bestMove, timeTaken] = findBestMove(board, 2, strength, hashTable2, zKeys, engine2, 2, bookTable);
        engine2Time = engine2Time + timeTaken;
        zobristKey = calculateZobristKeys2_mex(board, zKeys);
        % Retrieve the stored information for the position
        storedData = retrieveFromHashTable(hashTable2, zobristKey);

        % Check if the current position is in the hash table
        if ~isempty(storedData)
            if storedData.flag == "played" && storedData.colour == 2
                depf = storedData.depth + 1;
                addToHashTable(hashTable2, zobristKey, depf, bestMove, 0, 2, "played");
                if depf == 3
                    draws = 1; 
                    fprintf("Draw by repitition \n");
                    return;
                end  
            else
                addToHashTable(hashTable2, zobristKey, 1, bestMove, 0, 2, "played");
            end
        else
            addToHashTable(hashTable2, zobristKey, 1, bestMove, 0, 2, "played");
        end
        
        storedData = retrieveFromHashTable(hashTable1, zobristKey);
        % Check if the current position is in the hash table
        if ~isempty(storedData)
            if storedData.flag == "played" && storedData.colour == 2
                depf = storedData.depth + 1;
                addToHashTable(hashTable1, zobristKey, depf, bestMove, 0, 2, "played");
                if depf == 3
                    draws = 1; 
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
        if key == 1
            blackWins = 1;
            return;
        elseif key == 2
            draws = 1;
            fprintf("Draw by stalemate \n");
            return;
        end
        moves = moves + 1;
        
        if moves > 150
           draws = 1;
           fprintf("TOO MANY MOVES \n");
           return;
        end
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
        if bestValue == inf || bestValue == -inf || booked
            break
        end
    end
    
    timeTaken = toc(startTime);
%     if engineNum == 1
%         fprintf("%0.2f seconds, %d depth, engine1 \n", toc(startTime), depth);
%     else
%         fprintf("%0.2f seconds, %d depth, engine2 \n", toc(startTime), depth);
%     end
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