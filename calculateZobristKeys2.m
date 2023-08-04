function zobristKey = calculateZobristKeys2(board, zKeys)
    % Initialize Zobrist key
    zobristKey = uint64(0);
    
    % Piece type mapping
    pieceConverter = [11 1; 12 2; 13 3; 14 4; 15 5; 16 6; 21 7; 22 8; 23 9; 24 10; 25 11; 26 12];
    pieceTypes = zeros(1, 26);
    pieceTypes(pieceConverter(:, 1)) = pieceConverter(:, 2);
    
    % Precompute boardSize
    boardSize = [8, 8];
    
    % Iterate over the board
    for row = 1:8
        for col = 1:8
            piece = board(row, col);

            if piece ~= 0
                % Get piece type and square index using the precomputed mapping
                pieceType = pieceTypes(piece);
                squareIndex = (row - 1) * 8 + col;
                
                % Update Zobrist key
                zobInd = (squareIndex - 1) * boardSize(1) + pieceType;
                zobristKey = bitxor(zobristKey, zKeys(zobInd));
            end
        end
    end
    
    % Update en passant information in the Zobrist key
    enPassantColWhite = board(9, 7);
    enPassantColBlack = board(9, 8);
    zobristKey = bitxor(zobristKey, zKeys(769 + enPassantColWhite));
    zobristKey = bitxor(zobristKey, zKeys(778 + enPassantColBlack));

    % Update castling information in the Zobrist key
    castlingOffsets = [787, 789, 791, 793, 795, 797];
    for i = 1:6
        offset = castlingOffsets(i);
        if board(9, i) == 1
            zobristKey = bitxor(zobristKey, zKeys(offset));
        else
            zobristKey = bitxor(zobristKey, zKeys(offset + 1));
        end
    end

    % Is it white or black's turn?
    if board(10, 1) == 1
        % white's turn
        zobristKey = bitxor(zobristKey, zKeys(799));
    else
        % black's turn
        zobristKey = bitxor(zobristKey, zKeys(800));
    end
end