function runBookMoves()
rng(5259408);
bookmovess = bookMoves();
zKeys = uint64(randperm(2^52, 800));
bookTable = createHashTable();
board = initialiseBoard();
colour = 1;
size(bookmovess, 1)
for i = 1:(size(bookmovess, 1))
    bored = board;
    moves = bookmovess(i, :);
    for j = 1:(size(moves, 2)-1)
        legalMoves = getLegalMoves3_mex(bored);
        for k = 1:size(legalMoves, 2)
            digestableLegalMove = convertToChess2(legalMoves(:, k), board, colour);
            if moves(j) == digestableLegalMove
                bored = makeMove(legalMoves(1, k), legalMoves(2, k), legalMoves(3, k), bored);
                % Get the Zobrist key for the current board position
                zobristKey = calculateZobristKeys2_mex(bored, zKeys);
                colour = otherColour(colour);
                nextMoves = getLegalMoves3_mex(bored);
                for l = 1:size(nextMoves, 2)
                    digestableLegalMove = convertToChess2(nextMoves(:, l), bored, colour);
                    if moves(j+1) == digestableLegalMove
                        nextMove = nextMoves(:, l);
                        addToHashTable(bookTable, zobristKey, 99, nextMove, 0, colour, "exact");
                        break;
                    end
                end
                break;
            end
        end
    end
    
end

% Save the bookTable to a .mat file
save('bookTable.mat', 'bookTable');
end