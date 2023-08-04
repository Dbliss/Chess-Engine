function movesReordered = onlyCaptureMoves(legalMoves, board, colour)
    % Get the third row
    fifth_row = legalMoves(5, :);
    
    % Find the indices where the third row is greater than 10 (a capture
    % move)
    good_indices = (fifth_row == 2);
    
    % Keep only the columns with the good indices
    moves = legalMoves(:, good_indices);
    
    if size(moves,2) <= 54
        movesReordered = makeGoodMovesFirst3_mex(moves, board);
    else
        movesReordered = makeGoodMovesFirst2(moves, [], board, colour);
    end
end