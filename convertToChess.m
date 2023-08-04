function move = convertToChess(move)
    % Find the location of the piece
    
    row = mod(move(2), 10);
    col = floor(move(2)/10);
    
    postCol = floor(move(1)/10);
    Piece = move(3);
    extra = "";
    if move(4) == 2
        extra = "x";
    end
    
    colLetter = "z";
    if (row == 1)
        colLetter = "a";
    elseif row == 2
        colLetter = "b";
    elseif row == 3
        colLetter = "c";
    elseif row == 4
        colLetter = "d";
    elseif row == 5
        colLetter = "e";
    elseif row == 6
        colLetter = "f";
    elseif row == 7
        colLetter = "g";
    elseif row == 8
        colLetter = "h";
    end
    
    rowLetter = num2str(9 - col);


    pieceLetter = "";
    if Piece == 11 || Piece == 21
        pieceLetter = "";
    elseif Piece == 12 || Piece == 22
        pieceLetter = "N";
    elseif Piece == 13 || Piece == 23
        pieceLetter = "B";
    elseif Piece == 14 || Piece == 24
        pieceLetter = "R";
    elseif Piece == 15 || Piece == 25
        pieceLetter = "Q";
    elseif Piece == 16 || Piece == 26
        if col == 5 && postCol == 3
            move = "O-O-O";
            return;
        elseif col == 5 && postCol == 7
            move = "O-O";
            return;
        else
            pieceLetter = "K";
        end
    end
    
    move = strcat(pieceLetter, extra, colLetter, rowLetter);
end