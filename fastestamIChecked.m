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