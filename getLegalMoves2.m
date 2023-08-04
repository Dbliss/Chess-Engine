function actualLegalMoves = getLegalMoves2(board)
    % Declare fastamIChecked_mex as an extrinsic function
    coder.extrinsic('fastamIChecked_mex');

    % Preallocate memory for legalMoves with the maximum possible number of moves
    maxNumMoves = 200;
    legalMoves = zeros(5, maxNumMoves);
    z = 1;
    
    % Define knight move offsets
    knightOffsets = [-2, -1; -1, -2; 1, -2; 2, -1; -2, 1; -1, 2; 1, 2; 2, 1];
    colour = board(10,1);
    for i = 1:8
        for j = 1:8
            piece = board(i, j);
            
            if colour == 1
                % White Pawns
                if piece == 11
                    newRow = i - 1;

                    % Move pawn twice if it's at the start
                    if i == 7 && board(i - 1, j) == 0 && board(i - 2, j) == 0
                        priorPos = i * 10 + j;
                        postPos = (i - 2) * 10 + j;
                        legalMoves(:, z) = [priorPos, postPos, 11, 1, 1];
                        z = z + 1;
                    end

                    % Move pawn once if the spot ahead is free
                    if newRow >= 1 && board(newRow, j) == 0
                        priorPos = i * 10 + j;
                        postPos = newRow * 10 + j;
                        if newRow == 1
                            legalMoves(:, z) = [priorPos, postPos, 15, 12, 1];
                        else
                            legalMoves(:, z) = [priorPos, postPos, 11, 1, 1];
                        end
                        z = z + 1;
                    end

                    % Pawn attacking left diagonal
                    if newRow >= 1 && j > 1 && board(newRow, j - 1) > 20
                        priorPos = i * 10 + j;
                        postPos = newRow * 10 + j - 1;
                        value = board(newRow, j - 1) - 20;
                        if newRow == 1
                            legalMoves(:, z) = [priorPos, postPos, 15, 11 + value, 2];
                        else
                            legalMoves(:, z) = [priorPos, postPos, 11, 1 + value, 2];
                        end
                        z = z + 1;
                    end

                    % Pawn attacking right diagonal
                    if newRow >= 1 && j < 8 && board(newRow, j + 1) > 20
                        priorPos = i * 10 + j;
                        postPos = newRow * 10 + j + 1;
                        value = board(newRow, j + 1) - 20;
                        if newRow == 1
                            legalMoves(:, z) = [priorPos, postPos, 15, 11 + value, 2];
                        else
                            legalMoves(:, z) = [priorPos, postPos, 11, 1 + value, 2];
                        end
                        z = z + 1;
                    end

                    % En passant left
                    if i == 4 && j > 1 && board(9, 8) == (j - 1)
                        priorPos = i * 10 + j;
                        postPos = (i - 1) * 10 + j - 1;
                        legalMoves(:, z) = [priorPos, postPos, 11, 2, 2];
                        z = z + 1;
                    end

                    % En passant right
                    if i == 4 && j < 8 && board(9, 8) == (j + 1)
                        priorPos = i * 10 + j;
                        postPos = (i - 1) * 10 + j + 1;
                        legalMoves(:, z) = [priorPos, postPos, 11, 2, 2];
                        z = z + 1;
                    end

                % White Knights
                elseif piece == 12 
                    for k = 1:size(knightOffsets, 1)
                        rowOffset = knightOffsets(k, 1);
                        colOffset = knightOffsets(k, 2);
                        newRow = i + rowOffset;
                        newCol = j + colOffset;

                        % Check if the new position is on the board and empty or contains an opponent piece
                        if newRow >= 1 && newRow <= 8 && newCol >= 1 && newCol <= 8 && ...
                           (board(newRow, newCol) == 0 || board(newRow, newCol) > 20)

                            priorPos = i * 10 + j;
                            postPos = newRow * 10 + newCol;

                            % Check if the move results in a capture or a normal move
                            moveType = 1;
                            if board(newRow, newCol) > 20
                                moveType = 2;
                            end

                            legalMoves(:, z) = [priorPos, postPos, 12, 0, moveType];
                            z = z + 1;
                        end
                    end

                % White Bishops
                elseif piece == 13
                    directions = [-1, 1];
                    for rowDir = directions
                        for colDir = directions
                            for k = 1:7
                                newRow = i + k * rowDir;
                                newCol = j + k * colDir;

                                if newRow >= 1 && newRow <= 8 && newCol >= 1 && newCol <= 8
                                    targetPiece = board(newRow, newCol);
                                    priorPos = i * 10 + j;
                                    postPos = newRow * 10 + newCol;

                                    if targetPiece == 0 || targetPiece > 20
                                        if targetPiece == 0
                                            legalMoves(:, z) = [priorPos, postPos, 13, 0, 1];
                                        else
                                            value = targetPiece - 20;
                                            legalMoves(:, z) = [priorPos, postPos, 13, value, 2];
                                            z = z + 1;
                                            break; % Stop searching in this direction if blocked by a piece
                                        end
                                        z = z + 1;
                                    else
                                        break; % Stop searching in this direction if blocked by a piece
                                    end
                                else
                                    break; % Stop searching if outside the board boundaries
                                end
                            end
                        end
                    end

                % White Rooks
                elseif piece == 14
                    directions = [-1, 1];
                    for rowDir = directions
                        newRow = i + rowDir;
                        while newRow >= 1 && newRow <= 8
                            targetPiece = board(newRow, j);
                            priorPos = i * 10 + j;
                            postPos = newRow * 10 + j;

                            if targetPiece == 0 || targetPiece > 20
                                if targetPiece == 0
                                    legalMoves(:, z) = [priorPos, postPos, 14, 0, 1];
                                else
                                    value = targetPiece - 20;
                                    legalMoves(:, z) = [priorPos, postPos, 14, value, 2];
                                    z = z + 1;
                                    break; % Stop searching in this direction if blocked by a piece
                                end
                                z = z + 1;
                            else
                                break; % Stop searching in this direction if blocked by a piece
                            end

                            newRow = newRow + rowDir;
                        end
                    end

                    for colDir = directions
                        newCol = j + colDir;
                        while newCol >= 1 && newCol <= 8
                            targetPiece = board(i, newCol);
                            priorPos = i * 10 + j;
                            postPos = i * 10 + newCol;

                            if targetPiece == 0 || targetPiece > 20
                                if targetPiece == 0
                                    legalMoves(:, z) = [priorPos, postPos, 14, 0, 1];
                                else
                                    value = targetPiece - 20;
                                    legalMoves(:, z) = [priorPos, postPos, 14, value, 2];
                                    z = z + 1;
                                    break; % Stop searching in this direction if blocked by a piece
                                end
                                z = z + 1;
                            else
                                break; % Stop searching in this direction if blocked by a piece
                            end

                            newCol = newCol + colDir;
                        end
                    end


                % White Queen
                elseif piece == 15
                    directions = [-1, 1];

                    % East, West movements (same as rook)
                    for rowDir = directions
                        newRow = i + rowDir;
                        while newRow >= 1 && newRow <= 8
                            targetPiece = board(newRow, j);
                            priorPos = i * 10 + j;
                            postPos = newRow * 10 + j;

                            if targetPiece == 0 || targetPiece > 20
                                if targetPiece == 0
                                    legalMoves(:, z) = [priorPos, postPos, 15, 0, 1];
                                else
                                    value = targetPiece - 20;
                                    legalMoves(:, z) = [priorPos, postPos, 15, value, 2];
                                    z = z + 1;
                                    break; % Stop searching in this direction if blocked by a piece
                                end
                                z = z + 1;
                            else
                                break; % Stop searching in this direction if blocked by a piece
                            end

                            newRow = newRow + rowDir;
                        end
                    end

                    % North, South movements (same as rook)
                    for colDir = directions
                        newCol = j + colDir;
                        while newCol >= 1 && newCol <= 8
                            targetPiece = board(i, newCol);
                            priorPos = i * 10 + j;
                            postPos = i * 10 + newCol;

                            if targetPiece == 0 || targetPiece > 20
                                if targetPiece == 0
                                    legalMoves(:, z) = [priorPos, postPos, 15, 0, 1];
                                else
                                    value = targetPiece - 20;
                                    legalMoves(:, z) = [priorPos, postPos, 15, value, 2];
                                    z = z + 1;
                                    break; % Stop searching in this direction if blocked by a piece
                                end
                                z = z + 1;
                            else
                                break; % Stop searching in this direction if blocked by a piece
                            end

                            newCol = newCol + colDir;
                        end
                    end

                    % Northeast, Northwest, Southeast, Southwest movements (same as bishop)
                    for rowDir = directions
                        for colDir = directions
                            newI = i + rowDir;
                            newJ = j + colDir;
                            while newI >= 1 && newI <= 8 && newJ >= 1 && newJ <= 8
                                targetPiece = board(newI, newJ);
                                priorPos = i * 10 + j;
                                postPos = newI * 10 + newJ;

                                if targetPiece == 0 || targetPiece > 20
                                    if targetPiece == 0
                                        legalMoves(:, z) = [priorPos, postPos, 15, 0, 1];
                                    else
                                        value = targetPiece - 20;
                                        legalMoves(:, z) = [priorPos, postPos, 15, value, 2];
                                        z = z + 1;
                                        break; % Stop searching in this direction if blocked by a piece
                                    end
                                    z = z + 1;
                                else
                                    break; % Stop searching in this direction if blocked by a piece
                                end

                                newI = newI + rowDir;
                                newJ = newJ + colDir;
                            end
                        end
                    end

                % White King
                elseif piece == 16
                    directions = [-1, 0, 1];

                    for rowDir = directions
                        for colDir = directions
                            if rowDir == 0 && colDir == 0
                                continue; % Skip the current position (king doesn't move here)
                            end

                            newRow = i + rowDir;
                            newCol = j + colDir;

                            if newRow >= 1 && newRow <= 8 && newCol >= 1 && newCol <= 8
                                targetPiece = board(newRow, newCol);
                                priorPos = i * 10 + j;
                                postPos = newRow * 10 + newCol;

                                if targetPiece == 0 || targetPiece > 20
                                    if targetPiece == 0
                                        legalMoves(:, z) = [priorPos, postPos, 16, 0, 1];
                                    else
                                        value = targetPiece - 20;
                                        legalMoves(:, z) = [priorPos, postPos, 16, value, 2];
                                    end
                                    z = z + 1;
                                end
                            end
                        end
                    end

                    % Left Castle
                    if board(8, 2) == 0 && board(8, 3) == 0 && board(8, 4) == 0 && board(9, 2) == 0 && board(9, 1) == 0 && board(8, 1) == 14
                        check = fastamIChecked_mex(board);
                        if ~check
                            fakeBoard = makeMove(85, 84, 16, board);
                            fakeBoard(10,1) = 1;
                            check = fastamIChecked_mex(fakeBoard);
                            if ~check
                                fakeBoard = makeMove(84, 83, 16, fakeBoard);
                                fakeBoard(10,1) = 1;
                                check = fastamIChecked_mex(fakeBoard);
                                if ~check
                                    legalMoves(:, z) = [85, 83, 16, 3, 1];
                                    z = z + 1;
                                end
                            end
                        end
                    end

                    % Right Castle
                    if board(8, 6) == 0 && board(8, 7) == 0 && board(9, 3) == 0 && board(9, 1) == 0 && board(8, 8) == 14
                        check = fastamIChecked_mex(board);
                        if ~check
                            fakeBoard = makeMove(85, 86, 16, board);
                            fakeBoard(10,1) = 1;
                            check = fastamIChecked_mex(fakeBoard);
                            if ~check
                                fakeBoard = makeMove(86, 87, 16, fakeBoard);
                                fakeBoard(10,1) = 1;
                                check = fastamIChecked_mex(fakeBoard);
                                if ~check
                                    legalMoves(:, z) = [85, 87, 16, 3, 1];
                                    z = z + 1;
                                end
                            end
                        end
                    end
                end
            else
                
                
                
                % Black pawns
                if piece == 21
                    newRow = i + 1;

                    % Move pawn twice if it's at the start
                    if i == 2 && board(i + 1, j) == 0 && board(i + 2, j) == 0
                        priorPos = i * 10 + j;
                        postPos = (i + 2) * 10 + j;
                        legalMoves(:, z) = [priorPos, postPos, 21, 1, 1];
                        z = z + 1;
                    end

                    % Move pawn once if the spot ahead is free
                    if newRow <= 8 && board(newRow, j) == 0
                        priorPos = i * 10 + j;
                        postPos = newRow * 10 + j;
                        if newRow == 8
                            legalMoves(:, z) = [priorPos, postPos, 25, 12, 1];
                        else
                            legalMoves(:, z) = [priorPos, postPos, 21, 1, 1];
                        end
                        z = z + 1;
                    end

                    % Pawn attacking left diagonal
                    if newRow <= 8 && j > 1 && board(newRow, j - 1) > 0 && board(newRow, j - 1) <= 20
                        priorPos = i * 10 + j;
                        postPos = newRow * 10 + j - 1;
                        value = board(newRow, j - 1);
                        if newRow == 8
                            legalMoves(:, z) = [priorPos, postPos, 25, 11 + value, 2];
                        else
                            legalMoves(:, z) = [priorPos, postPos, 21, 1 + value, 2];
                        end
                        z = z + 1;
                    end

                    % Pawn attacking right diagonal
                    if newRow <= 8 && j < 8 && board(newRow, j + 1) > 0 && board(newRow, j + 1) <= 20
                        priorPos = i * 10 + j;
                        postPos = newRow * 10 + j + 1;
                        value = board(newRow, j + 1);
                        if newRow == 8
                            legalMoves(:, z) = [priorPos, postPos, 25, 11 + value, 2];
                        else
                            legalMoves(:, z) = [priorPos, postPos, 21, 1 + value, 2];
                        end
                        z = z + 1;
                    end

                    % En passant left
                    if i == 5 && j > 1 && board(9, 7) == (j - 1)
                        priorPos = i * 10 + j;
                        postPos = (i + 1) * 10 + j - 1;
                        legalMoves(:, z) = [priorPos, postPos, 21, 2, 2];
                        z = z + 1;
                    end

                    % En passant right
                    if i == 5 && j < 8 && board(9, 7) == (j + 1)
                        priorPos = i * 10 + j;
                        postPos = (i + 1) * 10 + j + 1;
                        legalMoves(:, z) = [priorPos, postPos, 21, 2, 2];
                        z = z + 1;
                    end

                % Black Knights
                elseif piece == 22
                    for k = 1:size(knightOffsets, 1)
                        rowOffset = knightOffsets(k, 1);
                        colOffset = knightOffsets(k, 2);
                        newRow = i + rowOffset;
                        newCol = j + colOffset;

                        % Check if the new position is on the board and empty or contains an opponent piece
                        if newRow >= 1 && newRow <= 8 && newCol >= 1 && newCol <= 8 && ...
                           (board(newRow, newCol) <= 20) % Here we check for an opponent piece (<= 20)

                            priorPos = i * 10 + j;
                            postPos = newRow * 10 + newCol;

                            % Check if the move results in a capture or a normal move
                            moveType = 1;
                            if board(newRow, newCol) ~= 0 % Here we check if it's a capture (<= 20)
                                moveType = 2;
                            end
                            value = board(newRow, newCol) - 10;
                            legalMoves(:, z) = [priorPos, postPos, 22, value, moveType];
                            z = z + 1;
                        end
                    end

                % Black Bishops
                elseif piece == 23
                    directions = [-1, 1];
                    for rowDir = directions
                        for colDir = directions
                            for k = 1:7
                                newRow = i + k * rowDir;
                                newCol = j + k * colDir;

                                if newRow >= 1 && newRow <= 8 && newCol >= 1 && newCol <= 8
                                    targetPiece = board(newRow, newCol);
                                    priorPos = i * 10 + j;
                                    postPos = newRow * 10 + newCol;

                                    if targetPiece <= 20 % Here we check for an opponent piece (<= 20)
                                        if targetPiece == 0
                                            legalMoves(:, z) = [priorPos, postPos, 23, 0, 1];
                                        else
                                            value = targetPiece - 10;
                                            legalMoves(:, z) = [priorPos, postPos, 23, value, 2];
                                            z = z + 1;
                                            break; % Stop searching in this direction if blocked by a piece
                                        end
                                        z = z + 1;
                                    else
                                        break; % Stop searching in this direction if blocked by a piece
                                    end
                                else
                                    break; % Stop searching if outside the board boundaries
                                end
                            end
                        end
                    end

                % Black Rooks
                elseif piece == 24
                    directions = [-1, 1];
                    for rowDir = directions
                        newRow = i + rowDir;
                        while newRow >= 1 && newRow <= 8
                            targetPiece = board(newRow, j);
                            priorPos = i * 10 + j;
                            postPos = newRow * 10 + j;

                            if targetPiece <= 20 % Here we check for an opponent piece (<= 20)
                                if targetPiece == 0
                                    legalMoves(:, z) = [priorPos, postPos, 24, 0, 1];
                                else
                                    value = targetPiece - 10;
                                    legalMoves(:, z) = [priorPos, postPos, 24, value, 2];
                                    z = z + 1;
                                    break; % Stop searching in this direction if blocked by a piece
                                end
                                z = z + 1;
                            else
                                break; % Stop searching in this direction if blocked by a piece
                            end

                            newRow = newRow + rowDir;
                        end
                    end

                    for colDir = directions
                        newCol = j + colDir;
                        while newCol >= 1 && newCol <= 8
                            targetPiece = board(i, newCol);
                            priorPos = i * 10 + j;
                            postPos = i * 10 + newCol;

                            if targetPiece <= 20 % Here we check for an opponent piece (<= 20)
                                if targetPiece == 0
                                    legalMoves(:, z) = [priorPos, postPos, 24, 0, 1];
                                else
                                    value = targetPiece - 10;
                                    legalMoves(:, z) = [priorPos, postPos, 24, value, 2];
                                    z = z + 1;
                                    break; % Stop searching in this direction if blocked by a piece
                                end
                                z = z + 1;
                            else
                                break; % Stop searching in this direction if blocked by a piece
                            end

                            newCol = newCol + colDir;
                        end
                    end

                % Black Queen
                elseif piece == 25
                    directions = [-1, 1];

                    % East, West movements (same as rook)
                    for rowDir = directions
                        newRow = i + rowDir;
                        while newRow >= 1 && newRow <= 8
                            targetPiece = board(newRow, j);
                            priorPos = i * 10 + j;
                            postPos = newRow * 10 + j;

                            if targetPiece <= 20 % Here we check for an opponent piece (<= 20)
                                if targetPiece == 0
                                    legalMoves(:, z) = [priorPos, postPos, 25, 0, 1];
                                else
                                    value = targetPiece - 10;
                                    legalMoves(:, z) = [priorPos, postPos, 25, value, 2];
                                    z = z + 1;
                                    break; % Stop searching in this direction if blocked by a piece
                                end
                                z = z + 1;
                            else
                                break; % Stop searching in this direction if blocked by a piece
                            end

                            newRow = newRow + rowDir;
                        end
                    end

                    % North, South movements (same as rook)
                    for colDir = directions
                        newCol = j + colDir;
                        while newCol >= 1 && newCol <= 8
                            targetPiece = board(i, newCol);
                            priorPos = i * 10 + j;
                            postPos = i * 10 + newCol;

                            if targetPiece <= 20 % Here we check for an opponent piece (<= 20)
                                if targetPiece == 0
                                    legalMoves(:, z) = [priorPos, postPos, 25, 0, 1];
                                else
                                    value = targetPiece - 10;
                                    legalMoves(:, z) = [priorPos, postPos, 25, value, 2];
                                    z = z + 1;
                                    break; % Stop searching in this direction if blocked by a piece
                                end
                                z = z + 1;
                            else
                                break; % Stop searching in this direction if blocked by a piece
                            end

                            newCol = newCol + colDir;
                        end
                    end

                    % Northeast, Northwest, Southeast, Southwest movements (same as bishop)
                    for rowDir = directions
                        for colDir = directions
                            newI = i + rowDir;
                            newJ = j + colDir;
                            while newI >= 1 && newI <= 8 && newJ >= 1 && newJ <= 8
                                targetPiece = board(newI, newJ);
                                priorPos = i * 10 + j;
                                postPos = newI * 10 + newJ;

                                if targetPiece <= 20 % Here we check for an opponent piece (<= 20)
                                    if targetPiece == 0
                                        legalMoves(:, z) = [priorPos, postPos, 25, 0, 1];
                                    else
                                        value = targetPiece - 10;
                                        legalMoves(:, z) = [priorPos, postPos, 25, value, 2];
                                        z = z + 1;
                                        break; % Stop searching in this direction if blocked by a piece
                                    end
                                    z = z + 1;
                                else
                                    break; % Stop searching in this direction if blocked by a piece
                                end

                                newI = newI + rowDir;
                                newJ = newJ + colDir;
                            end
                        end
                    end

                % Black King
                elseif piece == 26
                    directions = [-1, 0, 1];

                    for rowDir = directions
                        for colDir = directions
                            if rowDir == 0 && colDir == 0
                                continue; % Skip the current position (king doesn't move here)
                            end

                            newRow = i + rowDir;
                            newCol = j + colDir;

                            if newRow >= 1 && newRow <= 8 && newCol >= 1 && newCol <= 8
                                targetPiece = board(newRow, newCol);
                                priorPos = i * 10 + j;
                                postPos = newRow * 10 + newCol;

                                if targetPiece <= 20 % Here we check for an opponent piece (<= 20)
                                    if targetPiece == 0
                                        legalMoves(:, z) = [priorPos, postPos, 26, 0, 1];
                                    else
                                        value = targetPiece - 10;
                                        legalMoves(:, z) = [priorPos, postPos, 26, value, 2];
                                    end
                                    z = z + 1;
                                end
                            end
                        end
                    end

                    % Left Castle
                    if board(1, 2) == 0 && board(1, 3) == 0 && board(1, 4) == 0 && board(9,5) == 0 && board(9,4) == 0 && board(1,1) == 24
                        check = fastamIChecked_mex(board);
                        if ~check
                            fakeBoard = makeMove(15, 14, 26, board);
                            fakeBoard(1,1) = 2;
                            check = fastamIChecked_mex(fakeBoard);
                            if ~check
                                fakeBoard = makeMove(14, 13, 26, fakeBoard);
                                fakeBoard(1,1) = 2;
                                check = fastamIChecked_mex(fakeBoard);
                                if ~check
                                    legalMoves(:, z) = [15, 13, 26, 3, 1];
                                    z = z + 1;
                                end
                            end
                        end
                    end

                    % Right Castle
                    if board(1, 6) == 0 && board(1, 7) == 0 && board(9,6) == 0 && board(9,4) == 0 && board(1,8) == 24
                        check = fastamIChecked_mex(board);
                        if ~check
                            fakeBoard = makeMove(15, 16, 26, board);
                            fakeBoard(1,1) = 2;
                            check = fastamIChecked_mex(fakeBoard);
                            if ~check
                                fakeBoard = makeMove(16, 17, 26, fakeBoard);
                                fakeBoard(1,1) = 2;
                                check = fastamIChecked_mex(fakeBoard);
                                if ~check
                                    legalMoves(:, z) = [15, 17, 26, 3, 1];
                                    z = z + 1;
                                end
                            end
                        end
                    end         
                end
            end
        end
    end

    % Remove any unused rows in the legalMoves array
    legalMoves = legalMoves(:, 1:z - 1);
    
    actualLegalMoves = zeros(5, z);
    j = 1;
    for i = 1:size(legalMoves, 2)
        testerBoard = makeMove(legalMoves(1, i), legalMoves(2, i),legalMoves(3, i), board);
        if board(10,1) == 1
            testerBoard(10, 1) = 1;
        else
            testerBoard(10, 1) = 2;
        end
        checked = fastamIChecked_mex(testerBoard);
        if ~checked
            actualLegalMoves(:, j) = legalMoves(:, i);
            j = j+1;
        end
    end
    actualLegalMoves = actualLegalMoves(:, 1:(j-1));
end