function value = searchAllCaptures2(board, colour, positionValue, alpha, beta)
value = positionValue2_mex(board, colour);

% Update alpha and the best move if necessary
if (value >= beta)
    value = beta;
    return
end

if value > alpha
    alpha = value;
end

% Get all legal moves for the current player
legalMoves = getLegalMoves3_mex(board);

% stalemate and checkmate
if isempty(legalMoves)
    if (amIChecked(board, colour) == true)
        value = -inf;
        return
    else
        value = 0;
        return
    end
end

legalMoves = onlyCaptureMoves(legalMoves, board, colour);


for i = 1:size(legalMoves, 2)
    % Make the move and get the value for the resulting board
    newBoard = makeMove(legalMoves(1,i), legalMoves(2, i), legalMoves(3,i), board);
    other_colour = otherColour(colour);
    
    childValue = searchAllCaptures2(newBoard, other_colour, positionValue, -beta, -alpha);
    
    %good move for child is bad move for us
    childValue = -childValue;
    
    
    % Update alpha and the best move if necessary
    if childValue >= beta
        value = beta;
        return
    end
    
    if childValue > alpha
        alpha = childValue;
    end
end

value = alpha;
end