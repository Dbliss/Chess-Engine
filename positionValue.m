function value = positionValue(board, colour)
    pawnVal = 100;
    knightVal = 325;
    bishopVal = 325;
    rookVal = 500;
    queenVal = 975;
   
    % if colour = 1, then its whites turn to move
    % if colour = 2, then its blacks turn to move
    
    % Piece Square Tables (PSTs) for each piece type
pawn_table = [
    0   0   0   0   0   0   0   0;
    50  50  50  50  50  50  50  50;
    10  10  20  30  30  20  10  10;
     5   5  10  25  25  10   5   5;
     0   0   0  20  20   0   0   0;
     5  -5 -10   0   0 -10  -5   5;
     5  10  10 -20 -20  10  10   5;
     0   0   0   0   0   0   0   0
];

knight_table = [
    -50 -40 -30 -30 -30 -30 -40 -50;
    -40 -20   0   0   0   0 -20 -40;
    -30   0  10  15  15  10   0 -30;
    -30   5  15  20  20  15   5 -30;
    -30   0  15  20  20  15   0 -30;
    -30   5  10  15  15  10   5 -30;
    -40 -20   0   5   5   0 -20 -40;
    -50 -40 -30 -30 -30 -30 -40 -50
];

bishop_table = [
    -20 -10 -10 -10 -10 -10 -10 -20;
    -10   0   0   0   0   0   0 -10;
    -10   0   5  10  10   5   0 -10;
    -10   5   5  10  10   5   5 -10;
    -10   0  10  10  10  10   0 -10;
    -10  10  10  10  10  10  10 -10;
    -10   5   0   0   0   0   5 -10;
    -20 -10 -10 -10 -10 -10 -10 -20
];

rook_table = [
     0   0   0   0   0   0   0   0;
     5  10  10  15  15  10  10   5;
    -5   0   0   0   0   0   0  -5;
    -5   0   0   0   0   0   0  -5;
    -5   0   0   0   0   0   0  -5;
    -5   0   0   0   0   0   0  -5;
    -5   0   0   0   0   0   0  -5;
     0   0   0   5   5   0   0   0
];

queen_table = [
    -20 -10 -10  -5  -5 -10 -10 -20;
    -10   0   0   0   0   0   0 -10;
    -10   0   5   5   5   5   0 -10;
     -5   0   5   5   5   5   0  -5;
      0   0   5   5   5   5   0  -5;
    -10   5   5   5   5   5   0 -10;
    -10   0   5   0   0   0   0 -10;
    -20 -10 -10  -5  -5 -10 -10 -20
];

king_table_midgame = [
    -30 -40 -40 -50 -50 -40 -40 -30;
    -30 -40 -40 -50 -50 -40 -40 -30;
    -30 -40 -40 -50 -50 -40 -40 -30;
    -30 -40 -40 -50 -50 -40 -40 -30;
    -20 -30 -30 -40 -40 -30 -30 -20;
    -10 -20 -20 -20 -20 -20 -20 -10;
     20  20   0   0   0   0  20  20;
     25  35  15   0   0   5  35  25
];

king_table_endgame = [
    -50 -40 -30 -20 -20 -30 -40 -50;
    -30 -20 -10   0   0 -10 -20 -30;
    -30 -10  20  30  30  20 -10 -30;
    -30 -10  30  40  40  30 -10 -30;
    -30 -10  30  40  40  30 -10 -30;
    -30 -10  20  30  30  20 -10 -30;
    -30 -30   0   0   0   0 -30 -30;
    -50 -30 -30 -30 -30 -30 -30 -50
];
    value = 0;
    
    % Value of all white pawns
    [pawnRow, pawnCol] = find(board == 11);
    
    % Value of all black pawns
    [blackPawnRow, blackPawnCol] = find(board == 21);
    
    % value of all white knights
    [knightRow, knightCol] = find(board == 12);
    
    % value of all black knights
    [blackKnightRow, blackKnightCol] = find(board == 22);
    
    % value of all white bishops
    [bishopRow, bishopCol] = find(board == 13);
    
    % value of all black bishops
    [bBishopRow, bBishopCol] = find(board == 23);
    
    % value of all white rooks
    [rookRow, rookCol] = find(board == 14);
    
    % value of all black rooks
    [brookRow, brookCol] = find(board == 24);
    
    % value of all white queens
    [wQueenRow, wQueenCol] = find(board == 15);
    
    % value of all black queens
    [bQueenRow, bQueenCol] = find(board == 25);
    
    % value for white king position
    [wrow, wcol] = find(board == 16, 1, 'first');
    
    % value for black king position
    [brow, bcol] = find(board == 26, 1, 'first');
    
    % To determine endgame evaluation
    piecesLeft = size(knightRow, 1) + size(blackKnightRow, 1) + size(bishopRow, 1) + size(bBishopRow, 1) + size(rookRow, 1) + size(brookRow, 1) + size(wQueenRow, 1) + size(bQueenRow, 1);
    
    numOfPawns = size(pawnRow, 1) + size(blackPawnRow, 1);
    
    % For strength of bishop pair
    bishopPairStength = -1/5*(numOfPawns-16)*(numOfPawns+16);
    
    % For strength of small pieces (knight/bishop)
    m=-0.01648351648;
    smallPieceMultiplier = -m*piecesLeft + 12*m + 1;
    
    value = value + pawnVal*size(pawnRow, 1);
    value = value - pawnVal*size(blackPawnRow, 1);
    
    value = value + knightVal*size(knightRow, 1)*smallPieceMultiplier;
    value = value - knightVal*size(blackKnightRow, 1)*smallPieceMultiplier;
    
    value = value + bishopVal*size(bishopRow, 1)*smallPieceMultiplier;
    value = value - bishopVal*size(bBishopRow, 1)*smallPieceMultiplier;
    
    value = value + rookVal*size(rookRow, 1)/smallPieceMultiplier;
    value = value - rookVal*size(brookRow, 1)/smallPieceMultiplier;
    
    value = value + queenVal*size(wQueenRow, 1);
    value = value - queenVal*size(bQueenRow, 1);
    
    %add values of all white pawn positioning
    %by another pawn
    for i = 1:size(pawnRow, 1)
        northRow = pawnRow(i)-1;
        westCol = pawnCol(i)-1;
        eastCol = pawnCol(i)+1;
        
        value = value + pawn_table(pawnRow(i), pawnCol(i));
        
        if piecesLeft <= 6 && size(rookRow, 1) == 0 && size(wQueenRow, 1) == 0
            value = value + (7 - pawnRow(i))*35;
        end
        
        
        if northRow < 9 && westCol > 0
            % looking at piece north west of white pawn
            if board(northRow,westCol) == 11
                value = value + 5;
            elseif board(northRow,westCol) == 12
                value = value + 5;
            elseif board(northRow,westCol) == 13
                value = value + 20;
            elseif board(northRow,westCol) == 14
                value = value + 5;
            elseif board(northRow,westCol) == 15
                value = value + 5;
            end 
        end
        
        if northRow < 9 && eastCol < 9
            % looking at piece north east of white pawn
            if board(northRow,eastCol) == 11
                value = value + 5;
            elseif board(northRow,eastCol) == 12
                value = value + 5;
            elseif board(northRow,eastCol) == 13
                value = value + 20;
            elseif board(northRow,eastCol) == 14
                value = value + 5;
            elseif board(northRow,eastCol) == 15
                value = value + 5;
            end  
        end
    end

    %add values of all black pawn positioning
    for i = 1:size(blackPawnRow, 1)
        southRow = blackPawnRow(i)+1;
        westCol = blackPawnCol(i)-1;
        eastCol = blackPawnCol(i)+1;
        value = value - pawn_table(9-blackPawnRow(i), blackPawnCol(i));
        
        if piecesLeft <= 6 && size(brookRow, 1) == 0 && size(bQueenRow, 1) == 0
            value = value - (blackPawnRow(i)-2)*35;
        end
        
        if southRow > 0 && westCol > 0
            % looking at piece south west of black pawn
            if board(southRow,westCol) == 21
                value = value - 5;
            elseif board(southRow,westCol) == 22
                value = value - 5;
            elseif board(southRow,westCol) == 23
                value = value - 20;
            elseif board(southRow,westCol) == 24
                value = value - 5;
            elseif board(southRow,westCol) == 25
                value = value - 5;
            end 
        end
        
        if southRow > 0 && eastCol < 9
            % looking at piece north east of black pawn
            if board(southRow,eastCol) == 21
                value = value - 5;
            elseif board(southRow,eastCol) == 22
                value = value - 5;
            elseif board(southRow,eastCol) == 23
                value = value - 20;
            elseif board(southRow,eastCol) == 24
                value = value - 5;
            elseif board(southRow,eastCol) == 25
                value = value - 5;
            end
        end
        
    end

    
     
    %add value if knight if central
    for i = 1:size(knightRow, 1)
        value = value + knight_table(knightRow(i), knightCol(i));
    end

    %add value if knight if central
    for i = 1:size(blackKnightRow, 1)
        value = value - knight_table(9-blackKnightRow(i), blackKnightCol(i));
    end
   

    %add value if bishops are in optimal postions
    for i = 1:size(bishopRow, 1)
        row = bishopRow(i);
        col = bishopCol(i);
        
        % white bishop pair more valuable for an open game (less pawns / little less important if there is alot of our pawns)
        if i == 2
            value = value + bishopPairStength;
        end
            
        value = value + bishop_table(row, col);
        
        %bishop reach + pairs 
        for j = 1:7
            %bishop south east 
            if row+j < 9 && col+j < 9
                if board(row+j, col+j) == 0
                    value = value + 2; 
                elseif board(row+j, col+j) == 16
                    value = value + 25;
                else
                    break;
                end
            end
        end
            
        for j = 1:7
            %bjshop south west 
            if row+j < 9 && col-j > 0
                if board(row+j, col-j) == 0
                    value = value + 2; 
                elseif board(row+j, col-j) == 16
                    value = value + 25;
                else
                    break;
                end
            end
        end
            
        for j = 1:7
            %bishop north east 
            if row-j > 0 && col+j < 9
                if board(row-j, col+j) == 0
                    value = value + 4; 
                elseif board(row-j, col+j) == 16
                    value = value + 25;
                else
                    break;
                end
            end
        end
            
        for j = 1:7
            %bishop north west 
            if row-j > 0 && col-j > 0
                if board(row-j, col-j) == 0
                    value = value + 4; 
                elseif board(row-j, col-j) == 16
                    value = value + 25;
                else
                    break;
                end
            end
        end
    end

    %add value if bishops are in optimal postions
    for i = 1:size(bBishopRow, 1)
        row = bBishopRow(i);
        col = bBishopCol(i);
        value = value - bishop_table(9-row,col);
        
        % white bishop pair more valuable for an open game (less pawns / little less important if there is alot of our pawns)
        if i == 2
            value = value - bishopPairStength;
        end
        %bishop reach + pairs 
        for j = 1:7
            %bishop south east 
            if row+j < 9 && col+j < 9
                if board(row+j, col+j) == 0
                    value = value - 4; 
                elseif board(row+j, col+j) == 26
                    value = value - 25;
                else
                    break;
                end
            end
        end
            
        for j = 1:7
            %bishop south west 
            if row+j < 9 && col-j > 0
                if board(row+j, col-j) == 0
                    value = value - 4; 
                elseif board(row+j, col-j) == 26
                    value = value - 25;
                else
                    break;
                end
            end
        end
            
        for j = 1:7
            %bishop north east 
            if row-j > 0 && col+j < 9
                if board(row-j, col+j) == 0
                    value = value - 2; 
                elseif board(row-j, col+j) == 26
                    value = value - 25;
                else
                    break;
                end
            end
        end
            
        for j = 1:7
            %bishop north west 
            if row-j > 0 && col-j > 0
                if board(row-j, col-j) == 0
                    value = value - 2; 
                elseif board(row-j, col-j) == 26
                    value = value - 25;
                else
                    break;
                end
            end
        end
    end

    %add value if rooks are in optimal postions
    for i = 1:size(rookRow, 1)
        row = rookRow(i);
        col = rookCol(i);
        value = value + rook_table(row, col);
        
        %rook north spots
        for j = 1:(row-1)
           if board(row-j, col) == 0
              value = value + 5; 
           elseif board(row-j, col) == 14 || board(row-j, col) == 16
              value = value + 35;
           else
               break;
           end
        end

        %rook south spots
        for j = 1:(8-row)
           if board(row+j, col) == 0
              value = value + 5; 
           elseif board(row+j, col) == 14 || board(row+j, col) == 16 
              value = value + 35;
           else
               break;
           end
        end

        %rook east spots
        for j = 1:(8-col)
           if board(row, col+j) == 0
              value = value + 2; 
           elseif board(row, col+j) == 14 || board(row, col+j) == 16
              value = value + 35;
           else
               break;
           end
        end

        %rook west spots
        for j = 1:(col-1)
           if board(row, col-j) == 0
              value = value + 2; 
           elseif board(row, col-j) == 14 || board(row, col-j) == 16
              value = value + 35;
           else
               break;
           end
        end

    end

    %add value if rooks are in optimal postions
    for i = 1:size(brookRow, 1)
        row = brookRow(i);
        col = brookCol(i);
        value = value - rook_table(9-row, col);
   
        %rook north spots
        for j = 1:(row-1)
           if board(row-j, col) == 0
              value = value - 5; 
           elseif board(row-j, col) == 24 || board(row-j, col) == 26
              value = value - 35;
           else
               break;
           end
        end

        %rook south spots
        for j = 1:(8-row)
           if board(row+j, col) == 0
              value = value - 5; 
           elseif board(row+j, col) == 24 || board(row+j, col) == 26
              value = value - 35;
           else
               break;
           end
        end

        %rook east spots
        for j = 1:(8-col)
           if board(row, col+j) == 0
              value = value - 2; 
           elseif board(row, col+j) == 24 || board(row, col+j) == 26
              value = value - 35;
           else
               break;
           end
        end

        %rook west spots
        for j = 1:(col-1)
           if board(row, col-j) == 0
              value = value - 2; 
           elseif board(row, col-j) == 24 || board(row, col-j) == 26
              value = value - 35;
           else
               break;
           end
        end
    end

    %add value if queens are in optimal postions
    for i = 1:size(wQueenRow, 1)
        row = wQueenRow(i);
        col = wQueenCol(i);
        value = value + queen_table(row, col);
    end

    %add value if queens are in optimal postions
    for i = 1:size(bQueenRow, 1)
        row = bQueenRow(i);
        col = bQueenCol(i);
        value = value - queen_table(9-row, col);
    end
    
    queensOnBoard = size(wQueenRow, 1) + size(bQueenRow, 1);
    
    if piecesLeft >= 4 && queensOnBoard > 0
        for i = 1:size(wrow, 1)
            value = value + king_table_midgame(wrow(i), wcol(i));

            %king safety and mobility
            if bcol(i) == 7 || bcol(i) == 8 || bcol(i) == 1 || bcol(i) == 2
               if board(brow(i)+1, bcol(i)) == 0
                   value = value - 40;
               else
                   value = value + 15;
               end
            end

            if wcol(i)-1 > 0
                if board(wrow(i), wcol(i)-1) == 0
                    value = value + 5;
                end    
            end

            if wcol(i)+1 < 9
                if board(wrow(i), wcol(i)+1) == 0
                    value = value + 5;
                end    
            end
        end
    end

    
    if piecesLeft >= 4 && queensOnBoard > 0
        for i = 1:size(brow, 1)
            value = value - king_table_midgame(9-brow(i), bcol(i));

            %king safety and mobility
            if bcol(i) == 7 || bcol(i) == 8 || bcol(i) == 1 || bcol(i) == 2
               if board(brow(i)+1, bcol(i)) == 0
                   value = value + 40;
               else
                   value = value - 15;
               end
            end

            if bcol(i)-1 > 0
                if board(brow(i), bcol(i)-1) == 0
                    value = value - 5;
                end    
            end

            if bcol(i)+1 < 9
                if board(brow(i), bcol(i)+1) == 0
                    value = value - 5;
                end    
            end
        end
    end
    
   % Check if it's an endgame scenario
    if piecesLeft <= 4 || queensOnBoard == 0
        for i = 1:size(brow, 1)
            value = value + king_table_endgame(wrow(i), wcol(i));
            value = value - king_table_endgame(9-brow(i), bcol(i));
            
            if value > 400
                distBetweenKings = sqrt((wrow(i) - brow(i))^2 + (wcol(i) - bcol(i))^2);
                value = value + 140 - 20*distBetweenKings;
            elseif value < -400
                distBetweenKings = sqrt((wrow(i) - brow(i))^2 + (wcol(i) - bcol(i))^2);
                value = value - 140 + 20*distBetweenKings;
            end
        end
        
        % incentivise trading with an advantage
        value = value*20/(piecesLeft+numOfPawns);
    end

    
    if colour == 2
        value = -value;
    end


end