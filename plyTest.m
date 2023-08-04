function [moves, captures] = plyTest(board, depth)
    moves = 0;
    captures = 0;
    % Check if maximum depth has been reached or the game is over
    if depth == 0
        moves = 1;
        captures = 0;
        return;
    end
    
    % Get all legal moves for the current player
    legalMoves = getLegalMoves2(board);

    for i = 1:size(legalMoves, 2)
        if legalMoves(5,i) == 2
            captures = captures + 1;
        end
        % Make the move and get the value for the resulting board
        newBoard = makeMove(legalMoves(1,i), legalMoves(2, i), legalMoves(3,i), board);      
        [extraMoves, extraCaptures] = plyTest(newBoard, depth-1);
        moves = moves + extraMoves;
        captures = captures + extraCaptures;
    end

    
end