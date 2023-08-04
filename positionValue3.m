function value = positionValue3(board)
colour = board(10,1);
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

pawn_table_endgame = [
    0  0  0  0  0  0  0  0;
    50 50 50 50 50 50 50 50;
    40 40 40 40 40 40 40 40;
    30 30 30 30 30 30 30 30;
    20 20 20 20 20 20 20 20;
    10 10 10 10 10 10 10 10;
    0  0  0  0  0  0  0  0;
    0  0  0  0  0  0  0  0
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
    -30 -20   0   0   0   0 -20 -30;
    -50 -30 -30 -30 -30 -30 -30 -50
];


    value = 0;
    biggestWinBlack = 0;
    biggestWinWhite = 0;
    
    isolatedPawnPunishment = [0 -10 -25 -25 -50 -75 -75 -75];
    
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

    queensOnBoard = size(wQueenRow, 1) + size(bQueenRow, 1);
    
    % For strength of bishop pair
    bishopPairStength = -1/4*(numOfPawns-16)*(numOfPawns+16);
    
    % For strength of small pieces (knight/bishop)
    m=-0.01648351648;
    smallPieceMultiplier = -m*piecesLeft + 12*m + 1;
    
    wCastledLeft = false;
    wCastledRight = false;
    bCastledLeft = false;
    bCastledRight = false;
    if piecesLeft > 10 || queensOnBoard >= 2
        % Has either side castled
        if board(10, 2) == 1
            wCastledLeft = true;
            value = value + 50;
        end
        
        if board(10, 3) == 1
            wCastledRight = true;
            value = value + 50;
        end
        
        if board(9, 1) == 1 && ~wCastledLeft && ~wCastledRight
            value = value - 50; %missed out on castling
        end
        
        if board(10, 4) == 1
            bCastledLeft = true;
            value = value - 50;
        end
        
        if board(10, 5) == 1
            bCastledRight = true;
            value = value - 50;
        end
        
        if board(9, 4) == 1 && ~bCastledRight && ~bCastledLeft
            value = value + 50; %missed out on castling
        end
    end
    
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
    % white king safety
    keyWhitePawn = false;
    isolatedPawnCount =  size(pawnRow, 1);
    for i = 1:size(pawnRow, 1)
        northRow = pawnRow(i)-1;
        westCol = pawnCol(i)-1;
        eastCol = pawnCol(i)+1;
        
        value = value + piecesLeft/14 * pawn_table(pawnRow(i), pawnCol(i)) + (14-piecesLeft)/14 * pawn_table_endgame(pawnRow(i), pawnCol(i));
        
        % Reduce points for doubled up pawns
        if northRow < 9
            if board(northRow, pawnCol(i)) == 11
                value = value - 25;
            end
        end
        
        % pawn structure
        if northRow < 9 && westCol > 0
            % looking at piece north west of white pawn
            if board(northRow,westCol) == 11
                value = value + 15;
            elseif board(northRow,westCol) == 12
                value = value + 5;
            elseif board(northRow,westCol) == 13
                value = value + 20;
            elseif board(northRow,westCol) == 14
                value = value + 5;
            elseif board(northRow,westCol) == 15
                value = value + 5;
            elseif board(northRow,westCol) == 22
                biggestWinWhite = max(biggestWinWhite, knightVal);
            elseif board(northRow,westCol) == 23
                biggestWinWhite = max(biggestWinWhite, bishopVal);
            elseif board(northRow,westCol) == 24
                biggestWinWhite = max(biggestWinWhite, rookVal);
            elseif board(northRow,westCol) == 25
                biggestWinWhite = max(biggestWinWhite, queenVal);
            end 
        end
        
        if northRow < 9 && eastCol < 9
            % looking at piece north east of white pawn
            if board(northRow,eastCol) == 11
                value = value + 15;
            elseif board(northRow,eastCol) == 12
                value = value + 5;
            elseif board(northRow,eastCol) == 13
                value = value + 20;
            elseif board(northRow,eastCol) == 14
                value = value + 5;
            elseif board(northRow,eastCol) == 15
                value = value + 5;
            elseif board(northRow,eastCol) == 22
                biggestWinWhite = max(biggestWinWhite, knightVal);
            elseif board(northRow,eastCol) == 23
                biggestWinWhite = max(biggestWinWhite, bishopVal);
            elseif board(northRow,eastCol) == 24
                biggestWinWhite = max(biggestWinWhite, rookVal);
            elseif board(northRow,eastCol) == 25
                biggestWinWhite = max(biggestWinWhite, queenVal);
            end   
        end
        
        % check if pawn is a passed pawn
        passedPawn = true;
        for j = 1:size(blackPawnRow, 1)
            if blackPawnCol(j) == pawnCol(i) || blackPawnCol(j)+1 == pawnCol(i) || blackPawnCol(j) -1 == pawnCol(i)
                passedPawn = false;
                break;
            end
        end
        
        % check if pawn is isolated
        for j = 1:size(pawnRow, 1)
            if pawnCol(j) == pawnCol(i)+1 || pawnCol(j) == pawnCol(i) - 1
                isolatedPawnCount = isolatedPawnCount - 1;
                break;
            end
        end
        
        if passedPawn == true
           value = value + 20 * (8-pawnRow(i));
           
           if piecesLeft < 5
               % can the king catch it?
               if board(10, 1) == 1
                   if ~(all(abs(bcol - pawnCol(i)) <= (pawnRow(i) - 1)) && all(brow <= pawnRow(i)))
                       value = value + 40 * (8-pawnRow(i));
                   end
               else
                   if ~(all(abs(bcol - pawnCol(i)) <= (pawnRow(i))) && all(brow+1 <= pawnRow(i)))
                       value = value + 40 * (8-pawnRow(i));
                   end
               end
           end
        end
        
        row_distance = wrow - pawnRow(i);
        col_distance = abs(pawnCol(i) - wcol);

        % Check if the pawn is next to or infront of king
        if all(row_distance <= 2) && all(row_distance >= 0) && all(col_distance <= 1)
            value = value + 10;
        end
        
        % Now we check if king is open
        if wCastledLeft
            if pawnCol(i) == 2
                keyWhitePawn = true;
            end
        elseif wCastledRight
            if pawnCol(i) == 7
                keyWhitePawn = true;
            end
        end

        if piecesLeft > 10 || queensOnBoard >= 2
            % calculating distance from enemy king
            dist_to_enemy_king = sqrt((pawnRow(i) - brow)^2 +(pawnCol(i) - bcol)^2);
            if dist_to_enemy_king <= 2
                value = value + 20;
            elseif dist_to_enemy_king <= 3
                value = value + 10;
            elseif dist_to_enemy_king <= 5
                value = value + 5;
            end
        end
    end
    
    value = value + isolatedPawnPunishment(isolatedPawnCount+1);

    if size(brookRow, 1) > 1 || (size(bQueenRow, 1) > 0 && size(brookRow, 1) > 0)
        % reduce position value if key defensive pawn is missing
        if (wCastledLeft || wCastledRight) && keyWhitePawn == false
            value = value - 80; % should multiply by threat level
        end      
    end


    %add values of all black pawn positioning
    keyBlackPawn = false;
    isolatedPawnCount = size(blackPawnRow, 1);
    for i = 1:size(blackPawnRow, 1)
        southRow = blackPawnRow(i)+1;
        westCol = blackPawnCol(i)-1;
        eastCol = blackPawnCol(i)+1;
        value = value - piecesLeft/14 * pawn_table(9-blackPawnRow(i), blackPawnCol(i)) - (14-piecesLeft)/14 * pawn_table_endgame(9-blackPawnRow(i), blackPawnCol(i));
        
        % Reduce points for doubled up pawns
        if southRow > 0
            if board(southRow, blackPawnCol(i)) == 21
                value = value + 25;
            end
        end
        
        % pawn structure 
        if southRow > 0 && westCol > 0
            % looking at piece south west of black pawn
            if board(southRow,westCol) == 21
                value = value - 15;
            elseif board(southRow,westCol) == 22
                value = value - 5;
            elseif board(southRow,westCol) == 23
                value = value - 20;
            elseif board(southRow,westCol) == 24
                value = value - 5;
            elseif board(southRow,westCol) == 25
                value = value - 5;
            elseif board(southRow,westCol) == 12
                biggestWinBlack = max(biggestWinBlack, knightVal);
            elseif board(southRow,westCol) == 13
                biggestWinBlack = max(biggestWinBlack, bishopVal);
            elseif board(southRow,westCol) == 14
                biggestWinBlack = max(biggestWinBlack, rookVal);
            elseif board(southRow,westCol) == 15
                biggestWinBlack = max(biggestWinBlack, queenVal);
            end  
        end
        
        if southRow > 0 && eastCol < 9
            % looking at piece north east of black pawn
            if board(southRow,eastCol) == 21
                value = value - 15;
            elseif board(southRow,eastCol) == 22
                value = value - 5;
            elseif board(southRow,eastCol) == 23
                value = value - 20;
            elseif board(southRow,eastCol) == 24
                value = value - 5;
            elseif board(southRow,eastCol) == 25
                value = value - 5;
            elseif board(southRow,eastCol) == 12
                biggestWinBlack = max(biggestWinBlack, knightVal);
            elseif board(southRow,eastCol) == 13
                biggestWinBlack = max(biggestWinBlack, bishopVal);
            elseif board(southRow,eastCol) == 14
                biggestWinBlack = max(biggestWinBlack, rookVal);
            elseif board(southRow,eastCol) == 15
                biggestWinBlack = max(biggestWinBlack, queenVal);
            end  
        end
        
        % check if pawn is a passed pawn
        passedPawn = true;
        for j = 1:size(pawnRow, 1)
            if blackPawnCol(i) == pawnCol(j) || blackPawnCol(i) == pawnCol(j) + 1 || blackPawnCol(i) == pawnCol(j) -1
                passedPawn = false;
                break;
            end
        end
        
        % check if pawn is isolated
        for j = 1:size(blackPawnRow, 1)
            if blackPawnCol(i) == blackPawnCol(j) + 1 || blackPawnCol(i) == blackPawnCol(j) -1
                isolatedPawnCount = isolatedPawnCount - 1;
                break;
            end
        end
        
        if passedPawn == true
            value = value - 20 * blackPawnRow(i);
            
            % can the king catch it?
            if piecesLeft < 5
                if board(10, 1) == 1
                    if ~(all(abs(wcol - blackPawnCol(i)) <= (9 - blackPawnRow(i))) && all(wrow >= blackPawnRow(i)-1))
                        value = value - 40 * pawnRow(i);
                    end
                else
                    if ~(all(abs(wcol - blackPawnCol(i)) <= (8 - blackPawnRow(i))) && all(wrow >= blackPawnRow(i)))
                        value = value - 40 * pawnRow(i);
                    end
                end
            end
        end
        
        
        row_distance = blackPawnRow(i) - brow;
        col_distance = abs(blackPawnCol(i) - bcol);

        % Check if the pawn is next to or infront of king
        if all(row_distance <= 2) && all(row_distance >= 0) && all(col_distance <= 1)
            value = value - 10;
        end
        
        % Now we check if king is open
        if bCastledLeft
            if blackPawnRow(i) == 2
                keyBlackPawn = true;
            end
        elseif bCastledRight
            if blackPawnRow(i) == 7
                keyBlackPawn = true;
            end
        end
        

        if piecesLeft > 10 || queensOnBoard >= 2
            % calculating distance from enemy king
            dist_to_enemy_king = sqrt((blackPawnCol(i) - wcol)^2 +(blackPawnRow(i) - wrow)^2);
            if dist_to_enemy_king <= 2
                value = value - 20;
            elseif dist_to_enemy_king <= 3
                value = value - 10;
            elseif dist_to_enemy_king <= 5
                value = value - 5;
            end
        end  
    end
    
    value = value - isolatedPawnPunishment(isolatedPawnCount+1);
    
    if size(rookRow, 1) > 1 || (size(wQueenRow, 1) > 0 && size(rookRow, 1) > 0)
        % reduce position value if key defensive pawn is missing
        if (bCastledLeft || bCastledRight) && keyBlackPawn == false
            value = value + 80; % should multiply by threat level
        end
    end
    
    if board(10, 1) == 1 && biggestWinWhite > biggestWinBlack
       value = value +  biggestWinWhite - biggestWinBlack;
    elseif board(10, 1) == 2 && biggestWinWhite < biggestWinBlack
        value = value -  biggestWinBlack + biggestWinWhite;
    end
    
    %add value if queens are in optimal postions
    for i = 1:size(wQueenRow, 1)
        row = wQueenRow(i);
        col = wQueenCol(i);
        value = value + queen_table(row, col);
        
        if piecesLeft > 10 || queensOnBoard >= 2
            % calculating distance from enemy king
            dist_to_enemy_king = sqrt((col - bcol)^2 +(row - brow)^2);
            if dist_to_enemy_king <= 2
                value = value + 50;
            elseif dist_to_enemy_king <= 3
                value = value + 30;
            elseif dist_to_enemy_king <= 5
                value = value + 10;
            end
        end
    end

    %add value if queens are in optimal postions
    for i = 1:size(bQueenRow, 1)
        row = bQueenRow(i);
        col = bQueenCol(i);
        value = value - queen_table(9-row, col);
        
        if piecesLeft > 10 || queensOnBoard >= 2
            % calculating distance from enemy king
            dist_to_enemy_king = sqrt((col - wcol)^2 +(row - wrow)^2);
            if dist_to_enemy_king <= 2
                value = value - 50;
            elseif dist_to_enemy_king <= 3
                value = value - 30;
            elseif dist_to_enemy_king <= 5
                value = value - 10;
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
               if piecesLeft > 10 || queensOnBoard >= 2
                   % calculating distance from enemy king
                   dist_to_enemy_king = sqrt((col - bcol)^2 +(row-j - brow)^2);
                   if dist_to_enemy_king <= 2
                       value = value + 40;
                   elseif dist_to_enemy_king <= 4
                       value = value + 20;
                   end
               end
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
              value = value + 3; 
           elseif board(row, col+j) == 14 || board(row, col+j) == 16
              value = value + 35;
           else
               break;
           end
        end

        %rook west spots
        for j = 1:(col-1)
           if board(row, col-j) == 0
              value = value + 3; 
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
               if piecesLeft > 10 || queensOnBoard >= 2
                   % calculating distance from enemy king
                   dist_to_enemy_king = sqrt((col - wcol)^2 +(row+j - wrow)^2);
                   if dist_to_enemy_king <= 2
                       value = value - 40;
                   elseif dist_to_enemy_king <= 4
                       value = value - 20;
                   end
               end
               break;
           end
        end

        %rook east spots
        for j = 1:(8-col)
           if board(row, col+j) == 0
              value = value - 3; 
           elseif board(row, col+j) == 24 || board(row, col+j) == 26
              value = value - 35;
           else
               break;
           end
        end

        %rook west spots
        for j = 1:(col-1)
           if board(row, col-j) == 0
              value = value - 3; 
           elseif board(row, col-j) == 24 || board(row, col-j) == 26
              value = value - 35;
           else
               break;
           end
        end
    end
     
    %add value if knight if central
    for i = 1:size(knightRow, 1)
        value = value + knight_table(knightRow(i), knightCol(i)); 
        if piecesLeft > 10 || queensOnBoard >= 2
            % calculating distance from enemy king
            dist_to_enemy_king = sqrt((knightCol(i) - bcol)^2 +(knightRow(i) - brow)^2);
            if dist_to_enemy_king <= 4
                value = value + 20;
            elseif dist_to_enemy_king <= 5
                value = value + 10;
            elseif dist_to_enemy_king <= 6
                value = value + 5;
            end
        end
    end

    %add value if knight if central
    for i = 1:size(blackKnightRow, 1)
        value = value - knight_table(9-blackKnightRow(i), blackKnightCol(i)); 
        if piecesLeft > 10 || queensOnBoard >= 2
            % calculating distance from enemy king
            dist_to_enemy_king = sqrt((blackKnightCol(i) - wcol)^2 +(blackKnightRow(i) - wrow)^2);
            if dist_to_enemy_king <= 4
                value = value - 20;
            elseif dist_to_enemy_king <= 5
                value = value - 10;
            elseif dist_to_enemy_king <= 6
                value = value - 5;
            end
        end
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
                    if piecesLeft > 10 || queensOnBoard >= 2
                        % calculating distance from enemy king
                        dist_to_enemy_king = sqrt((col-j - bcol)^2 +(row+j - brow)^2);
                        if dist_to_enemy_king <= 2
                            value = value + 20;
                        elseif dist_to_enemy_king <= 3
                            value = value + 10;
                        elseif dist_to_enemy_king <= 4
                            value = value + 5;
                        end
                    end
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
                    if piecesLeft > 10 || queensOnBoard >= 2
                        % calculating distance from enemy king
                        dist_to_enemy_king = sqrt((col-j - bcol)^2 +(row-j - brow)^2);
                        if dist_to_enemy_king <= 2
                            value = value + 20;
                        elseif dist_to_enemy_king <= 3
                            value = value + 10;
                        elseif dist_to_enemy_king <= 4
                            value = value + 5;
                        end
                    end
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
                    if piecesLeft > 10 || queensOnBoard >= 2
                        % calculating distance from enemy king
                        dist_to_enemy_king = sqrt((col+j - wcol)^2 +(row+j - wrow)^2);
                        if dist_to_enemy_king <= 2
                            value = value - 20;
                        elseif dist_to_enemy_king <= 3
                            value = value - 10;
                        elseif dist_to_enemy_king <= 4
                            value = value - 5;
                        end
                    end
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
                    if piecesLeft > 10 || queensOnBoard >= 2
                        % calculating distance from enemy king
                        dist_to_enemy_king = sqrt((col-j - wcol)^2 +(row+j - wrow)^2);
                        if dist_to_enemy_king <= 2
                            value = value - 20;
                        elseif dist_to_enemy_king <= 3
                            value = value - 10;
                        elseif dist_to_enemy_king <= 4
                            value = value - 5;
                        end
                    end
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


    % white king position value
    value = value + piecesLeft/16 * king_table_midgame(wrow, wcol) + (16-piecesLeft)/16*king_table_endgame(wrow, wcol);

    % black king position value
    value = value - piecesLeft/16 * king_table_midgame(9-brow, bcol) - (16-piecesLeft)/16*king_table_endgame(9-brow, bcol);
    
   % Check if it's an endgame scenario
    if piecesLeft <= 5 || queensOnBoard == 0      
        if value > 400
            distBetweenKings = sqrt((wrow - brow)^2 + (wcol - bcol)^2);
            value = value + 140 - 20*distBetweenKings;
        elseif value < -400
            distBetweenKings = sqrt((wrow - brow)^2 + (wcol - bcol)^2);
            value = value - 140 + 20*distBetweenKings;
        end
    end

    % incentivise trading with an advantage
    value = value + value*5/(piecesLeft+numOfPawns+2);

    
    if colour == 2
        value = -value;
    end


end
