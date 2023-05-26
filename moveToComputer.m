function move = moveToComputer(move, board, turn)
    legalMoves = getLegalMoves(board, turn);
    priorPosY = (double(lower(move(1))) - 96);
    priorPosX = 9 - str2double(move(2));
    postPosY = (double(lower(move(3))) - 96);
    postPosX = 9 - str2double(move(4));

    priorPos = priorPosX*10+priorPosY;
    postPos = postPosX*10+postPosY;

    for i = 1:size(legalMoves,2)
       if priorPos == legalMoves(1, i) && postPos == legalMoves(2, i)
          move = legalMoves(:,i);
          return
       end
    end
    
    move = [0 0 0 0];
end