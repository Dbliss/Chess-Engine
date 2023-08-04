function value = fastpositionValue(board, colour)
    % pawn = 100
    % knight = 288
    % bishop = 345
    % rook = 480
    % queen = 1077
   
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
     5  10  10  10  10  10  10   5;
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
     20  30  10   0   0  10  30  20
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
    pawnRow = zeros(8);
    pawnCol = zeros(8);
    wp = 1;
    
    blackPawnRow = zeros(8);
    blackPawnCol = zeros(8);
    bp = 1;
    
    knightRow = zeros(2);
    knightCol = zeros(2);
    wk = 1;
    
    blackKnightRow = zeros(2);
    blackKnightCol = zeros(2);
    bk = 1;
    
    bishopRow = zeros(2);
    bishopCol = zeros(2);
    wb = 1;
    
    bBishopRow = zeros(2);
    bBishopCol = zeros(2);
    bb = 1;
    
    rookRow = zeros(2);
    rookCol = zeros(2);
    wr = 1;
    
    brookRow = zeros(2);
    brookCol = zeros(2);
    br = 1;
    
    wQueenRow = zeros(3);
    wQueenCol = zeros(3);
    wq = 1;
    
    bQueenRow = zeros(3);
    bQueenCol = zeros(3);
    bq = 1;
    
     piecesLeft = 2;
    
    % Find the location of all pieces
    for i = 1:8
        for j = 1:8
            if board(i, j) == 0
                continue;
            elseif board(i, j) == 16
                whiteKingRow = i;
                whiteKingCol = j;
            elseif board(i, j) == 26
                blackKingRow = i;
                blackKingCol = j;
            elseif board(i, j) == 11
                pawnRow(wp) = i;
                pawnCol(wp) = j;
                wp = wp + 1;
                value = value + 100;
            elseif board(i, j) == 12
                knightRow(wk) = i;
                knightCol(wk) = j;
                wk = wk + 1;
                piecesLeft = piecesLeft + 1;
                value = value + 288;
            elseif board(i, j) == 13
                bishopRow(wb) = i;
                bishopCol(wb) = j;
                wb = wb + 1;
                piecesLeft = piecesLeft + 1;
                value = value + 345;
            elseif board(i, j) == 14
                rookRow(wr) = i;
                rookCol(wr) = j;
                wr = wr + 1;    
                piecesLeft = piecesLeft + 1;
                value = value + 480;
            elseif board(i, j) == 15
                wQueenRow(wq) = i;
                wQueenCol(wq) = j;
                wq = wq + 1;
                piecesLeft = piecesLeft + 1;
                value = value + 1077;
            elseif board(i, j) == 21
                blackPawnRow(bp) = i;
                blackPawnCol(bp) = j;
                bp = bp + 1;
                value = value - 100;
            elseif board(i, j) == 22
                blackKnightRow(bk) = i;
                blackKnightCol(bk) = j;
                bk = bk + 1;
                piecesLeft = piecesLeft + 1;
                value = value - 288;
            elseif board(i, j) == 23
                bBishopRow(bb) = i;
                bBishopCol(bb) = j;
                bb = bb + 1;
                piecesLeft = piecesLeft + 1;
                value = value - 345;
            elseif board(i, j) == 24
                brookRow(br) = i;
                brookCol(br) = j;
                br = br + 1; 
                piecesLeft = piecesLeft + 1;
                value = value - 480;
            elseif board(i, j) == 25
                bQueenRow(bq) = i;
                bQueenCol(bq) = j;
                bq = bq + 1;
                piecesLeft = piecesLeft + 1;
                value = value - 1077;
            end
        end
    end
    
    %add values of all white pawn positioning
    %by another pawn
    for i = 1:size(pawnRow, 1)
        if pawnRow(i) == 0
            break;
        end
        northRow = pawnRow(i)-1;
        westCol = pawnCol(i)-1;
        eastCol = pawnCol(i)+1;
        
        value = value + pawn_table(pawnRow(i), pawnCol(i));
        
        if northRow < 9 && westCol > 0
            % looking at piece north west of white pawn
            if board(northRow,westCol) == 11
                value = value + 10;
            elseif board(northRow,westCol) == 12
                value = value + 10;
            elseif board(northRow,westCol) == 13
                value = value + 30;
            elseif board(northRow,westCol) == 14
                value = value + 10;
            elseif board(northRow,westCol) == 15
                value = value + 10;
            end 
        end
        
        if northRow < 9 && eastCol < 9
            % looking at piece north east of white pawn
            if board(northRow,eastCol) == 11
                value = value + 10;
            elseif board(northRow,eastCol) == 12
                value = value + 10;
            elseif board(northRow,eastCol) == 13
                value = value + 30;
            elseif board(northRow,eastCol) == 14
                value = value + 10;
            elseif board(northRow,eastCol) == 15
                value = value + 10;
            end  
        end

    end

    %add values of all black pawn positioning
    for i = 1:size(blackPawnRow, 1)
        if blackPawnRow(i) == 0
            break;
        end
        southRow = blackPawnRow(i)+1;
        westCol = blackPawnCol(i)-1;
        eastCol = blackPawnCol(i)+1;
        value = value - pawn_table(9-blackPawnRow(i), blackPawnCol(i));
        if southRow > 0 && westCol > 0
            % looking at piece south west of black pawn
            if board(southRow,westCol) == 21
                value = value - 10;
            elseif board(southRow,westCol) == 22
                value = value - 10;
            elseif board(southRow,westCol) == 23
                value = value - 30;
            elseif board(southRow,westCol) == 24
                value = value - 10;
            elseif board(southRow,westCol) == 25
                value = value - 10;
            end 
        end
        
        if southRow > 0 && eastCol < 9
            % looking at piece north east of black pawn
            if board(southRow,eastCol) == 21
                value = value - 10;
            elseif board(southRow,eastCol) == 22
                value = value - 10;
            elseif board(southRow,eastCol) == 23
                value = value - 30;
            elseif board(southRow,eastCol) == 24
                value = value - 10;
            elseif board(southRow,eastCol) == 25
                value = value - 10;
            end
        end      
    end

    
    %add value if knight if central
    for i = 1:size(knightRow, 1)
        if knightRow(i) == 0
            break;
        end
        value = value + knight_table(knightRow(i), knightCol(i));
    end

    %add value if knight if central
    for i = 1:size(blackKnightRow, 1)
        if blackKnightRow(i) == 0
            break;
        end
        value = value - knight_table(9-blackKnightRow(i), blackKnightCol(i));
    end
   

    %add value if bishops are in optimal postions
    for i = 1:size(bishopRow, 1)
        if bishopRow(i) == 0
            break;
        end
        row = bishopRow(i);
        col = bishopCol(i);
        
        % white bishop pair more valuable for an open game (less pawns / little less important if there is alot of our pawns)
        if i == 2
            value = value + 100/(size(blackPawnRow, 1) + 0.5*size(pawnRow, 1));
        end
            
        value = value + bishop_table(row, col);
        
        %bishop reach + pairs 
        for j = 1:7
            %bishop south east 
            if row+j < 9 && col+j < 9
                if board(row+j, col+j) == 0
                    value = value + 4; 
                elseif board(row+j, col+j) == 16
                    value = value + 35;
                else
                    break;
                end
            end
        end
            
        for j = 1:7
            %bjshop south west 
            if row+j < 9 && col-j > 0
                if board(row+j, col-j) == 0
                    value = value + 4; 
                elseif board(row+j, col-j) == 16
                    value = value + 35;
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
                    value = value + 35;
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
                    value = value + 35;
                else
                    break;
                end
            end
        end
    end

    %add value if bishops are in optimal postions
    for i = 1:size(bBishopRow, 1)
        if bBishopRow(i) == 0
            break;
        end
        row = bBishopRow(i);
        col = bBishopCol(i);
        value = value - bishop_table(9-row,col);
        
        % white bishop pair more valuable for an open game (less pawns / little less important if there is alot of our pawns)
        if i == 2
            value = value - 100/(size(pawnRow, 1) + 0.5*size(blackPawnRow, 1));
        end
        %bishop reach + pairs 
        for j = 1:7
            %bishop south east 
            if row+j < 9 && col+j < 9
                if board(row+j, col+j) == 0
                    value = value - 4; 
                elseif board(row+j, col+j) == 26
                    value = value - 35;
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
                    value = value - 35;
                else
                    break;
                end
            end
        end
            
        for j = 1:7
            %bishop north east 
            if row-j > 0 && col+j < 9
                if board(row-j, col+j) == 0
                    value = value - 4; 
                elseif board(row-j, col+j) == 26
                    value = value - 35;
                else
                    break;
                end
            end
        end
            
        for j = 1:7
            %bishop north west 
            if row-j > 0 && col-j > 0
                if board(row-j, col-j) == 0
                    value = value - 4; 
                elseif board(row-j, col-j) == 26
                    value = value - 35;
                else
                    break;
                end
            end
        end
    end

    %add value if rooks are in optimal postions
    for i = 1:size(rookRow, 1)
        if rookRow(i) == 0
            break;
        end
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
              value = value + 1; 
           elseif board(row, col+j) == 14 || board(row, col+j) == 16
              value = value + 35;
           else
               break;
           end
        end

        %rook west spots
        for j = 1:(col-1)
           if board(row, col-j) == 0
              value = value + 1; 
           elseif board(row, col-j) == 14 || board(row, col-j) == 16
              value = value + 35;
           else
               break;
           end
        end

    end

    %add value if rooks are in optimal postions
    for i = 1:size(brookRow, 1)
        if brookRow(i) == 0
            break;
        end
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
              value = value - 1; 
           elseif board(row, col+j) == 24 || board(row, col+j) == 26
              value = value - 35;
           else
               break;
           end
        end

        %rook west spots
        for j = 1:(col-1)
           if board(row, col-j) == 0
              value = value - 1; 
           elseif board(row, col-j) == 24 || board(row, col-j) == 26
              value = value - 35;
           else
               break;
           end
        end
    end

    %add value if queens are in optimal postions
    for i = 1:size(wQueenRow, 1)
        if wQueenRow(i) == 0
            break;
        end
        row = wQueenRow(i);
        col = wQueenCol(i);
        value = value + queen_table(row, col);
    end

    %add value if queens are in optimal postions
    for i = 1:size(bQueenRow, 1)
        if bQueenRow(i) == 0
            break;
        end
        row = bQueenRow(i);
        col = bQueenCol(i);
        value = value - queen_table(9-row, col);
    end
    
    if piecesLeft > 6
        value = value + king_table_midgame(whiteKingRow, whiteKingCol);
        
        %king safety and mobility
        if whiteKingRow - 1 > 0
           if board(whiteKingRow-1, whiteKingCol) == 11 || board(whiteKingRow-1, whiteKingCol) == 13
               value = value + 15;
           end
                      
           if whiteKingCol -1 > 0
                if board(whiteKingRow-1, whiteKingCol-1) == 11
                    value = value + 15;
                end
           end
           
           if whiteKingCol+1 < 9
                if board(whiteKingRow-1, whiteKingCol+1) == 11
                    value = value + 15;
                end
           end
        end
        
        if whiteKingCol-1 > 0
            if board(whiteKingRow, whiteKingCol-1) == 0
                value = value + 10;
            end    
        end
        
        if whiteKingCol+1 < 9
            if board(whiteKingRow, whiteKingCol+1) == 0
                value = value + 10;
            end    
        end
        
        
        
        value = value - king_table_midgame(9-blackKingRow, blackKingCol);
        
        
        % black king safety and mobility
        if blackKingRow + 1 < 9
           if board(blackKingRow+1, blackKingCol) == 21 || board(blackKingRow+1, blackKingCol) == 23
               value = value - 15;
           end
                      
           if blackKingCol -1 > 0
                if board(blackKingRow+1, blackKingCol-1) == 21
                    value = value - 15;
                end
           end
           
           if blackKingCol+1 < 9
                if board(blackKingRow+1, blackKingCol+1) == 21
                    value = value - 15;
                end
           end
        end
        
        if blackKingCol-1 > 0
            if board(blackKingRow, blackKingCol-1) == 0
                value = value - 10;
            end    
        end
        
        if blackKingCol+1 < 9
            if board(blackKingRow, blackKingCol+1) == 0
                value = value - 10;
            end    
        end
    end
   % Check if it's an endgame scenario
    if piecesLeft <= 6
        value = value + king_table_endgame(whiteKingRow, whiteKingCol);
        value = value - king_table_endgame(9-blackKingRow, blackKingCol);
    end
    
    
    
    if piecesLeft <= 6
        if value > 400
            distBetweenKings = sqrt((whiteKingRow - blackKingRow)^2 + (whiteKingCol - blackKingCol)^2);
            value = value + 140 - 20*distBetweenKings;
        elseif value < -400
            distBetweenKings = sqrt((whiteKingRow - blackKingRow)^2 + (whiteKingCol - blackKingCol)^2);
            value = value - 140 + 20*distBetweenKings;
        end
        
    end    
    
   
    
    if colour == 2
        value = -value;
    end


end