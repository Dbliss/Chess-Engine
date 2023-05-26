function legalMoves = getLegalMoves(board, colour)
% Declare the MEX file function as extrinsic
coder.extrinsic('fastamIChecked_mex');
% Legal moves will be stored as a row vector
%[PriorPosition, PostPosition, Piece, estimated move value, quiet/take(1/2)]
% white = 1, black = 2
legalMoves = zeros(5,200);
z = 1;
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

if colour == 1
    for i=1:8
        for j=1:8
            % Pawns
            if board(i, j) == 11
                % moving pawn twice if its at the start
                if i == 7 
                    if (board(i-1, j) == 0) && (board(i-2, j) == 0)
                        priorPos = i*10+j;
                        postPos = (i-2)*10+j;
                        % are pieces on same row diag or col?
                        if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                            legalMoves(:,z) = [priorPos, postPos, 11, 1, 1];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 11, board);
                            check = fastamIChecked_mex(testerBoard, 1);
                            if (check == false)
                                legalMoves(:,z) = [priorPos, postPos, 11, 1, 1];
                                z = z + 1;
                            end
                        end
                    end
                end
                
                % moving pawn once if spot ahead is free
                if i > 1
                    if board(i-1, j) == 0
                        priorPos = i*10+j;
                        postPos = (i-1)*10+j;
                        % are pieces on same row diag or col?
                        if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                            if i-1 == 1
                                legalMoves(:,z) = [priorPos, postPos, 15, 12, 1];
                                z = z + 1;
                            else
                                legalMoves(:,z) = [priorPos, postPos, 11, 1, 1];
                                z = z + 1;
                            end
                        else
                            testerBoard = makeMove(priorPos, postPos, 11, board);
                            check = fastamIChecked_mex(testerBoard, 1);
                            if (check == false)
                                if i-1 == 1
                                    legalMoves(:,z) = [priorPos, postPos, 15, 12, 1];
                                    z = z + 1;
                                else
                                    legalMoves(:,z) = [priorPos, postPos, 11, 1, 1];
                                    z = z + 1;
                                end
                            end
                        end
                    end
                end
                
                if (i > 1 && j > 1)
                    % pawn attacking left diagonal
                    if board(i-1, j-1) > 20
                        priorPos = i*10+j;
                        postPos = (i-1)*10+j-1;
                        % are pieces on same row diag or col?
                        if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                            if i-1 == 1
                                value = board(i-1, j-1) - 20;
                                legalMoves(:,z) = [priorPos, postPos, 15, 11+value, 2];
                                z = z + 1;
                            else
                                value = board(i-1, j-1) - 20;
                                legalMoves(:,z) = [priorPos, postPos, 11, 1+value, 2];
                                z = z + 1;
                            end
                        else
                            testerBoard = makeMove(priorPos, postPos, 11, board);
                            check = fastamIChecked_mex(testerBoard, 1);
                            if (check == false)
                                if i-1 == 1
                                    value = board(i-1, j-1) - 20;
                                    legalMoves(:,z) = [priorPos, postPos, 15, 11+value, 2];
                                    z = z + 1;
                                else
                                    value = board(i-1, j-1) - 20;
                                    legalMoves(:,z) = [priorPos, postPos, 11, 1+value, 2];
                                    z = z + 1;
                                end
                            end
                        end
                    end
                end
                
                if (i > 1 && j < 8)
                    % pawn attacking right diagonal
                    if board(i-1, j+1) > 20
                        priorPos = i*10+j;
                        postPos = (i-1)*10+j+1;
                        % are pieces on same row diag or col?
                        if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                            if i-1 == 1
                                value = board(i-1, j+1) - 20;
                                legalMoves(:,z) = [priorPos, postPos, 15, 11+value, 2];
                                z = z + 1;
                            else
                                value = board(i-1, j+1) - 20;
                                legalMoves(:,z) = [priorPos, postPos, 11, 1+value, 2];
                                z = z + 1;
                            end
                        else
                            testerBoard = makeMove(priorPos, postPos, 11, board);
                            check = fastamIChecked_mex(testerBoard, 1);
                            if (check == false)
                                if i-1 == 1
                                    value = board(i-1, j+1) - 20;
                                    legalMoves(:,z) = [priorPos, postPos, 15, 11+value, 2];
                                    z = z + 1;
                                else
                                    value = board(i-1, j+1) - 20;
                                    legalMoves(:,z) = [priorPos, postPos, 11, 1+value, 2];
                                    z = z + 1;
                                end
                            end
                        end
                    end
                end
                
                %en passant left
                if (j > 1)
                    if (i == 4) && board(9,8) == (j-1)
                        priorPos = i*10+j;
                        postPos = (i-1)*10+j-1;
                        % are pieces on same row diag or col?
                        if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                            legalMoves(:,z) = [priorPos, postPos, 11, 2, 2];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 11, board);
                            check = fastamIChecked_mex(testerBoard, 1);
                            if (check == false)
                                legalMoves(:,z) = [priorPos, postPos, 11, 2, 2];
                                z = z + 1;
                            end
                        end
                    end
                end
                
                %en passant right
                if (j < 8)
                    if (i == 4) && board(9,8) == (j+1)
                        priorPos = i*10+j;
                        postPos = (i-1)*10+j+1;
                        % are pieces on same row diag or col?
                        if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                            legalMoves(:,z) = [priorPos, postPos, 11, 2, 2];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 11, board);
                            check = fastamIChecked_mex(testerBoard, 1);
                            if (check == false)
                                legalMoves(:,z) = [priorPos, postPos, 11, 2, 2];
                                z = z + 1;
                            end
                        end
                    end
                end
            end

            % Knights
            if board(i, j) == 12
                % moving knight upper left
                if (i > 2 && j > 1)
                    if (board(i-2, j-1) == 0)
                        priorPos = i*10+j;
                        postPos = (i-2)*10+j-1;
                        % are pieces on same row diag or col?
                        if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                            legalMoves(:,z) = [priorPos, postPos, 12, 0, 1];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 12, board);
                            check = fastamIChecked_mex(testerBoard, 1);
                            if (check == false)
                                legalMoves(:,z) = [priorPos, postPos, 12, 0, 1];
                                z = z + 1;
                            end
                        end
                    end
                    
                    % knight attacking upper left
                    if (board(i-2, j-1) > 20)
                        priorPos = i*10+j;
                        postPos = (i-2)*10+j-1;
                        % are pieces on same row diag or col?
                        if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                            value = board(i-2, j-1) - 20;
                            legalMoves(:,z) = [priorPos, postPos, 12, value, 2];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 12, board);
                            check = fastamIChecked_mex(testerBoard, 1);
                            if (check == false)
                                value = board(i-2, j-1) - 20;
                                legalMoves(:,z) = [priorPos, postPos, 12, value, 2];
                                z = z + 1;
                            end
                        end
                    end
                end
                
                % moving knight left upper
                if (i > 1 && j > 2)
                    if (board(i-1, j-2) == 0)
                        priorPos = i*10+j;
                        postPos = (i-1)*10+j-2;
                        % are pieces on same row diag or col?
                        if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                            legalMoves(:,z) = [priorPos, postPos, 12, 0, 1];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 12, board);
                            check = fastamIChecked_mex(testerBoard, 1);
                            if (check == false)
                                legalMoves(:,z) = [priorPos, postPos, 12, 0, 1];
                                z = z + 1;
                            end
                        end
                    end
                    
                    % knight attacking left upper
                    if (board(i-1, j-2) > 20)
                        priorPos = i*10+j;
                        postPos = (i-1)*10+j-2;
                        % are pieces on same row diag or col?
                        if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                            value = board(i-1, j-2) - 20;
                            legalMoves(:,z) = [priorPos, postPos, 12, value, 2];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 12, board);
                            check = fastamIChecked_mex(testerBoard, 1);
                            if (check == false)
                                value = board(i-1, j-2) - 20;
                                legalMoves(:,z) = [priorPos, postPos, 12, value, 2];
                                z = z + 1;
                            end
                        end
                    end
                end
                
                if (i < 8 && j > 2)
                    % moving knight left lower
                    if (board(i+1, j-2) == 0)
                        priorPos = i*10+j;
                        postPos = (i+1)*10+j-2;
                        % are pieces on same row diag or col?
                        if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                            legalMoves(:,z) = [priorPos, postPos, 12, 0, 1];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 12, board);
                            check = fastamIChecked_mex(testerBoard, 1);
                            if (check == false)
                                legalMoves(:,z) = [priorPos, postPos, 12, 0, 1];
                                z = z + 1;
                            end
                        end
                    end
                    
                    % knight attacking left lower
                    if (board(i+1, j-2) > 20)
                        priorPos = i*10+j;
                        postPos = (i+1)*10+j-2;
                        % are pieces on same row diag or col?
                        if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                            value = board(i+1, j-2) - 20;
                            legalMoves(:,z) = [priorPos, postPos, 12, value, 2];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 12, board);
                            check = fastamIChecked_mex(testerBoard, 1);
                            if (check == false)
                                value = board(i+1, j-2) - 20;
                                legalMoves(:,z) = [priorPos, postPos, 12, value, 2];
                                z = z + 1;
                            end
                        end
                    end
                end
                
                if (i < 7 && j > 1)
                    % moving knight lower left
                    if (board(i+2, j-1) == 0)
                        priorPos = i*10+j;
                        postPos = (i+2)*10+j-1;
                        % are pieces on same row diag or col?
                        if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                            legalMoves(:,z) = [priorPos, postPos, 12, 0, 1];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 12, board);
                            check = fastamIChecked_mex(testerBoard, 1);
                            if (check == false)
                                legalMoves(:,z) = [priorPos, postPos, 12, 0, 1];
                                z = z + 1;
                            end
                        end
                    end
                    
                    % knight attacking lower left
                    if (board(i+2, j-1) > 20)
                        priorPos = i*10+j;
                        postPos = (i+2)*10+j-1;
                        % are pieces on same row diag or col?
                        if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                            value = board(i+2, j-1) - 20;
                            legalMoves(:,z) = [priorPos, postPos, 12, value, 2];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 12, board);
                            check = fastamIChecked_mex(testerBoard, 1);
                            if (check == false)
                                value = board(i+2, j-1) - 20;
                                legalMoves(:,z) = [priorPos, postPos, 12, value, 2];
                                z = z + 1;
                            end
                        end
                    end
                end
                
                
                % moving knight lower right
                if (i < 7 && j < 8)
                    if (board(i+2, j+1) == 0)
                        priorPos = i*10+j;
                        postPos = (i+2)*10+j+1;
                        % are pieces on same row diag or col?
                        if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                            legalMoves(:,z) = [priorPos, postPos, 12, 0, 1];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 12, board);
                            check = fastamIChecked_mex(testerBoard, 1);
                            if (check == false)
                                legalMoves(:,z) = [priorPos, postPos, 12, 0, 1];
                                z = z + 1;
                            end
                        end
                    end
                    
                    % knight attacking lower right
                    if (board(i+2, j+1) > 20)
                        priorPos = i*10+j;
                        postPos = (i+2)*10+j+1;
                        % are pieces on same row diag or col?
                        if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                            value = board(i+2, j+1) - 20;
                            legalMoves(:,z) = [priorPos, postPos, 12, value, 2];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 12, board);
                            check = fastamIChecked_mex(testerBoard, 1);
                            if (check == false)
                                value = board(i+2, j+1) - 20;
                                legalMoves(:,z) = [priorPos, postPos, 12, value, 2];
                                z = z + 1;
                            end
                        end
                    end
                end
                
                if (i < 8 && j < 7)
                    % moving knight right lower
                    if (board(i+1, j+2) == 0)
                        priorPos = i*10+j;
                        postPos = (i+1)*10+j+2;
                        % are pieces on same row diag or col?
                        if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                            legalMoves(:,z) = [priorPos, postPos, 12, 0, 1];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 12, board);
                            check = fastamIChecked_mex(testerBoard, 1);
                            if (check == false)
                                legalMoves(:,z) = [priorPos, postPos, 12, 0, 1];
                                z = z + 1;
                            end
                        end
                    end
                    
                    % knight attacking right lower
                    if (board(i+1, j+2) > 20)
                        priorPos = i*10+j;
                        postPos = (i+1)*10+j+2;
                        % are pieces on same row diag or col?
                        if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                            value = board(i+1, j+2) - 20;
                            legalMoves(:,z) = [priorPos, postPos, 12, value, 2];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 12, board);
                            check = fastamIChecked_mex(testerBoard, 1);
                            if (check == false)
                                value = board(i+1, j+2) - 20;
                                legalMoves(:,z) = [priorPos, postPos, 12, value, 2];
                                z = z + 1;
                            end
                        end
                    end
                end
                
                % moving knight right upper
                if (i > 1 && j < 7)
                    if (board(i-1, j+2) == 0)
                        priorPos = i*10+j;
                        postPos = (i-1)*10+j+2;
                        % are pieces on same row diag or col?
                        if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                            legalMoves(:,z) = [priorPos, postPos, 12, 0, 1];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 12, board);
                            check = fastamIChecked_mex(testerBoard, 1);
                            if (check == false)
                                legalMoves(:,z) = [priorPos, postPos, 12, 0, 1];
                                z = z + 1;
                            end
                        end
                    end
                    
                    % knight attacking right upper
                    if (board(i-1, j+2) > 20)
                        priorPos = i*10+j;
                        postPos = (i-1)*10+j+2;
                        % are pieces on same row diag or col?
                        if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                            value = board(i-1, j+2) - 20;
                            legalMoves(:,z) = [priorPos, postPos, 12, value, 2];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 12, board);
                            check = fastamIChecked_mex(testerBoard, 1);
                            if (check == false)
                                value = board(i-1, j+2) - 20;
                                legalMoves(:,z) = [priorPos, postPos, 12, value, 2];
                                z = z + 1;
                            end
                        end
                    end
                end
                
                if (i > 2 && j < 8)
                    % moving knight upper right
                    if (board(i-2, j+1) == 0)
                        priorPos = i*10+j;
                        postPos = (i-2)*10+j+1;
                        % are pieces on same row diag or col?
                        if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                            legalMoves(:,z) = [priorPos, postPos, 12, 0, 1];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 12, board);
                            check = fastamIChecked_mex(testerBoard, 1);
                            if (check == false)
                                legalMoves(:,z) = [priorPos, postPos, 12, 0, 1];
                                z = z + 1;
                            end
                        end
                    end
                    
                    % knight attacking upper right
                    if (board(i-2, j+1) > 20)
                        priorPos = i*10+j;
                        postPos = (i-2)*10+j+1;
                        % are pieces on same row diag or col?
                        if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                            value = board(i-2, j+1) - 20;
                            legalMoves(:,z) = [priorPos, postPos, 12, value, 2];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 12, board);
                            check = fastamIChecked_mex(testerBoard, 1);
                            if (check == false)
                                value = board(i-2, j+1) - 20;
                                legalMoves(:,z) = [priorPos, postPos, 12, value, 2];
                                z = z + 1;
                            end
                        end
                    end
                end
            end
            
            
            % Bishops
            if board(i, j) == 13
                % north east diagonal
                for k=1:7
                    if i-k > 0 && j+k < 9
                        if (board(i-k, j+k) == 0) || (board(i-k, j+k) > 20)
                            priorPos = i*10+j;
                            postPos = (i-k)*10+j+k;
                            if board(i-k, j+k) == 0
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 13, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 13, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 13, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    value = board(i-k, j+k) - 20;
                                    legalMoves(:,z) = [priorPos, postPos, 13, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 13, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        value = board(i-k, j+k) - 20;
                                        legalMoves(:,z) = [priorPos, postPos, 13, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
                
                % north west diagonal
                for k=1:7
                    if i-k > 0 && j-k > 0
                        if (board(i-k, j-k) == 0) || (board(i-k, j-k) > 20)
                            priorPos = i*10+j;
                            postPos = (i-k)*10+j-k;
                            if board(i-k, j-k) == 0
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 13, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 13, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 13, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    value = board(i-k, j-k) - 20;
                                    legalMoves(:,z) = [priorPos, postPos, 13, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 13, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        value = board(i-k, j-k) - 20;
                                        legalMoves(:,z) = [priorPos, postPos, 13, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
                
                
                % south east diagonal
                for k=1:7
                    if i+k < 9 && j+k < 9
                        if (board(i+k, j+k) == 0) || (board(i+k, j+k) > 20)
                            priorPos = i*10+j;
                            postPos = (i+k)*10+j+k;
                            if board(i+k, j+k) == 0
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 13, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 13, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 13, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    value = board(i+k, j+k) - 20;
                                    legalMoves(:,z) = [priorPos, postPos, 13, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 13, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        value = board(i+k, j+k) - 20;
                                        legalMoves(:,z) = [priorPos, postPos, 13, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
                
                % south west diagonal
                for k=1:7
                    if i+k < 9 && j-k > 0
                        if (board(i+k, j-k) == 0) || (board(i+k, j-k) > 20)
                            priorPos = i*10+j;
                            postPos = (i+k)*10+j-k;
                            if board(i+k, j-k) == 0
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 13, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 13, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 13, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    value = board(i+k, j-k) - 20;
                                    legalMoves(:,z) = [priorPos, postPos, 13, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 13, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        value = board(i+k, j-k) - 20;
                                        legalMoves(:,z) = [priorPos, postPos, 13, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
            end
            
            % Rooks
            if board(i, j) == 14
                % north
                for k=1:7
                    if i-k > 0
                        if (board(i-k, j) == 0) || (board(i-k, j) > 20)
                            priorPos = i*10+j;
                            postPos = (i-k)*10+j;
                            if board(i-k, j) == 0
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 14, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 14, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 14, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    value = board(i-k, j) - 20;
                                    legalMoves(:,z) = [priorPos, postPos, 14, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 14, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        value = board(i-k, j) - 20;
                                        legalMoves(:,z) = [priorPos, postPos, 14, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
                
                % east
                for k=1:7
                    if j+k < 9
                        if (board(i, j+k) == 0) || (board(i, j+k) > 20)
                            priorPos = i*10+j;
                            postPos = (i)*10+j+k;
                            if board(i, j+k) == 0
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 14, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 14, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 14, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    value = board(i, j+k) - 20;
                                    legalMoves(:,z) = [priorPos, postPos, 14, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 14, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        value = board(i, j+k) - 20;
                                        legalMoves(:,z) = [priorPos, postPos, 14, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
                
                
                % south
                for k=1:7
                    if i+k < 9
                        if (board(i+k, j) == 0) || (board(i+k, j) > 20)
                            priorPos = i*10+j;
                            postPos = (i+k)*10+j;
                            if board(i+k, j) == 0
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 14, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 14, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 14, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    value = board(i+k, j) - 20;
                                    legalMoves(:,z) = [priorPos, postPos, 14, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 14, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        value = board(i+k, j) - 20;
                                        legalMoves(:,z) = [priorPos, postPos, 14, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
                
                % west
                for k=1:7
                    if j-k > 0
                        if (board(i, j-k) == 0) || (board(i, j-k) > 20)
                            priorPos = i*10+j;
                            postPos = (i)*10+j-k;
                            if board(i, j-k) == 0
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 14, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 14, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 14, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    value = board(i, j-k) - 20;
                                    legalMoves(:,z) = [priorPos, postPos, 14, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 14, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        value = board(i, j-k) - 20;
                                        legalMoves(:,z) = [priorPos, postPos, 14, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
            end
            
            
            % Queen
            if board(i, j) == 15
                % north east diagonal
                for k=1:7
                    if i-k > 0 && j+k < 9
                        if (board(i-k, j+k) == 0) || (board(i-k, j+k) > 20)
                            priorPos = i*10+j;
                            postPos = (i-k)*10+j+k;
                            if board(i-k, j+k) == 0
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 15, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 15, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 15, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    value = board(i-k, j+k) - 20;
                                    legalMoves(:,z) = [priorPos, postPos, 15, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 15, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        value = board(i-k, j+k) - 20;
                                        legalMoves(:,z) = [priorPos, postPos, 15, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
                
                % north west diagonal
                for k=1:7
                    if i-k > 0 && j-k > 0
                        if (board(i-k, j-k) == 0) || (board(i-k, j-k) > 20)
                            priorPos = i*10+j;
                            postPos = (i-k)*10+j-k;
                            if board(i-k, j-k) == 0
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 15, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 15, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 15, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    value = board(i-k, j-k) - 20;
                                    legalMoves(:,z) = [priorPos, postPos, 15, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 15, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        value = board(i-k, j-k) - 20;
                                        legalMoves(:,z) = [priorPos, postPos, 15, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
                
                
                % south east diagonal
                for k=1:7
                    if i+k < 9 && j+k < 9
                        if (board(i+k, j+k) == 0) || (board(i+k, j+k) > 20)
                            priorPos = i*10+j;
                            postPos = (i+k)*10+j+k;
                            if board(i+k, j+k) == 0
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 15, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 15, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 15, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    value = board(i+k, j+k) - 20;
                                    legalMoves(:,z) = [priorPos, postPos, 15, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 15, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        value = board(i+k, j+k) - 20;
                                        legalMoves(:,z) = [priorPos, postPos, 15, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
                
                % south west diagonal
                for k=1:7
                    if i+k < 9 && j-k > 0
                        if (board(i+k, j-k) == 0) || (board(i+k, j-k) > 20)
                            priorPos = i*10+j;
                            postPos = (i+k)*10+j-k;
                            if board(i+k, j-k) == 0
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 15, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 15, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 15, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    value = board(i+k, j-k) - 20;
                                    legalMoves(:,z) = [priorPos, postPos, 15, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 15, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        value = board(i+k, j-k) - 20;
                                        legalMoves(:,z) = [priorPos, postPos, 15, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
                
                % north
                for k=1:7
                    if i-k > 0
                        if (board(i-k, j) == 0) || (board(i-k, j) > 20)
                            priorPos = i*10+j;
                            postPos = (i-k)*10+j;
                            if board(i-k, j) == 0
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 15, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 15, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 15, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    value = board(i-k, j) - 20;
                                    legalMoves(:,z) = [priorPos, postPos, 15, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 15, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        value = board(i-k, j) - 20;
                                        legalMoves(:,z) = [priorPos, postPos, 15, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
                
                % east
                for k=1:7
                    if j+k < 9
                        if (board(i, j+k) == 0) || (board(i, j+k) > 20)
                            priorPos = i*10+j;
                            postPos = (i)*10+j+k;
                            if board(i, j+k) == 0
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 15, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 15, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 15, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    value = board(i, j+k) - 20;
                                    legalMoves(:,z) = [priorPos, postPos, 15, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 15, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        value = board(i, j+k) - 20;
                                        legalMoves(:,z) = [priorPos, postPos, 15, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
                
                
                % south
                for k=1:7
                    if i+k < 9
                        if (board(i+k, j) == 0) || (board(i+k, j) > 20)
                            priorPos = i*10+j;
                            postPos = (i+k)*10+j;
                            if board(i+k, j) == 0
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 15, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 15, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 15, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    value = board(i+k, j) - 20;
                                    legalMoves(:,z) = [priorPos, postPos, 15, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 15, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        value = board(i+k, j) - 20;
                                        legalMoves(:,z) = [priorPos, postPos, 15, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
                
                % west
                for k=1:7
                    if j-k > 0
                        if (board(i, j-k) == 0) || (board(i, j-k) > 20)
                            priorPos = i*10+j;
                            postPos = (i)*10+j-k;
                            if board(i, j-k) == 0
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 15, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 15, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 15, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                % are pieces on same row diag or col?
                                if (abs(i - whiteKingRow) ~= abs(j - whiteKingCol)) && i ~= whiteKingRow && j ~= whiteKingCol
                                    value = board(i, j-k) - 20;
                                    legalMoves(:,z) = [priorPos, postPos, 15, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 15, board);
                                    check = fastamIChecked_mex(testerBoard, 1);
                                    if (check == false)
                                        value = board(i, j-k) - 20;
                                        legalMoves(:,z) = [priorPos, postPos, 15, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
            end
            
            % King
            if board(i, j) == 16
                % north
                if (i > 1)
                    if (board(i-1, j) == 0)
                        priorPos = i*10+j;
                        postPos = (i-1)*10+j;
                        testerBoard = makeMove(priorPos, postPos, 16, board);
                        check = fastamIChecked_mex(testerBoard, 1);
                        if (check == false)
                            legalMoves(:,z) = [priorPos, postPos, 16, 0, 1];
                            z = z + 1;
                        end
                        
                        % attacking
                    elseif (board(i-1, j) > 20) &&  board(i-1, j) ~= 26
                        priorPos = i*10+j;
                        postPos = (i-1)*10+j;
                        testerBoard = makeMove(priorPos, postPos, 16, board);
                        check = fastamIChecked_mex(testerBoard, 1);
                        if (check == false)
                            value = board(i-1, j) - 20;
                            legalMoves(:,z) = [priorPos, postPos, 16, value, 2];
                            z = z + 1;
                        end
                    end
                end
                
                % east
                if (j < 8)
                    if (board(i, j+1) == 0)
                        priorPos = i*10+j;
                        postPos = (i)*10+j+1;
                        testerBoard = makeMove(priorPos, postPos, 16, board);
                        check = fastamIChecked_mex(testerBoard, 1);
                        if (check == false)
                            legalMoves(:,z) = [priorPos, postPos, 16, 0, 1];
                            z = z + 1;
                        end
                        
                        % attacking
                    elseif (board(i, j+1) > 20) &&  board(i, j+1) ~= 26
                        priorPos = i*10+j;
                        postPos = (i)*10+j+1;
                        testerBoard = makeMove(priorPos, postPos, 16, board);
                        check = fastamIChecked_mex(testerBoard, 1);
                        if (check == false)
                            value = board(i, j+1) - 20;
                            legalMoves(:,z) = [priorPos, postPos, 16, value, 2];
                            z = z + 1;
                        end
                    end
                end
                
                % South
                if (i < 8)
                    if (board(i+1, j) == 0)
                        priorPos = i*10+j;
                        postPos = (i+1)*10+j;
                        testerBoard = makeMove(priorPos, postPos, 16, board);
                        check = fastamIChecked_mex(testerBoard, 1);
                        if (check == false)
                            legalMoves(:,z) = [priorPos, postPos, 16, 0, 1];
                            z = z + 1;
                        end
                        
                        % attacking
                    elseif (board(i+1, j) > 20) &&  board(i+1, j) ~= 26
                        priorPos = i*10+j;
                        postPos = (i+1)*10+j;
                        
                        testerBoard = makeMove(priorPos, postPos, 16, board);
                        check = fastamIChecked_mex(testerBoard, 1);
                        if (check == false)
                            value = board(i+1, j) - 20;
                            legalMoves(:,z) = [priorPos, postPos, 16, value, 2];
                            z = z + 1;
                        end
                    end
                end
                
                
                % west
                if (j > 1)
                    if (board(i, j-1) == 0)
                        priorPos = i*10+j;
                        postPos = (i)*10+j-1;
                        
                        testerBoard = makeMove(priorPos, postPos, 16, board);
                        check = fastamIChecked_mex(testerBoard, 1);
                        if (check == false)
                            legalMoves(:,z) = [priorPos, postPos, 16, 0, 1];
                            z = z + 1;
                        end
                        
                        % attacking
                    elseif (board(i, j-1) > 20) &&  board(i, j-1) ~= 26
                        priorPos = i*10+j;
                        postPos = (i)*10+j-1;
                        
                        testerBoard = makeMove(priorPos, postPos, 16, board);
                        check = fastamIChecked_mex(testerBoard, 1);
                        if (check == false)
                            value = board(i, j-1) - 20;
                            legalMoves(:,z) = [priorPos, postPos, 16, value, 2];
                            z = z + 1;
                        end
                    end
                end
                
                % north East
                if (i > 1) && (j < 8)
                    if (board(i-1, j+1) == 0)
                        priorPos = i*10+j;
                        postPos = (i-1)*10+j+1;
                        
                        testerBoard = makeMove(priorPos, postPos, 16, board);
                        check = fastamIChecked_mex(testerBoard, 1);
                        if (check == false)
                            legalMoves(:,z) = [priorPos, postPos, 16, 0, 1];
                            z = z + 1;
                        end
                        
                        % attacking
                    elseif (board(i-1, j+1) > 20)
                        priorPos = i*10+j;
                        postPos = (i-1)*10+j+1;
                        
                        testerBoard = makeMove(priorPos, postPos, 16, board);
                        check = fastamIChecked_mex(testerBoard, 1);
                        if (check == false)
                            value = board(i-1, j+1) - 20;
                            legalMoves(:,z) = [priorPos, postPos, 16, value, 2];
                            z = z + 1;
                        end
                    end
                end
                
                % North West
                if (i > 1) && (j > 1)
                    if (board(i-1, j-1) == 0)
                        priorPos = i*10+j;
                        postPos = (i-1)*10+j-1;
                        
                        testerBoard = makeMove(priorPos, postPos, 16, board);
                        check = fastamIChecked_mex(testerBoard, 1);
                        if (check == false)
                            legalMoves(:,z) = [priorPos, postPos, 16, 0, 1];
                            z = z + 1;
                        end
                        
                        % attacking
                    elseif (board(i-1, j-1) > 20) &&  board(i-1, j-1) ~= 26
                        priorPos = i*10+j;
                        postPos = (i-1)*10+j-1;
                        
                        testerBoard = makeMove(priorPos, postPos, 16, board);
                        check = fastamIChecked_mex(testerBoard, 1);
                        if (check == false)
                            value = board(i-1, j-1) - 20;
                            legalMoves(:,z) = [priorPos, postPos, 16, value, 2];
                            z = z + 1;
                        end
                    end
                end
                
                % South East
                if (i < 8) && (j < 8)
                    if (board(i+1, j+1) == 0)
                        priorPos = i*10+j;
                        postPos = (i+1)*10+j+1;
                        
                        testerBoard = makeMove(priorPos, postPos, 16, board);
                        check = fastamIChecked_mex(testerBoard, 1);
                        if (check == false)
                            legalMoves(:,z) = [priorPos, postPos, 16, 0, 1];
                            z = z + 1;
                        end
                        
                        % attacking
                    elseif (board(i+1, j+1) > 20) &&  board(i+1, j+1) ~= 26
                        priorPos = i*10+j;
                        postPos = (i+1)*10+j+1;
                        
                        testerBoard = makeMove(priorPos, postPos, 16, board);
                        check = fastamIChecked_mex(testerBoard, 1);
                        if (check == false)
                            value = board(i+1, j+1) - 20;
                            legalMoves(:,z) = [priorPos, postPos, 16, value, 2];
                            z = z + 1;
                        end
                    end
                end
                
                % South West
                if (i < 8) && (j > 1)
                    if (board(i+1, j-1) == 0)
                        priorPos = i*10+j;
                        postPos = (i+1)*10+j-1;
                        
                        testerBoard = makeMove(priorPos, postPos, 16, board);
                        check = fastamIChecked_mex(testerBoard, 1);
                        if (check == false)
                            legalMoves(:,z) = [priorPos, postPos, 16, 0, 1];
                            z = z + 1;
                        end
                        
                        % attacking
                    elseif (board(i+1, j-1) > 20) &&  board(i+1, j-1) ~= 26
                        priorPos = i*10+j;
                        postPos = (i+1)*10+j-1;
                        
                        testerBoard = makeMove(priorPos, postPos, 16, board);
                        check = fastamIChecked_mex(testerBoard, 1);
                        if (check == false)
                            value = board(i+1, j-1) - 20;
                            legalMoves(:,z) = [priorPos, postPos, 16, value, 2];
                            z = z + 1;
                        end
                    end
                end
                
                % Left Castle
                if board(8,2) == 0 && board(8,3) == 0 && board(8,4) == 0 && board(9,2) == 0 && board(9,1) == 0 && board(8,1) == 14
                    check = fastamIChecked_mex(board, 1);
                    if (check == false)
                        fakeBoard = makeMove(85, 84, 16, board);
                        check = fastamIChecked_mex(fakeBoard, 1);
                        if (check == false)
                            fakeBoard = makeMove(84, 83, 16, fakeBoard);
                            check = fastamIChecked_mex(fakeBoard, 1);
                            if (check == false)
                                legalMoves(:,z) = [85, 83, 16, 3, 1];
                                z = z + 1;
                            end
                        end
                    end
                end
                
                
                
                % Right Castle
                if board(8,6) == 0 && board(8,7) == 0 && board(9,3) == 0 && board(9,1) == 0 && board(8,8) == 14
                    check = fastamIChecked_mex(board, 1);
                    if (check == false)
                        fakeBoard = makeMove(85, 86, 16, board);
                        check = fastamIChecked_mex(fakeBoard, 1);
                        if (check == false)
                            fakeBoard = makeMove(86, 87, 16, fakeBoard);
                            check = fastamIChecked_mex(fakeBoard, 1);
                            if (check == false)
                                legalMoves(:,z) = [85, 87, 16, 3, 1];
                                z = z + 1;
                            end
                        end
                    end
                end
            end
        end
    end
end



if colour == 2
    for i=1:8
        for j=1:8
            % Pawns
            if board(i, j) == 21
                % moving pawn twice if its at the start
                if i == 2 && (board(i+1, j) == 0) && (board(i+2, j) == 0)
                    priorPos = i*10+j;
                    postPos = (i+2)*10+j;
                    % are pieces on same row diag or col?   
                    if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                        legalMoves(:,z) = [priorPos, postPos, 21, 1, 1];
                        z = z + 1;
                    else
                        testerBoard = makeMove(priorPos, postPos, 21, board);
                        check = fastamIChecked_mex(testerBoard, 2);
                        if (check == false)
                            legalMoves(:,z) = [priorPos, postPos, 21, 1, 1];
                            z = z + 1;
                        end
                    end
                end
                
                % moving pawn once if spot ahead is free
                if i > 1
                    if board(i+1, j) == 0
                        priorPos = i*10+j;
                        postPos = (i+1)*10+j;
                        
                        % are pieces on same row diag or col?
                        if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                            if i+1 == 8                 
                                legalMoves(:,z) = [priorPos, postPos, 25, 11, 1];
                                z = z + 1;
                            else
                                legalMoves(:,z) = [priorPos, postPos, 21, 1, 1];
                                z = z + 1;
                            end
                        else
                            testerBoard = makeMove(priorPos, postPos, 21, board);
                            check = fastamIChecked_mex(testerBoard, 2);
                            if (check == false)
                                if i+1 == 8
                                    legalMoves(:,z) = [priorPos, postPos, 25, 11, 1];
                                    z = z + 1;
                                else
                                    legalMoves(:,z) = [priorPos, postPos, 21, 1, 1];
                                    z = z + 1;
                                end
                            end
                        end
                    end
                end
                
                if (i < 8 && j > 1)
                    % pawn attacking left diagonal
                    if board(i+1, j-1) < 20 && board(i+1, j-1) > 0
                        priorPos = i*10+j;
                        postPos = (i+1)*10+j-1;
                        % are pieces on same row diag or col?
                        if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                            if i+1 == 8
                                value = board(i+1, j-1) - 10;
                                legalMoves(:,z) = [priorPos, postPos, 25, 11+value, 2];
                                z = z + 1;
                            else
                                value = board(i+1, j-1) - 10;
                                legalMoves(:,z) = [priorPos, postPos, 21, value+1, 2];
                                z = z + 1;
                            end
                        else
                            testerBoard = makeMove(priorPos, postPos, 21, board);
                            check = fastamIChecked_mex(testerBoard, 2);
                            if (check == false)
                                if i+1 == 8
                                    value = board(i+1, j-1) - 10;
                                    legalMoves(:,z) = [priorPos, postPos, 25, 11+value, 2];
                                    z = z + 1;
                                else
                                    value = board(i+1, j-1) - 10;
                                    legalMoves(:,z) = [priorPos, postPos, 21, 1+value, 2];
                                    z = z + 1;
                                end
                            end
                        end
                    end
                end
                
                if (i < 8 && j < 8)
                    % pawn attacking right diagonal
                    if board(i+1, j+1) < 20 && board(i+1, j+1) > 10
                        priorPos = i*10+j;
                        postPos = (i+1)*10+j+1;
                        % are pieces on same row diag or col?
                        if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                            if i+1 == 8
                                value = board(i+1, j+1) - 10;
                                legalMoves(:,z) = [priorPos, postPos, 25, 11+value, 2];
                                z = z + 1;
                            else
                                value = board(i+1, j+1) - 10;
                                legalMoves(:,z) = [priorPos, postPos, 21, 1+value, 2];
                                z = z + 1;
                            end
                        else
                            testerBoard = makeMove(priorPos, postPos, 21, board);
                            check = fastamIChecked_mex(testerBoard, 2);
                            if (check == false)
                                if i+1 == 8
                                    value = board(i+1, j+1) - 10;
                                    legalMoves(:,z) = [priorPos, postPos, 25, 11+value, 2];
                                    z = z + 1;
                                else
                                    value = board(i+1, j+1) - 10;
                                    legalMoves(:,z) = [priorPos, postPos, 21, 1+value, 2];
                                    z = z + 1;
                                end
                            end
                        end
                    end
                end
                
                %en passant left
                if j > 1
                    if (i == 5) && board(9,7) == (j-1)
                        priorPos = i*10+j;
                        postPos = (i+1)*10+j-1;
                        % are pieces on same row diag or col?
                        if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                            legalMoves(:,z) = [priorPos, postPos, 21, 2, 2];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 21, board);
                            check = fastamIChecked_mex(testerBoard, 2);
                            if (check == false)
                                legalMoves(:,z) = [priorPos, postPos, 21, 2, 2];
                                z = z + 1;
                            end
                        end
                    end
                end
                
                %en passant right
                if j < 8
                    if (i == 5) && board(9,7) == (j+1)
                        priorPos = i*10+j;
                        postPos = (i+1)*10+j+1;
                        % are pieces on same row diag or col?
                        if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                            legalMoves(:,z) = [priorPos, postPos, 21, 2, 2];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 21, board);
                            check = fastamIChecked_mex(testerBoard, 2);
                            if (check == false)
                                legalMoves(:,z) = [priorPos, postPos, 21, 2, 2];
                                z = z + 1;
                            end
                        end
                    end
                end
            end
            
            % Knights
            if board(i, j) == 22
                % moving knight upper left
                if (i > 2 && j > 1)
                    if (board(i-2, j-1) == 0)
                        priorPos = i*10+j;
                        postPos = (i-2)*10+j-1;
                        % are pieces on same row diag or col?
                        if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                            legalMoves(:,z) = [priorPos, postPos, 22, 0, 1];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 22, board);
                            check = fastamIChecked_mex(testerBoard, 2);
                            if (check == false)
                                legalMoves(:,z) = [priorPos, postPos, 22, 9, 1];
                                z = z + 1;
                            end
                        end
                    elseif (board(i-2, j-1) < 20)
                        
                        % knight attacking upper left
                        priorPos = i*10+j;
                        postPos = (i-2)*10+j-1;
                        % are pieces on same row diag or col?
                        if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                            value = board(i-2, j-1) - 10;
                            legalMoves(:,z) = [priorPos, postPos, 22, value, 2];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 22, board);
                            check = fastamIChecked_mex(testerBoard, 2);
                            if (check == false)
                                value = board(i-2, j-1) - 10;
                                legalMoves(:,z) = [priorPos, postPos, 22, value, 2];
                                z = z + 1;
                            end
                        end
                    end
                end
                
                % moving knight left upper
                if (i > 1 && j > 2)
                    if (board(i-1, j-2) == 0)
                        priorPos = i*10+j;
                        postPos = (i-1)*10+j-2;
                        
                        testerBoard = makeMove(priorPos, postPos, 22, board);
                        check = fastamIChecked_mex(testerBoard, 2);
                        if (check == false)
                            legalMoves(:,z) = [priorPos, postPos, 22, 0, 1];
                            z = z + 1;
                        end
                    elseif (board(i-1, j-2) < 20)
                        
                        % knight attacking left upper
                        priorPos = i*10+j;
                        postPos = (i-1)*10+j-2;
                        % are pieces on same row diag or col?
                        if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                            value = board(i-1, j-2) - 10;
                            legalMoves(:,z) = [priorPos, postPos, 22, value, 2];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 22, board);
                            check = fastamIChecked_mex(testerBoard, 2);
                            if (check == false)
                                value = board(i-1, j-2) - 10;
                                legalMoves(:,z) = [priorPos, postPos, 22, value, 2];
                                z = z + 1;
                            end
                        end
                    end
                end
                
                if (i < 8 && j > 2)
                    % moving knight left lower
                    if (board(i+1, j-2) == 0)
                        priorPos = i*10+j;
                        postPos = (i+1)*10+j-2;
                        if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                            legalMoves(:,z) = [priorPos, postPos, 22, 0, 1];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 22, board);
                            check = fastamIChecked_mex(testerBoard, 2);
                            if (check == false)
                                legalMoves(:,z) = [priorPos, postPos, 22, 0, 1];
                                z = z + 1;
                            end
                        end
                    elseif (board(i+1, j-2) < 20)
                        
                        % knight attacking left lower
                        priorPos = i*10+j;
                        postPos = (i+1)*10+j-2;
                        
                        if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                            value = board(i+1, j-2) - 10;
                            legalMoves(:,z) = [priorPos, postPos, 22, value, 2];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 22, board);
                            check = fastamIChecked_mex(testerBoard, 2);
                            if (check == false)
                                value = board(i+1, j-2) - 10;
                                legalMoves(:,z) = [priorPos, postPos, 22, value, 2];
                                z = z + 1;
                            end
                        end
                    end
                end
                
                if (i < 7 && j > 1)
                    % moving knight lower left
                    if (board(i+2, j-1) == 0)
                        priorPos = i*10+j;
                        postPos = (i+2)*10+j-1;
                        
                        if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                            legalMoves(:,z) = [priorPos, postPos, 22, 0, 1];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 22, board);
                            check = fastamIChecked_mex(testerBoard, 2);
                            if (check == false)
                                legalMoves(:,z) = [priorPos, postPos, 22, 0, 1];
                                z = z + 1;
                            end
                        end
                    elseif (board(i+2, j-1) < 20)
                        
                        % knight attacking lower left
                        priorPos = i*10+j;
                        postPos = (i+2)*10+j-1;
                        
                        if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                            value = board(i+2, j-1) - 10;
                            legalMoves(:,z) = [priorPos, postPos, 22, value, 2];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 22, board);
                            check = fastamIChecked_mex(testerBoard, 2);
                            if (check == false)
                                value = board(i+2, j-1) - 10;
                                legalMoves(:,z) = [priorPos, postPos, 22, value, 2];
                                z = z + 1;
                            end
                        end
                    end
                end
                
                
                % moving knight lower right
                if (i < 7 && j < 8)
                    if (board(i+2, j+1) == 0)
                        priorPos = i*10+j;
                        postPos = (i+2)*10+j+1;
                        
                        if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                            legalMoves(:,z) = [priorPos, postPos, 22, 0, 1];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 22, board);
                            check = fastamIChecked_mex(testerBoard, 2);
                            if (check == false)
                                legalMoves(:,z) = [priorPos, postPos, 22, 0, 1];
                                z = z + 1;
                            end
                        end
                    elseif (board(i+2, j+1) < 20)
                        
                        % knight attacking lower right
                        priorPos = i*10+j;
                        postPos = (i+2)*10+j+1;
                        
                        if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                            value = board(i+2, j+1) - 10;
                            legalMoves(:,z) = [priorPos, postPos, 22, value, 2];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 22, board);
                            check = fastamIChecked_mex(testerBoard, 2);
                            if (check == false)
                                value = board(i+2, j+1) - 10;
                                legalMoves(:,z) = [priorPos, postPos, 22, value, 2];
                                z = z + 1;
                            end
                        end
                    end
                end
                
                if (i < 8 && j < 7)
                    % moving knight right lower
                    if (board(i+1, j+2) == 0)
                        priorPos = i*10+j;
                        postPos = (i+1)*10+j+2;
                        
                        if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                            legalMoves(:,z) = [priorPos, postPos, 22, 0, 1];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 22, board);
                            check = fastamIChecked_mex(testerBoard, 2);
                            if (check == false)
                                legalMoves(:,z) = [priorPos, postPos, 22, 0, 1];
                                z = z + 1;
                            end
                        end
                    elseif (board(i+1, j+2) < 20)
                        
                        % knight attacking right lower
                        priorPos = i*10+j;
                        postPos = (i+1)*10+j+2;
                        
                        if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                            value = board(i+1, j+2) - 10;
                            legalMoves(:,z) = [priorPos, postPos, 22, value, 2];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 22, board);
                            check = fastamIChecked_mex(testerBoard, 2);
                            if (check == false)
                                value = board(i+1, j+2) - 10;
                                legalMoves(:,z) = [priorPos, postPos, 22, value, 2];
                                z = z + 1;
                            end
                        end
                    end
                end
                
                % moving knight right upper
                if (i > 1 && j < 7)
                    if (board(i-1, j+2) == 0)
                        priorPos = i*10+j;
                        postPos = (i-1)*10+j+2;
                        
                        if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                            legalMoves(:,z) = [priorPos, postPos, 22, 0, 1];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 22, board);
                            check = fastamIChecked_mex(testerBoard, 2);
                            if (check == false)
                                legalMoves(:,z) = [priorPos, postPos, 22, 0, 1];
                                z = z + 1;
                            end
                        end
                    elseif (board(i-1, j+2) < 20)
                        
                        % knight attacking right upper
                        priorPos = i*10+j;
                        postPos = (i-1)*10+j+2;
                        
                        if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                            value = board(i-1, j+2) - 10;
                            legalMoves(:,z) = [priorPos, postPos, 22, value, 2];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 22, board);
                            check = fastamIChecked_mex(testerBoard, 2);
                            if (check == false)
                                value = board(i-1, j+2) - 10;
                                legalMoves(:,z) = [priorPos, postPos, 22, value, 2];
                                z = z + 1;
                            end
                        end
                    end
                end
                
                if (i > 2 && j < 8)
                    % moving knight upper right
                    if (board(i-2, j+1) == 0)
                        priorPos = i*10+j;
                        postPos = (i-2)*10+j+1;
                        
                        if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                            legalMoves(:,z) = [priorPos, postPos, 22, 0, 1];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 22, board);
                            check = fastamIChecked_mex(testerBoard, 2);
                            if (check == false)
                                legalMoves(:,z) = [priorPos, postPos, 22, 0, 1];
                                z = z + 1;
                            end
                        end
                    elseif (board(i-2, j+1) < 20)
                        
                        % knight attacking upper right
                        priorPos = i*10+j;
                        postPos = (i-2)*10+j+1;
                        
                        if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                            value = board(i-2, j+1) - 10;
                            legalMoves(:,z) = [priorPos, postPos, 22, value, 2];
                            z = z + 1;
                        else
                            testerBoard = makeMove(priorPos, postPos, 22, board);
                            check = fastamIChecked_mex(testerBoard, 2);
                            if (check == false)
                                value = board(i-2, j+1) - 10;
                                legalMoves(:,z) = [priorPos, postPos, 22, value, 2];
                                z = z + 1;
                            end
                        end
                    end
                end
            end
            
            
            % Bishops
            if board(i, j) == 23
                % north east diagonal
                for k=1:7
                    if i-k > 0 && j+k < 9
                        if (board(i-k, j+k) == 0) || (board(i-k, j+k) < 20)
                            priorPos = i*10+j;
                            postPos = (i-k)*10+j+k;
                            if board(i-k, j+k) == 0
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 23, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 23, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 23, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    value = board(i-k, j+k) - 10;
                                    legalMoves(:,z) = [priorPos, postPos, 23, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 23, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        value = board(i-k, j+k) - 10;
                                        legalMoves(:,z) = [priorPos, postPos, 23, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
                
                % north west diagonal
                for k=1:7
                    if i-k > 0 && j-k > 0
                        if (board(i-k, j-k) == 0) || (board(i-k, j-k) < 20)
                            priorPos = i*10+j;
                            postPos = (i-k)*10+j-k;
                            if board(i-k, j-k) == 0
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 23, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 23, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 23, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    value = board(i-k, j-k) - 10;
                                    legalMoves(:,z) = [priorPos, postPos, 23, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 23, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        value = board(i-k, j-k) - 10;
                                        legalMoves(:,z) = [priorPos, postPos, 23, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
                
                
                % south east diagonal
                for k=1:7
                    if i+k < 9 && j+k < 9
                        if (board(i+k, j+k) == 0) || (board(i+k, j+k) < 20)
                            priorPos = i*10+j;
                            postPos = (i+k)*10+j+k;
                            if board(i+k, j+k) == 0
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 23, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 23, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 23, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    value = board(i+k, j+k) - 10;
                                    legalMoves(:,z) = [priorPos, postPos, 23, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 23, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        value = board(i+k, j+k) - 10;
                                        legalMoves(:,z) = [priorPos, postPos, 23, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
                
                % south west diagonal
                for k=1:7
                    if i+k < 9 && j-k > 0
                        if (board(i+k, j-k) == 0) || (board(i+k, j-k) < 20)
                            priorPos = i*10+j;
                            postPos = (i+k)*10+j-k;
                            if board(i+k, j-k) == 0
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 23, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 23, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 23, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    value = board(i+k, j-k) - 10;
                                    legalMoves(:,z) = [priorPos, postPos, 23, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 23, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        value = board(i+k, j-k) - 10;
                                        legalMoves(:,z) = [priorPos, postPos, 23, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
            end
            
            % Rooks
            if board(i, j) == 24
                % north
                for k=1:7
                    if i-k > 0
                        if (board(i-k, j) == 0) || (board(i-k, j) < 20)
                            priorPos = i*10+j;
                            postPos = (i-k)*10+j;
                            if board(i-k, j) == 0
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 24, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 24, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 24, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    value = board(i-k, j) - 10;
                                    legalMoves(:,z) = [priorPos, postPos, 24, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 24, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        value = board(i-k, j) - 10;
                                        legalMoves(:,z) = [priorPos, postPos, 24, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
                
                % east
                for k=1:7
                    if j+k < 9
                        if (board(i, j+k) == 0) || (board(i, j+k) < 20)
                            priorPos = i*10+j;
                            postPos = (i)*10+j+k;
                            if board(i, j+k) == 0
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 24, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 24, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 24, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    value = board(i, j+k) - 10;
                                    legalMoves(:,z) = [priorPos, postPos, 24, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 24, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        value = board(i, j+k) - 10;
                                        legalMoves(:,z) = [priorPos, postPos, 24, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
                
                
                % south
                for k=1:7
                    if i+k < 9
                        if (board(i+k, j) == 0) || (board(i+k, j) < 20)
                            priorPos = i*10+j;
                            postPos = (i+k)*10+j;
                            if board(i+k, j) == 0
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 24, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 24, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 24, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    value = board(i+k, j) - 10;
                                    legalMoves(:,z) = [priorPos, postPos, 24, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 24, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        value = board(i+k, j) - 10;
                                        legalMoves(:,z) = [priorPos, postPos, 24, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
                
                % west
                for k=1:7
                    if j-k > 0
                        if (board(i, j-k) == 0) || (board(i, j-k) < 20)
                            priorPos = i*10+j;
                            postPos = (i)*10+j-k;
                            if board(i, j-k) == 0
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 24, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 24, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 24, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    value = board(i, j-k) - 10;
                                    legalMoves(:,z) = [priorPos, postPos, 24, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 24, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        value = board(i, j-k) - 10;
                                        legalMoves(:,z) = [priorPos, postPos, 24, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
            end
            
            
            % Queen
            if board(i, j) == 25
                % north east diagonal
                for k=1:7
                    if i-k > 0 && j+k < 9
                        if (board(i-k, j+k) == 0) || (board(i-k, j+k) < 20)
                            priorPos = i*10+j;
                            postPos = (i-k)*10+j+k;
                            if board(i-k, j+k) == 0
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 25, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 25, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 25, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    value = board(i-k, j+k) - 10;
                                    legalMoves(:,z) = [priorPos, postPos, 25, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 25, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        value = board(i-k, j+k) - 10;
                                        legalMoves(:,z) = [priorPos, postPos, 25, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
                
                % north west diagonal
                for k=1:7
                    if i-k > 0 && j-k > 0
                        if (board(i-k, j-k) == 0) || (board(i-k, j-k) < 20)
                            priorPos = i*10+j;
                            postPos = (i-k)*10+j-k;
                            if board(i-k, j-k) == 0
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 25, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 25, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 25, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    value = board(i-k, j-k) - 10;
                                    legalMoves(:,z) = [priorPos, postPos, 25, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 25, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        value = board(i-k, j-k) - 10;
                                        legalMoves(:,z) = [priorPos, postPos, 25, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
                
                
                % south east diagonal
                for k=1:7
                    if i+k < 9 && j+k < 9
                        if (board(i+k, j+k) == 0) || (board(i+k, j+k) < 20)
                            priorPos = i*10+j;
                            postPos = (i+k)*10+j+k;
                            if board(i+k, j+k) == 0
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 25, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 25, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 25, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    value = board(i+k, j+k) - 10;
                                    legalMoves(:,z) = [priorPos, postPos, 25, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 25, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        value = board(i+k, j+k) - 10;
                                        legalMoves(:,z) = [priorPos, postPos, 25, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
                
                % south west diagonal
                for k=1:7
                    if i+k < 9 && j-k > 0
                        if (board(i+k, j-k) == 0) || (board(i+k, j-k) < 20)
                            priorPos = i*10+j;
                            postPos = (i+k)*10+j-k;
                            if board(i+k, j-k) == 0
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 25, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 25, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 25, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    value = board(i+k, j-k) - 10;
                                    legalMoves(:,z) = [priorPos, postPos, 25, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 25, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        value = board(i+k, j-k) - 10;
                                        legalMoves(:,z) = [priorPos, postPos, 25, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
                
                % north
                for k=1:7
                    if i-k > 0
                        if (board(i-k, j) == 0) || (board(i-k, j) < 20)
                            priorPos = i*10+j;
                            postPos = (i-k)*10+j;
                            if board(i-k, j) == 0
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 25, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 25, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 25, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    value = board(i-k, j) - 10;
                                    legalMoves(:,z) = [priorPos, postPos, 25, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 25, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        value = board(i-k, j) - 10;
                                        legalMoves(:,z) = [priorPos, postPos, 25, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
                
                % east
                for k=1:7
                    if j+k < 9
                        if (board(i, j+k) == 0) || (board(i, j+k) < 20)
                            priorPos = i*10+j;
                            postPos = (i)*10+j+k;
                            if board(i, j+k) == 0
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 25, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 25, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 25, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    value = board(i, j+k) - 10;
                                    legalMoves(:,z) = [priorPos, postPos, 25, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 25, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        value = board(i, j+k) - 10;
                                        legalMoves(:,z) = [priorPos, postPos, 25, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
                
                
                % south
                for k=1:7
                    if i+k < 9
                        if (board(i+k, j) == 0) || (board(i+k, j) < 20)
                            priorPos = i*10+j;
                            postPos = (i+k)*10+j;
                            if board(i+k, j) == 0
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 25, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 25, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 25, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    value = board(i+k, j) - 10;
                                    legalMoves(:,z) = [priorPos, postPos, 25, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 25, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        value = board(i+k, j) - 10;
                                        legalMoves(:,z) = [priorPos, postPos, 25, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
                
                % west
                for k=1:7
                    if j-k > 0
                        if (board(i, j-k) == 0) || (board(i, j-k) < 20)
                            priorPos = i*10+j;
                            postPos = (i)*10+j-k;
                            if board(i, j-k) == 0
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    legalMoves(:,z) = [priorPos, postPos, 25, 0, 1];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 25, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        legalMoves(:,z) = [priorPos, postPos, 25, 0, 1];
                                        z = z + 1;
                                    end
                                end
                            else
                                
                                if (abs(i - blackKingRow) ~= abs(j - blackKingCol)) && i ~= blackKingRow && j ~= blackKingCol
                                    value = board(i, j-k) - 10;
                                    legalMoves(:,z) = [priorPos, postPos, 25, value, 2];
                                    z = z + 1;
                                else
                                    testerBoard = makeMove(priorPos, postPos, 25, board);
                                    check = fastamIChecked_mex(testerBoard, 2);
                                    if (check == false)
                                        value = board(i, j-k) - 10;
                                        legalMoves(:,z) = [priorPos, postPos, 25, value, 2];
                                        z = z + 1;
                                    end
                                end
                                break;
                            end
                        else
                            break;
                        end
                    end
                end
            end
            
            % King
            if board(i, j) == 26
                % north
                if (i > 1)
                    if (board(i-1, j) == 0)
                        priorPos = i*10+j;
                        postPos = (i-1)*10+j;
                        
                        testerBoard = makeMove(priorPos, postPos, 26, board);
                        check = fastamIChecked_mex(testerBoard, 2);
                        if (check == false)
                            legalMoves(:,z) = [priorPos, postPos, 26, 0, 1];
                            z = z + 1;
                        end
                        
                        % attacking
                    elseif (board(i-1, j) < 20) &&  board(i-1, j) ~= 26
                        priorPos = i*10+j;
                        postPos = (i-1)*10+j;
                        
                        testerBoard = makeMove(priorPos, postPos, 26, board);
                        check = fastamIChecked_mex(testerBoard, 2);
                        if (check == false)
                            value = board(i-1, j) - 10;
                            legalMoves(:,z) = [priorPos, postPos, 26, value, 2];
                            z = z + 1;
                        end
                    end
                end
                
                % east
                if (j < 8)
                    if (board(i, j+1) == 0)
                        priorPos = i*10+j;
                        postPos = (i)*10+j+1;
                        
                        testerBoard = makeMove(priorPos, postPos, 26, board);
                        check = fastamIChecked_mex(testerBoard, 2);
                        if (check == false)
                            legalMoves(:,z) = [priorPos, postPos, 26, 0, 1];
                            z = z + 1;
                        end
                        
                        % attacking
                    elseif (board(i, j+1) < 20) &&  board(i, j+1) ~= 26
                        priorPos = i*10+j;
                        postPos = (i)*10+j+1;
                        
                        testerBoard = makeMove(priorPos, postPos, 26, board);
                        check = fastamIChecked_mex(testerBoard, 2);
                        if (check == false)
                            value = board(i, j+1) - 10;
                            legalMoves(:,z) = [priorPos, postPos, 26, value, 2];
                            z = z + 1;
                        end
                    end
                end
                
                % South
                if (i < 8)
                    if (board(i+1, j) == 0)
                        priorPos = i*10+j;
                        postPos = (i+1)*10+j;
                        
                        testerBoard = makeMove(priorPos, postPos, 26, board);
                        check = fastamIChecked_mex(testerBoard, 2);
                        if (check == false)
                            legalMoves(:,z) = [priorPos, postPos, 26, 0, 1];
                            z = z + 1;
                        end
                        
                        % attacking
                    elseif (board(i+1, j) < 20) &&  board(i+1, j) ~= 26
                        priorPos = i*10+j;
                        postPos = (i+1)*10+j;
                        
                        testerBoard = makeMove(priorPos, postPos, 26, board);
                        check = fastamIChecked_mex(testerBoard, 2);
                        if (check == false)
                            value = board(i+1, j) - 10;
                            legalMoves(:,z) = [priorPos, postPos, 26, value, 2];
                            z = z + 1;
                        end
                    end
                end
                
                
                % west
                if (j > 1)
                    if (board(i, j-1) == 0)
                        priorPos = i*10+j;
                        postPos = (i)*10+j-1;
                        
                        testerBoard = makeMove(priorPos, postPos, 26, board);
                        check = fastamIChecked_mex(testerBoard, 2);
                        if (check == false)
                            legalMoves(:,z) = [priorPos, postPos, 26, 0, 1];
                            z = z + 1;
                        end
                        
                        % attacking
                    elseif (board(i, j-1) < 20) &&  board(i, j-1) ~= 26
                        priorPos = i*10+j;
                        postPos = (i)*10+j-1;
                        
                        testerBoard = makeMove(priorPos, postPos, 26, board);
                        check = fastamIChecked_mex(testerBoard, 2);
                        if (check == false)
                            value = board(i, j-1) - 10;
                            legalMoves(:,z) = [priorPos, postPos, 26, value, 2];
                            z = z + 1;
                        end
                    end
                end
                
                % north East
                if (i > 1) && (j < 8)
                    if (board(i-1, j+1) == 0)
                        priorPos = i*10+j;
                        postPos = (i-1)*10+j+1;
                        
                        testerBoard = makeMove(priorPos, postPos, 26, board);
                        check = fastamIChecked_mex(testerBoard, 2);
                        if (check == false)
                            legalMoves(:,z) = [priorPos, postPos, 26, 0, 1];
                            z = z + 1;
                        end
                        
                        % attacking
                    elseif (board(i-1, j+1) < 20)
                        priorPos = i*10+j;
                        postPos = (i-1)*10+j+1;
                        
                        testerBoard = makeMove(priorPos, postPos, 26, board);
                        check = fastamIChecked_mex(testerBoard, 2);
                        if (check == false)
                            value = board(i-1, j+1) - 10;
                            legalMoves(:,z) = [priorPos, postPos, 26, value, 2];
                            z = z + 1;
                        end
                    end
                end
                
                % North West
                if (i > 1) && (j > 1)
                    if (board(i-1, j-1) == 0)
                        priorPos = i*10+j;
                        postPos = (i-1)*10+j-1;
                        
                        testerBoard = makeMove(priorPos, postPos, 26, board);
                        check = fastamIChecked_mex(testerBoard, 2);
                        if (check == false)
                            legalMoves(:,z) = [priorPos, postPos, 26, 0, 1];
                            z = z + 1;
                        end
                        
                        % attacking
                    elseif (board(i-1, j-1) < 20) &&  board(i-1, j-1) ~= 26
                        priorPos = i*10+j;
                        postPos = (i-1)*10+j-1;
                        
                        testerBoard = makeMove(priorPos, postPos, 26, board);
                        check = fastamIChecked_mex(testerBoard, 2);
                        if (check == false)
                            value = board(i-1, j-1) - 10;
                            legalMoves(:,z) = [priorPos, postPos, 26, value, 2];
                            z = z + 1;
                        end
                    end
                end
                
                % South East
                if (i < 8) && (j < 8)
                    if (board(i+1, j+1) == 0)
                        priorPos = i*10+j;
                        postPos = (i+1)*10+j+1;
                        
                        testerBoard = makeMove(priorPos, postPos, 26, board);
                        check = fastamIChecked_mex(testerBoard, 2);
                        if (check == false)
                            legalMoves(:,z) = [priorPos, postPos, 26, 0, 1];
                            z = z + 1;
                        end
                        
                        % attacking
                    elseif (board(i+1, j+1) < 20) &&  board(i+1, j+1) ~= 26
                        priorPos = i*10+j;
                        postPos = (i+1)*10+j+1;
                        
                        testerBoard = makeMove(priorPos, postPos, 26, board);
                        check = fastamIChecked_mex(testerBoard, 2);
                        if (check == false)
                            value = board(i+1, j+1) - 10;
                            legalMoves(:,z) = [priorPos, postPos, 26, value, 2];
                            z = z + 1;
                        end
                    end
                end
                
                % South West
                if (i < 8) && (j > 1)
                    if (board(i+1, j-1) == 0)
                        priorPos = i*10+j;
                        postPos = (i+1)*10+j-1;
                        
                        testerBoard = makeMove(priorPos, postPos, 26, board);
                        check = fastamIChecked_mex(testerBoard, 2);
                        if (check == false)
                            legalMoves(:,z) = [priorPos, postPos, 26, 0, 1];
                            z = z + 1;
                        end
                        
                        % attacking
                    elseif (board(i+1, j-1) < 20) &&  board(i+1, j-1) ~= 26
                        priorPos = i*10+j;
                        postPos = (i+1)*10+j-1;
                        
                        testerBoard = makeMove(priorPos, postPos, 26, board);
                        check = fastamIChecked_mex(testerBoard, 2);
                        if (check == false)
                            value = board(i+1, j-1) - 10;
                            legalMoves(:,z) = [priorPos, postPos, 26, value, 2];
                            z = z + 1;
                        end
                    end
                end
                
                % Left Castle
                if board(1,2) == 0 && board(1,3) == 0 && board(1,4) == 0 && board(9,5) == 0 && board(9,4) == 0 && board(1,1) == 24
                    check = fastamIChecked_mex(board, 2);
                    if (check == false)
                        fakeBoard = makeMove(15, 14, 26, board);
                        check = fastamIChecked_mex(fakeBoard, 2);
                        if (check == false)
                            fakeBoard = makeMove(14, 13, 26, fakeBoard);
                            check = fastamIChecked_mex(fakeBoard, 2);
                            if (check == false)
                                legalMoves(:,z) = [15, 13, 26, 3, 1];
                                z = z + 1;
                            end
                        end
                    end
                end
                
                
                
                % Right Castle
                if board(1,6) == 0 && board(1,7) == 0 && board(9,6) == 0 && board(9,4) == 0 && board(1,8) == 24
                    check = fastamIChecked_mex(board, 2);
                    if (check == false)
                        fakeBoard = makeMove(15, 16, 26, board);
                        check = fastamIChecked_mex(fakeBoard, 2);
                        if (check == false)
                            fakeBoard = makeMove(16, 17, 26, fakeBoard);
                            check = fastamIChecked_mex(fakeBoard, 2);
                            if (check == false)
                                legalMoves(:,z) = [15, 17, 26, 3, 1];
                                z = z + 1;
                            end
                        end
                    end
                end
            end
        end
    end
end


checked = false;
legalMoves = legalMoves(:, 1:(z-1));
checked = fastamIChecked_mex(board, colour);
actualLegalMoves = zeros(5, z);
j =1;
if checked == 1
    for i = 1:size(legalMoves, 2)
        testerBoard = makeMove(legalMoves(1, i), legalMoves(2, i),legalMoves(3, i), board);
        checked = fastamIChecked_mex(testerBoard, colour);
        if checked == 0
            actualLegalMoves(:, j) = legalMoves(:, i);
            j = j+1;
        end
    end
    actualLegalMoves = actualLegalMoves(:, 1:(j-1));
    legalMoves = actualLegalMoves;
end

end