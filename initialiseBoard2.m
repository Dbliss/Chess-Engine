function board = initialiseBoard2()
board = zeros(10,8);
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
board(4,2) = 11;
board(7,5) = 11;
board(7,7) = 11;
board(2,3) = 21;
board(3,4) = 21;
board(5,6) = 21;
    
% Initialising rooks
board(4,8) = 24;
board(5,2) = 14;


% Initialising Kings
board(5,8) = 26;
board(4,1) = 16;


% 9, 1 is whether white king has moved (0 = no, 1 = yes)
board(9,1) = 1;
% 9, 2 is whether white left rook has moved (0 = no, 1 = yes)
board(9,2) = 1;
% 9, 3 is whether white right rook has moved (0 = no, 1 = yes)
board(9,3) = 1;
% 9, 4 is whether black king has moved (0 = no, 1 = yes)
board(9,4) = 1;
% 9, 5 is whether black left rook has moved (0 = no, 1 = yes)
board(9,5) = 1;
% 9, 6 is whether black right rook has moved (0 = no, 1 = yes)
board(9,6) = 1;

board(10,1) = 1;

end