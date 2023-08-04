function board = initialiseBoard3()
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
board(2,1) = 21;
board(2,3) = 21;
board(2,4) = 21;
board(2,6) = 21;
board(5,2) = 21;
board(6,8) = 21;
board(3,5) = 21;
board(3,7) = 21;

board(7,1) = 11;
board(7,2) = 11;
board(7,3) = 11;
board(7,6) = 11;
board(7,7) = 11;
board(7,8) = 11;
board(4,4) = 11;
board(5,5) = 11;

    
% Initialising rooks
board(1,1) = 24;
board(1,8) = 24;
board(8,1) = 14;
board(8,8) = 14;

% Initialising bishops
board(2,7) = 23;
board(3,1) = 23;
board(7,4) = 13;
board(7,5) = 13;

% Initialising knights
board(3,2) = 22;
board(3,6) = 22;
board(6,3) = 12;
board(4,5) = 12;

% Initialising Queens
board(2,5) = 25;
board(6,6) = 15;

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

board(10,1) = 1;

end