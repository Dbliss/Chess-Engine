function zobristKey = calculateZobristKey(board, zKeys)    
    % Initialize Zobrist key
    zobristKey = 0;
    
    % Piece type mapping
    pieceConverter = [11 1; 12 2; 13 3; 14 4; 15 5; 16 6; 21 7; 22 8; 23 9; 24 10; 25 11; 26 12];
    
    function ind = mySub2ind(boardSize, pieceType, squareIndex)
        ind = (squareIndex - 1) * boardSize(1) + pieceType;
    end
    
    % Iterate over the board
    for row = 1:8
        for col = 1:8
            piece = board(row, col);

            if piece ~= 0
                % Get piece type and square index
                pieceType = find(pieceConverter(:, 1) == piece, 1);
                squareIndex = (row-1) * 8 + col;
                
                % Update Zobrist key
                zobInd = mySub2ind([64 12], squareIndex, pieceType);
                zobristKey = bitxor(zobristKey,zKeys(zobInd));
            end
        end
    end
    % Update en passant information in the Zobrist key
    enPassantColWhite = board(9, 7);
    enPassantColBlack = board(9, 8);
    zobristKey = bitxor(zobristKey, zKeys(769+enPassantColWhite));
    zobristKey = bitxor(zobristKey, zKeys(778+enPassantColBlack));

    % Update castling information in the Zobrist key
    
    % has white king moved?
    if board(9, 1) == 1
        zobristKey = bitxor(zobristKey, zKeys(787));
    else
        zobristKey = bitxor(zobristKey, zKeys(788));
    end
    
    % has white left rook moved?
    if board(9, 2) == 1
        zobristKey = bitxor(zobristKey, zKeys(789));
    else
        zobristKey = bitxor(zobristKey, zKeys(790));
    end
    
    % has white right rook moved?
    if board(9, 3) == 1
        zobristKey = bitxor(zobristKey, zKeys(791));
    else
        zobristKey = bitxor(zobristKey, zKeys(792));
    end
    
    % has black king moved?
    if board(9, 4) == 1
        zobristKey = bitxor(zobristKey, zKeys(793));
    else
        zobristKey = bitxor(zobristKey, zKeys(794));
    end
    
    % has black left rook moved?
    if board(9, 5) == 1
        zobristKey = bitxor(zobristKey, zKeys(795));
    else
        zobristKey = bitxor(zobristKey, zKeys(796));
    end
    
    % has black right rook moved?
    if board(9, 6) == 1
        zobristKey = bitxor(zobristKey, zKeys(797));
    else
        zobristKey = bitxor(zobristKey, zKeys(798));
    end
  
    
%     % Is it white or blacks turn?
%     if board(10, 1) == 1
%         % whites turn
%         zobristKey = bitxor(zobristKey, zKeys(798));
%     else
%         % blacks turn
%         zobristKey = bitxor(zobristKey, zKeys(799));
%     end
end