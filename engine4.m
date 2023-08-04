function [bestMove, bestValue, moveSequence, booked] = engine4(board, colour, positionValue, depth, alpha, beta, moveSequence, prevBest, hashTable, zKeys,  ~, ~, recursiveCap)
    booked = false;
    % Check if maximum depth has been reached or the game is over
    if depth == 0
        bestValue = searchAllCaptures2(board, colour, positionValue, alpha, beta);
        bestMove = [];
        return;
    end
    
    % Get all legal moves for the current player
    legalMoves = getLegalMoves3_mex(board);
    % stalemate and checkmate
    if isempty(legalMoves)
        if (amIChecked(board, colour) == true)
           bestValue = -inf;
           bestMove = [];
           return
        else
            bestValue = 0;
            bestMove = [];
            return
        end
    end
    legalMoves = makeGoodMovesFirst2(legalMoves , prevBest, board, colour);

    % Set the default best move and value to the first legal move
    bestMove = legalMoves(:,1);
    
    for i = 1:size(legalMoves, 2)
        % Make the move and get the value for the resulting board
        newBoard = makeMove(legalMoves(1,i), legalMoves(2, i), legalMoves(3,i), board);
        other_colour = otherColour(colour);
        firstMove = legalMoves(:,i);
        newMoveSequence = [moveSequence, firstMove];     
        
        % Lets do a reduced search depth for the worse looking moves
        if legalMoves(4, i) < 0 && depth >= 2
            if (legalMoves(5, i) == 3 && recursiveCap < 4)
                [~, childValue, ~, ~] = engine4(newBoard, other_colour, positionValue, depth - 1, -beta, -alpha, newMoveSequence, [], hashTable, zKeys,   [], [], recursiveCap + 1);
            else
                [~, childValue, ~, ~] = engine4(newBoard, other_colour, positionValue, depth - 2, -beta, -alpha, newMoveSequence, [], hashTable, zKeys,  [], [], recursiveCap);
            end
        else
            if (legalMoves(5, i) == 3 && recursiveCap < 4)
                [~, childValue, ~, ~] = engine4(newBoard, other_colour, positionValue, depth, -beta, -alpha, newMoveSequence, [], hashTable, zKeys,  [], [], recursiveCap + 1);
            else
                [~, childValue, ~, ~] = engine4(newBoard, other_colour, positionValue, depth-1, -beta, -alpha, newMoveSequence, [], hashTable, zKeys,  [], [], recursiveCap);
            end
        end
        
        %good move for child is bad move for us
        childValue = -childValue;
        
        % stalemate condition
        % Get the Zobrist key for the current board position
        zobristKeyz = calculateZobristKeys2_mex(newBoard, zKeys);
    
        % Retrieve the stored information for the position
        storedDatas = retrieveFromHashTable(hashTable, zobristKeyz);
        if ~isempty(storedDatas)
            if storedDatas.flag == "played" && storedDatas.depth >= 1
                childValue = 0;
            end
        end
        
        % Update alpha and the best move if necessary
        if childValue >= beta
            bestValue = beta;
            bestMove = legalMoves(:,i);
            return
        end

        if childValue > alpha
            alpha = childValue;
            bestMove = legalMoves(:,i);

        end
    end
    
    bestValue = alpha;
end