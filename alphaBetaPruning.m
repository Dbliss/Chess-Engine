function [bestMove, bestValue, moveSequence, booked] = alphaBetaPruning(board, colour, positionValue, depth, alpha, beta, moveSequence, prevBest, hashTable, zKeys, book)
    booked = false;
    % Check if maximum depth has been reached or the game is over
    if depth == 0
        bestValue = searchAllCaptures(board, colour, positionValue, alpha, beta);
        bestMove = [];
        return;
    end
    % Get the Zobrist key for the current board position
    zobristKey = calculateZobristKey(board, zKeys);
    
    % Retrieve the stored information for the position
    storedData = retrieveFromHashTable(hashTable, zobristKey);

    if book == 1
        load('bookTable.mat');
        bookDatas = retrieveFromHashTable(bookTable, zobristKey);

        if ~isempty(bookDatas)
            bestValue = bookDatas.value;
            bestMove = bookDatas.move;
            booked = true;
            return;
        else
            book = 0;
        end
    end
    
     % Check if the current position is in the hash table
    if ~isempty(storedData)  
        % stalemate condition
        if storedData.flag == "played" && colour == storedData.colour
            bestValue = 0;
            bestMove = storedData.move;
            return;
        end
        
        if storedData.depth == 99
            bestValue = storedData.value;
            bestMove = storedData.move;
            booked = true;
            return;
        end
               
        % Check if the stored depth is at least the current depth
        if storedData.depth >= depth && storedData.colour == colour
            % Use the stored value as an exact value or window for alpha-beta cutoff
            if storedData.flag == "exact"
                bestValue = storedData.value;
                bestMove = storedData.move;
                return;
            elseif storedData.flag == "lowerbound"
                alpha = max(alpha, storedData.value);
            elseif storedData.flag == "upperbound"
                beta = min(beta, storedData.value);
            end
            
            % Check if the stored bounds result in an alpha-beta cutoff
            if alpha >= beta
                bestValue = alpha;
                bestMove = storedData.move;
                return;
            end
        elseif storedData.colour == colour && isempty(prevBest)
            prevBest = storedData.move;
        end
            
    end
    
    % Get all legal moves for the current player
    legalMoves = getLegalMoves_mex(board, colour);
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
    legalMoves = makeGoodMovesFirst(legalMoves , prevBest, board, colour);

    % Set the default best move and value to the first legal move
    bestMove = legalMoves(:,1);
    for i = 1:size(legalMoves, 2)
        % Make the move and get the value for the resulting board
        newBoard = makeMove(legalMoves(1,i), legalMoves(2, i), legalMoves(3,i), board);
        other_colour = otherColour(colour);
        firstMove = legalMoves(:,i);
        newMoveSequence = [moveSequence, firstMove];        
        
        inp = [];
        [~, childValue, ~, ~] = alphaBetaPruning(newBoard, other_colour, positionValue, depth-1, -beta, -alpha, newMoveSequence, inp, hashTable, zKeys, book);
        
        %good move for child is bad move for us
        childValue = -childValue;
        
        % Update alpha and the best move if necessary
        if childValue >= beta
            bestValue = beta;
            %bestMove = [];
             % Store the cutoff information in the hash table
            addToHashTable(hashTable, zobristKey, depth, legalMoves(:,i), childValue, colour, "lowerbound");
            return
        end

        if childValue > alpha
            alpha = childValue;
            bestMove = legalMoves(:,i);
        end
    end
    
    bestValue = alpha;
    
    % Store the result in the hash table
    addToHashTable(hashTable, zobristKey, depth, bestMove, bestValue, colour, "exact");
end