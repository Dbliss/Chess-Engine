function boards = initialiseBoards()
    boards = cell(1, 46);

    % Initialising the board according to the FEN strings
    boardData = { ...
        'r1b1kbnr/ppppqppp/2n5/4p3/2B1P3/5N2/PPP2PPP/RNBQK2R', ...
        'rnbq1rk1/pp3ppp/2pbpn2/3p4/2PP4/2N1PN2/PP3PPP/R1BQKB1R', ...
        '2r3k1/pb1q2pp/1pn1r3/3p1p2/3P4/2P1P1P1/P1Q1BPKP/4R3', ...
        'r3r1k1/pp3ppp/3q1n2/1Nbp4/3n4/8/PPP2PPP/R1BQR1K1', ...
        'r2q1rk1/ppp2ppp/2npbn2/3Np3/3PP3/3B4/PPP2PPP/R1BQ1RK1', ...
        'r3r1k1/1pp1bppp/p1p5/3n4/3P4/1P4P1/PB2PPBP/R3R1K1', ...
        'r1b2rk1/1p1n1ppp/p1p1pn2/3p4/2PP4/2NBP3/PP1N1PPP/R1BQ1RK1', ...
        '8/5pk1/8/8/3K4/8/8/8', ...
        '4r3/p3k1p1/2R1p1Q1/1p3q2/1P2p3/6PP/P1B3PK/8', ...
        '8/1p6/p1p3k1/P1P2p1p/2B2P1P/2K5/8/8', ...
        '8/3n2k1/1p1P1p1p/pP1PpP1P/P2nP3/2K5/8/8', ...
        '2k2r2/ppp2ppp/2p5/8/2P2b2/2P3P1/P3PPBP/R1B1K3', ...
        '3r1rk1/p4ppp/1ppb1q2/4p3/2PnP3/1P3P2/PBB2QPP/R4RK1', ...
        '8/1p3p2/1pP2p3/2PpP1kp/3P1b2/2B1K1P1/8/8', ...
        'rnb1kb1r/pp3ppp/4pn2/q1pp4/3P4/2NB1N2/PP3PPP/R1BQK2R', ...
        '4k3/pp3pp1/4p2p/3pP2P/2pP4/2P1p2P/PPK5/8', ...
        '5rk1/1p1r1pp1/3ppq1p/2p5/2P1P3/2NP4/PP1Q1PPP/R4RK1', ...
        'r1bq1rk1/pp2bppp/2np1n2/2p1p3/4P3/2NPBN2/PPP1BPPP/R2QK2R', ...
        'r4rk1/pp3pp1/2p1pn1p/5q2/2P5/2B1P3/PPQ1NPPP/R1B2RK1', ...
        'r4rk1/pbpqbppp/1p2pn2/3pN3/3P4/1QPB4/PP3PPP/R1B2RK1', ...
        'r3r1k1/1pp2ppp/p3p3/3q4/3P4/4PQ2/PPP3PP/R1B2RK1', ...
        'r1bqk2r/3n1ppp/p2Ppn2/1p6/8/5N2/PPP1QPPP/R1B1K2R', ...
        'r1bqk2r/ppp2ppp/2n1p3/2b1P3/8/2p5/PPP1QPPP/RNB1K1NR', ...
        '8/2p2p2/1pP1kP2/pP2p3/P1P1P3/4K3/8/8', ...
        'r4rk1/ppp2ppp/3p1n2/4n3/2BP4/2N1P3/PPP2PPP/R1B2RK1', ...
        'r4rk1/pbpqbppp/1p2pn2/q2Pp3/4P3/2N1B3/PPPQ1PPP/R3K1NR', ...
        'r3r1k1/1bq2ppp/pp1ppn2/2pP2B1/2P1P3/1P1Q1N2/PB3PPP/R4RK1', ...
        '2r1k1nr/pp2ppbp/2n3p1/q2P4/4P1b1/2N2Q2/PPP1B1PP/R1B1K2R', ...
        '2r3k1/5ppp/p2N4/3P4/3n1P2/8/PP3nPP/R1B2K2', ...
        'r1b2rk1/ppp2ppp/1bn1p3/4N3/2B5/4P3/PPP2PPP/R1B1K2R', ...
        'r1b1k2r/pp1n1ppp/4pn2/8/3p4/2N2N2/PPP2PPP/R1B1K2R', ...
        '1r3rk1/3Q2pp/p3pp2/q1p5/3P4/2P3P1/1P3P1P/R1B1R1K1', ...
        'rnbqk2r/ppp2ppp/4pn2/8/2B5/4P3/PPP2PPP/R1BQK1NR', ...
        'r1b2rk1/ppp2ppp/2n1p3/2bpP3/4n3/2N2N2/PPP1BPPP/R1BQ1RK1', ...
        '8/2p2p2/1pP1kP2/pP2p3/3P1b2/2B1K1P1/8/8', ...
        'r1bqkb1r/pppp1ppp/4pn2/8/2B5/4P3/PPP2PPP/R1BQK1NR', ...
        'r1b1q1k1/pppp1ppp/2n5/4p3/2B1P3/2N5/PPP2PPP/R1BQK2R', ...
        'r3k2r/pp1bppbp/2p1pn2/q3N3/2P1P3/2N5/PPB2PPP/R2Q1RK1', ...
        '8/1p1k4/1pP1p1pp/pP3p2/3P1P2/2K2P2/1P6/8', ...
        '3r2k1/1pp2pp1/p2pp2p/2q5/3PP3/3BQ2P/PP3PP1/2R1R1K1', ...
        'r3k2r/pp1bppbp/2p1pn2/q7/2P1P3/2N5/PPQ2PPP/R1B1K1NR', ...
        'r1b1kb1r/pp2pppp/1qn2n2/2pp4/8/1P1P1N2/PBPP1PPP/RNBQ1RK1', ...
        'r2qkb1r/pppn1ppp/3p4/3P4/3Pn3/2N5/PPP2PPP/R1BQK1NR', ...
        'r1bq1rk1/pppp1ppp/2n1pn2/8/2B5/4PN2/PPPP1PPP/RNBQ1RK1', ...
        '4k3/ppp2pp1/3pp3/3b1n1p/3Pn3/3BP3/PPP1NPPP/3RK2R', ...
        'r1b1k2r/ppp1nppp/2n5/4p3/2B1P3/2N1B3/PPP2PPP/R3K1NR'};
    
    for i = 1:46
        FEN = boardData{i};
        board = zeros(10, 8);
        rows = strsplit(FEN, '/');
        
        for row = 1:8 % Ensure we have at most 8 rows
            col = 1;
            for j = 1:length(rows{row})
                char = rows{row}(j);
                if isstrprop(char, 'digit')
                    col = col + str2double(char);
                else
                    switch char
                        case 'r'
                            board(row, col) = 24;
                        case 'n'
                            board(row, col) = 22;
                        case 'b'
                            board(row, col) = 23;
                        case 'q'
                            board(row, col) = 25;
                        case 'k'
                            board(row, col) = 26;
                        case 'p'
                            board(row, col) = 21;
                        case 'R'
                            board(row, col) = 14;
                        case 'N'
                            board(row, col) = 12;
                        case 'B'
                            board(row, col) = 13;
                        case 'Q'
                            board(row, col) = 15;
                        case 'K'
                            board(row, col) = 16;
                        case 'P'
                            board(row, col) = 11;
                    end
                    col = col + 1;
                end
            end
        end
        % 9, 1 is whether white king has moved (0 = no, 1 = yes)
        board(9, 1) = 1;
        % 9, 2 is whether white left rook has moved (0 = no, 1 = yes)
        board(9, 2) = 1;
        % 9, 3 is whether white right rook has moved (0 = no, 1 = yes)
        board(9, 3) = 1;
        % 9, 4 is whether black king has moved (0 = no, 1 = yes)
        board(9, 4) = 1;
        % 9, 5 is whether black left rook has moved (0 = no, 1 = yes)
        board(9, 5) = 1;
        % 9, 6 is whether black right rook has moved (0 = no, 1 = yes)
        board(9, 6) = 1;

        % 9, 7 is the column of which white moved a pawn twice (meaning black can
        % en passant that square)
        board(9, 7) = 0;

        % 9, 8 is the column of which black moved a pawn twice (meaning white can
        % en passant that square)
        board(9, 8) = 0;

        board(10, 1) = 1;
        % 10, 1 is whether it's white or black's turn (1 = white, 2 = black)
        if i == 22 || i == 23 || i == 33 || i == 36 || i == 37 || i == 46
            board(9, 1) = 0;
            board(9, 2) = 0;
            board(9, 3) = 0;
            board(9, 4) = 0;
            board(9, 5) = 0;
            board(9, 6) = 0;
        end
        
        if i == 39 || i == 40 || i == 43
            board(10, 1) = 2;
        end
            
        %black right castle
        if i == 2 || i == 18 || i ==26 || i ==30
            board(10,4) = 1;
        end
            
            
            boards{i} = board;
    end
end