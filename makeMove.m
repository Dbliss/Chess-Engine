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