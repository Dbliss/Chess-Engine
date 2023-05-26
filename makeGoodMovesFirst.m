function moves = makeGoodMovesFirst(legalMoves, prevBest, board, colour)


% need to estimate how good each move is

% If a piece moves under attack of pawn, its probably bad
if colour == 1
    for i = 1:size(legalMoves, 2)
        postPosY = mod(legalMoves(2,i), 10);
        postPosX = floor(legalMoves(2,i)/10); 
        piece = legalMoves(3,i);
        bored = makeMove(legalMoves(1, i), legalMoves(2, i), legalMoves(3, i), board);
        if fastamIChecked_mex(bored, 2) == 1
            legalMoves(4, i) = legalMoves(4, i)+4;
        end
        
        
        
        if postPosY-1 > 0 && postPosX+1 < 9
            if board(postPosY-1, postPosX+1) == 21
                if piece == 15
                    legalMoves(4, i) = legalMoves(4, i)-4;
                elseif piece == 14
                    legalMoves(4, i) = legalMoves(4, i)-3;
                elseif piece == 13
                    legalMoves(4, i) = legalMoves(4, i)-2;
                elseif piece == 12
                    legalMoves(4, i) = legalMoves(4, i)-1;
                end
            end
        end
        
        if postPosY-1 > 0 && postPosX-1 > 0
            if board(postPosY-1, postPosX-1) == 21
                if piece == 15
                    legalMoves(4, i) = legalMoves(4, i)-5;
                elseif piece == 14
                    legalMoves(4, i) = legalMoves(4, i)-4;
                elseif piece == 13
                    legalMoves(4, i) = legalMoves(4, i)-3;
                elseif piece == 12
                    legalMoves(4, i) = legalMoves(4, i)-2;
                end
            end
        end
    end
end

% 
% %same idea for black pieces under attack
if colour == 2
    for i = 1:size(legalMoves, 2)
        postPosY = mod(legalMoves(2,i), 10);
        postPosX = floor(legalMoves(2,i)/10); 
        piece = legalMoves(3,i);

        if postPosY+1 < 9 && postPosX+1 < 9
            if board(postPosY+1, postPosX+1) == 11
                if piece == 25
                    legalMoves(4, i) = legalMoves(4, i)-4;
                elseif piece == 24
                    legalMoves(4, i) = legalMoves(4, i)-3;
                elseif piece == 23
                    legalMoves(4, i) = legalMoves(4, i)-2;
                elseif piece == 22
                    legalMoves(4, i) = legalMoves(4, i)-1;
                end
            end
        end
        
        if postPosY+1 < 9 && postPosX-1 > 0
            if board(postPosY+1, postPosX-1) == 11
                if piece == 25
                    legalMoves(4, i) = legalMoves(4, i)-4;
                elseif piece == 24
                    legalMoves(4, i) = legalMoves(4, i)-3;
                elseif piece == 23
                    legalMoves(4, i) = legalMoves(4, i)-2;
                elseif piece == 22
                    legalMoves(4, i) = legalMoves(4, i)-1;
                end
            end
        end
    end
end
%        
    

moves = legalMoves;



% Get the third row
third_row = moves(4, :);

% Sort the third row in descending order and get the indices
[~, sorted_indices] = sort(third_row, 'descend');

% Reorder the columns of the vector based on the sorted indices
sorted_vector = moves(:, sorted_indices);

moves = sorted_vector;

if ~isempty(prevBest)
    % Find the index of the previous best move in the legalMoves array
    for i = 1:size(legalMoves, 2)
       if legalMoves(:, i) == prevBest
           moves = [prevBest, moves(:, 1:i-1), moves(:, i+1:end)];
       end   
    end
end

end