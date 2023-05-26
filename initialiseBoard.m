function board = initialiseBoard()
board = zeros(8,8);
% 11 = white pawn
% 12 = white knight
% 13 = white bishop
% 14 = white rook 
% 15 = white queen
% 16 = white king

% 21 = black pawn
% 22 = black knight
% 23 = black bishop
% 24 = black rook 
% 25 = black queen
% 26 = black king

% Initialising pawns
for i=1:8
    board(2,i) = 21;
    board(7,i) = 11;
end
% Initialising rooks
board(1,1) = 24;
board(1,8) = 24;
board(8,1) = 14;
board(8,8) = 14;

% Initialising bishops
board(1,3) = 23;
board(1,6) = 23;
board(8,3) = 13;
board(8,6) = 13;

% Initialising knights
board(1,2) = 22;
board(1,7) = 22;
board(8,2) = 12;
board(8,7) = 12;

% Initialising Queens
board(1,4) = 25;
board(8,4) = 15;

% Initialising Kings
board(1,5) = 26;
board(8,5) = 16;


% 9, 1 is whether white king has moved (0 = no, 1 = yes)
board(9,1) = 0;
% 9, 2 is whether white left rook has moved (0 = no, 1 = yes)
board(9,2) = 0;
% 9, 3 is whether white right rook has moved (0 = no, 1 = yes)
board(9,3) = 0;
% 9, 4 is whether black king has moved (0 = no, 1 = yes)
board(9,4) = 0;
% 9, 5 is whether black left rook has moved (0 = no, 1 = yes)
board(9,5) = 0;
% 9, 6 is whether black right rook has moved (0 = no, 1 = yes)
board(9,6) = 0;

% 9, 7 is the column of which white moved a pawn twice (meaning black can
% en passant that square)

% 9, 8 is the column of which black moved a pawn twice (meaning white can
% en passant that square)


end