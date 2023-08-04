function move = convertToChess2(move, board, colour)
    % Find the location of the piece
    row = mod(move(2), 10);
    col = floor(move(2)/10);
    
    priorCol = mod(move(1), 10);
    Piece = move(3);
    extra2 = "";
    legalMoves = getLegalMoves3_mex(board);
    for i = 1:size(legalMoves, 2)
        postPosition = legalMoves(2, i);
        pieceMoved = legalMoves(3, i);
        
        if move == legalMoves(:, i)
            for j = 1:size(legalMoves, 2)
                otherPostPosition = legalMoves(2, j);
                otherPieceMoved = legalMoves(3, j);
                if (i~=j) && (postPosition == otherPostPosition) && (pieceMoved == otherPieceMoved)
                    priorRow1 = floor(legalMoves(1, i)/10);
                    priorCol1 = mod(legalMoves(1, i), 10);
                    priorRow2 = floor(legalMoves(1, j)/10);
                    priorCol2 = mod(legalMoves(1, j), 10);

                    if priorCol1 == priorCol2
                        extra2 = num2str(9 - priorRow1);
                    else
                        if move(2) == otherPostPosition && move(3) == otherPieceMoved
                            if (priorCol1 == 1)
                                extra2 = "a";
                            elseif priorCol1 == 2
                                extra2 = "b";
                            elseif priorCol1 == 3
                                extra2 = "c";
                            elseif priorCol1 == 4
                                extra2 = "d";
                            elseif priorCol1 == 5
                                extra2 = "e";
                            elseif priorCol1 == 6
                                extra2 = "f";
                            elseif priorCol1 == 7
                                extra2 = "g";
                            elseif priorCol1 == 8
                                extra2 = "h";
                            end 
                        end
                    end
                end
            end
        end
    end
    
    extra = "";
    if move(5) == 2
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
        if move(5) == 2
            if (priorCol == 1)
                pieceLetter = "a";
            elseif priorCol == 2
                pieceLetter = "b";
            elseif priorCol == 3
                pieceLetter = "c";
            elseif priorCol == 4
                pieceLetter = "d";
            elseif priorCol == 5
                pieceLetter = "e";
            elseif priorCol == 6
                pieceLetter = "f";
            elseif priorCol == 7
                pieceLetter = "g";
            elseif priorCol == 8
                pieceLetter = "h";
            end
        else
            pieceLetter = "";
        end
    elseif Piece == 12 || Piece == 22
        pieceLetter = "N";
    elseif Piece == 13 || Piece == 23
        pieceLetter = "B";
    elseif Piece == 14 || Piece == 24
        pieceLetter = "R";
    elseif Piece == 15 || Piece == 25
        pieceLetter = "Q";
    elseif Piece == 16 || Piece == 26
        if row == 3 && priorCol == 5
            move = "O-O-O";
            return;
        elseif row == 7 && priorCol == 5
            move = "O-O";
            return;
        else
            pieceLetter = "K";
        end
    end
    
    move = strcat(pieceLetter, extra2, extra, colLetter, rowLetter);
end