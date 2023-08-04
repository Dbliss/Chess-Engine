function tes()
% Example usage with the initial board state
board1 = initialiseBoard();
board2 = initialiseBoard2();
board3 = initialiseBoard3();
board4 = initialiseBoard4();
board5 = initialiseBoard5();
board6 = initialiseBoard6();
board7 = initialiseBoard7();
board8 = initialiseBoard8();
board9 = initialiseBoard9();
board10 = initialiseBoard10();
boards1 = initialiseBoards();
boards2 = {board1, board2, board3, board4, board5, board6, board7, board8, board9, board10};
boards = [boards2, boards1];


rng(5259408);
zKeys = uint64(randperm(2^52, 800));
bookTables = load('bookTable.mat');
for j = 1:500
    for i = 1:54
        board = boards{i};
        % Get the Zobrist key for the current board position
        zobristKey = calculateZobristKeys2_mex(board, zKeys);
        
        % Retrieve the stored information for the position
        storedData = retrieveFromHashTable(bookTables.bookTable, zobristKey);
        
        
    end
end
end