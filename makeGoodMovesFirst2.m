function moves = makeGoodMovesFirst2(legalMoves, prevBest, board, colour)
% need to estimate how good each move is

% If a piece moves under attack of pawn, its probably bad
if colour == 1
    for i = 1:size(legalMoves, 2)
        postPosY = mod(legalMoves(2,i), 10);
        postPosX = floor(legalMoves(2,i)/10); 
        piece = legalMoves(3,i);
        bored = makeMove(legalMoves(1, i), legalMoves(2, i), legalMoves(3, i), board);
        if fastestamIChecked_mex(bored) == 1
            legalMoves(4, i) = legalMoves(4, i)+1;
        end
        
        
        
        if postPosY-1 > 0 && postPosX+1 < 9
            if bored(postPosY-1, postPosX+1) == 21
                if piece == 15
                    legalMoves(4, i) = legalMoves(4, i)-7;
                elseif piece == 14
                    legalMoves(4, i) = legalMoves(4, i)-4;
                elseif piece == 13
                    legalMoves(4, i) = legalMoves(4, i)-2;
                elseif piece == 12
                    legalMoves(4, i) = legalMoves(4, i)-2;
                end
            end
        end
        
        if postPosY-1 > 0 && postPosX-1 > 0
            if bored(postPosY-1, postPosX-1) == 21
                if piece == 15
                    legalMoves(4, i) = legalMoves(4, i)-7;
                elseif piece == 14
                    legalMoves(4, i) = legalMoves(4, i)-4;
                elseif piece == 13
                    legalMoves(4, i) = legalMoves(4, i)-2;
                elseif piece == 12
                    legalMoves(4, i) = legalMoves(4, i)-2;
                end
            end
        end
    end
end

% 
% %same idea for black pieces under attack
if colour == 2
    for i = 1:size(legalMoves, 2)
        postPosY = mod(legalMoves(2,i), 10);
        postPosX = floor(legalMoves(2,i)/10); 
        piece = legalMoves(3,i);
        
        bored = makeMove(legalMoves(1, i), legalMoves(2, i), legalMoves(3, i), board);
        if fastestamIChecked_mex(bored) == 1
            legalMoves(4, i) = legalMoves(4, i)+1;
        end

        if postPosY+1 < 9 && postPosX+1 < 9
            if bored(postPosY+1, postPosX+1) == 11
                if piece == 25
                    legalMoves(4, i) = legalMoves(4, i)-7;
                elseif piece == 24
                    legalMoves(4, i) = legalMoves(4, i)-4;
                elseif piece == 23
                    legalMoves(4, i) = legalMoves(4, i)-2;
                elseif piece == 22
                    legalMoves(4, i) = legalMoves(4, i)-2;
                end
            end
        end
        
        if postPosY+1 < 9 && postPosX-1 > 0
            if bored(postPosY+1, postPosX-1) == 11
                if piece == 25
                    legalMoves(4, i) = legalMoves(4, i)-7;
                elseif piece == 24
                    legalMoves(4, i) = legalMoves(4, i)-4;
                elseif piece == 23
                    legalMoves(4, i) = legalMoves(4, i)-2;
                elseif piece == 22
                    legalMoves(4, i) = legalMoves(4, i)-2;
                end
            end
        end
    end
end
%        
    

moves = legalMoves;



% Get the third row
third_row = moves(4, :);


% Sort the third row in descending order and get the indices
[~, sorted_indices] = sort(third_row, 'descend');

% Reorder the columns of the vector based on the sorted indices
sorted_vector = moves(:, sorted_indices);

moves = sorted_vector;

if ~isempty(prevBest)
    % Find the index of the previous best move in the legalMoves array
    prevBestIndex = find(all(moves == prevBest, 1));
    
    if ~isempty(prevBestIndex)
        % Move the prevBest move to the front
        moves = [prevBest, moves(:, 1:prevBestIndex-1), moves(:, prevBestIndex+1:end)];
        
        % Update its value to be the same as the value of the move at the second position
        if size(moves, 2) > 1
            if moves(4, 2) > moves(4, 1)
                moves(4, 1) = moves(4, 2);
            end
        end
    end
end

end

function check = fastestamIChecked(board)
    check = false;
    
    
    % Find the location of the kings
    whiteKingRow = 0;
    whiteKingCol = 0;
    blackKingRow = 0;
    blackKingCol = 0;
    for i = 1:8
        for j = 1:8
            if board(i, j) == 16
                whiteKingRow = i;
                whiteKingCol = j;
            elseif board(i, j) == 26
                blackKingRow = i;
                blackKingCol = j;
            elseif whiteKingRow ~= 0 && blackKingRow ~= 0
                break
            end
        end
    end

    % Define directions for each piece type (king excluded as it cannot cause check)
    directions = [
        0, 1;  % East
        0, -1; % West
        1, 0;  % South
        -1, 0; % North
        1, 1;  % South-East
        1, -1; % South-West
        -1, 1; % North-East
        -1, -1 % North-West
    ];

    % Find current players colour
    colour = board(10,1);

    % Check for checks from queens, rooks, and bishops
    for d = 1:size(directions, 1)
        dir = directions(d, :);
        for k = 1:7
            newRowW = whiteKingRow + k * dir(1);
            newColW = whiteKingCol + k * dir(2);
            newRowB = blackKingRow + k * dir(1);
            newColB = blackKingCol + k * dir(2);

            % Check for white king
            if colour == 1
                if newRowW >= 1 && newRowW <= 8 && newColW >= 1 && newColW <= 8
                    targetPiece = board(newRowW, newColW);
                    if (targetPiece == 24 && d < 5) || targetPiece == 25 || (targetPiece == 21 && k == 1 && (d == 7 || d == 8)) || (targetPiece == 23 && d > 4)
                        check = true;
                        return;
                    elseif targetPiece > 10 % A none check piece is blocking path
                        break;
                    end
                end
                
            % Check for black king    
            else
                if newRowB >= 1 && newRowB <= 8 && newColB >= 1 && newColB <= 8
                    targetPiece = board(newRowB, newColB);
                    if (targetPiece == 14 && d < 5) || targetPiece == 15 || (targetPiece == 11 && k == 1 && (d == 5 || d == 6)) || (targetPiece == 13 && d > 4)
                        check = true;
                        return;
                    elseif targetPiece > 10 % A none check piece is blocking path
                        break;
                    end
                end
            end
        end
    end

    % Define knight moves
    knightOffsets = [
        -2, -1;
        -2, 1;
        -1, -2;
        -1, 2;
        1, -2;
        1, 2;
        2, -1;
        2, 1
    ];

    % Check for knight checks
    for k = 1:size(knightOffsets, 1)
        newRowW = whiteKingRow + knightOffsets(k, 1);
        newColW = whiteKingCol + knightOffsets(k, 2);
        newRowB = blackKingRow + knightOffsets(k, 1);
        newColB = blackKingCol + knightOffsets(k, 2);

        if colour == 1 % White
            if newRowW >= 1 && newRowW <= 8 && newColW >= 1 && newColW <= 8
                if board(newRowW, newColW) == 22
                    check = true;
                    return;
                end
            end
            
        else %Black
            if newRowB >= 1 && newRowB <= 8 && newColB >= 1 && newColB <= 8
                if board(newRowB, newColB) == 12
                    check = true;
                    return;
                end
            end
        end
    end

    % Check for adjacent kings
    if abs(whiteKingRow - blackKingRow) < 2 && abs(whiteKingCol - blackKingCol) < 2
        check = true;
        return;
    end
end

function board = makeMove(priorPos, postPos, piece, board)
    % Find the location of the piece
    priorPosY = mod(priorPos, 10);
    priorPosX = floor(priorPos/10);

    postPosY = mod(postPos, 10);
    postPosX = floor(postPos/10);

    % white pawn en passant
    if (piece == 11 && priorPosY ~= postPosY && board(postPosX, postPosY) == 0)
        board(postPosX+1, postPosY) = 0;
    end
    
    % black pawn en passant
    if (piece == 21 && priorPosY ~= postPosY && board(postPosX, postPosY) == 0)
        board(postPosX-1, postPosY) = 0;
    end
    
    
    board(postPosX, postPosY) = piece;
    board(priorPosX, priorPosY) = 0;
    if (piece == 26)
       board(9,4) = 1; 
    end
    if (piece == 16)
       board(9,1) = 1; 
    end
    
    if (piece == 14) && priorPos == 81
       board(9,2) = 1; 
    end
    
    if (piece == 14) && priorPos == 88
       board(9,3) = 1; 
    end
    
    if (piece == 24) && priorPos == 11
       board(9,5) = 1; 
    end
    
    if (piece == 24) && priorPos == 18
       board(9,6) = 1; 
    end
    
    % black castling
    if (piece == 26) && abs(priorPosY-postPosY) > 1
        if postPos == 13
            board(1, 4) = 24;
            board(1, 1) = 0;
            board(10, 4) = 1; %left black castle
        elseif postPos == 17
            board(1, 6) = 24;
            board(1, 8) = 0;
            board(10, 5) = 1;%right black castle
        end
    end
    
    % white castling
    if (piece == 16) && abs(priorPosY-postPosY) > 1
        if postPos == 83
            board(8, 4) = 14;
            board(8, 1) = 0;
            board(10, 2) = 1; %left white castle
        elseif postPos == 87
            board(8, 6) = 14;
            board(8, 8) = 0;
            board(10, 2) = 1; %left right castle
        end
    end
    
    if (piece == 11) && abs(priorPosX-postPosX) > 1
        board(9, 7) = postPosY; % black can en passant 
    else 
         board(9, 7) = 0;
    end
    
    if (piece == 12) && abs(priorPosX-postPosX) > 1
        board(9, 8) = postPosY; % white can en passant 
    else 
         board(9, 8) = 0;
    end
    
    % white moved so its now blacks turn
    if piece > 10 && piece < 20
        board(10,1) = 2;
    else
        % Otherwise black moved so its whites turn
        board(10,1) = 1;
    end
end