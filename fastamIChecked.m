function check = fastamIChecked(board, colour)
check = false;

% Find the location of the kings
whiteKingRow = 0;
whiteKingCol = 0;
blackKingRow = 0;
blackKingCol = 0;
for i = 1:8
    for j = 1:8
        if board(i, j) == 16
            whiteKingRow = i;
            whiteKingCol = j;
        elseif board(i, j) == 26
            blackKingRow = i;
            blackKingCol = j;
        elseif whiteKingRow ~= 0 && blackKingRow ~= 0
            break
        end
    end
end

if colour == 1
    
    safeNorth = false;
    safeEast = false;
    safeSouth = false;
    safeWest = false;
    safeNorthEast = false;
    safeSouthEast = false;
    safeSouthWest = false;
    safeNorthWest = false;
    for i=1:7
        
       %north (queen/rook)
       if (whiteKingRow-i) > 0 && safeNorth == false
           if board(whiteKingRow-i, whiteKingCol) == 24 || board(whiteKingRow-i, whiteKingCol) == 25 
               check = true;
               return;
           elseif board(whiteKingRow-i, whiteKingCol) > 10
               safeNorth = true;
           end
       end
       
       %east (queen/rook)
       if (whiteKingCol+i) < 9 && safeEast == false
           if board(whiteKingRow, whiteKingCol+i) == 24 || board(whiteKingRow, whiteKingCol+i) == 25 
               check = true;
               return;
           elseif board(whiteKingRow, whiteKingCol+i) > 10
               safeEast = true;
           end 
       end
       
       %south (queen/rook)
       if (whiteKingRow+i) < 9 && safeSouth == false
           if board(whiteKingRow+i, whiteKingCol) == 24 || board(whiteKingRow+i, whiteKingCol) == 25 
               check = true;
               return;
           elseif board(whiteKingRow+i, whiteKingCol) > 10
               safeSouth = true;
           end 
       end
       
       %west (queen/rook)
       if (whiteKingCol-i) > 0 && safeWest == false
           if board(whiteKingRow, whiteKingCol-i) == 24 || board(whiteKingRow, whiteKingCol-i) == 25 
               check = true;
               return;
           elseif board(whiteKingRow, whiteKingCol-i) > 10
               safeWest = true;
           end 
       end
       
       
       %northEast (queen/bishop)
       if (whiteKingRow-i) > 0 && (whiteKingCol+i) < 9 && safeNorthEast == false
           if board(whiteKingRow-i, whiteKingCol+i) == 23 || board(whiteKingRow-i, whiteKingCol+i) == 25 || (board(whiteKingRow-i, whiteKingCol+i) == 21 && i == 1)
               check = true;
               return;
           elseif board(whiteKingRow-i, whiteKingCol+i)
               safeNorthEast = true;
           end
       end
       
       
       %SouthEast (queen/bishop)
       if (whiteKingRow+i) < 9 && (whiteKingCol+i) < 9 && safeSouthEast == false
           if board(whiteKingRow+i, whiteKingCol+i) == 23 || board(whiteKingRow+i, whiteKingCol+i) == 25
               check = true;
               return;
           elseif board(whiteKingRow+i, whiteKingCol+i) > 10
               safeSouthEast = true;
           end
       end
       
       
       %SouthWest (queen/bishop)
       if (whiteKingRow+i) < 9 && (whiteKingCol-i) > 0 && safeSouthWest == false
           if board(whiteKingRow+i, whiteKingCol-i) == 23 || board(whiteKingRow+i, whiteKingCol-i) == 25 
               check = true;
               return;
           elseif board(whiteKingRow+i, whiteKingCol-i) > 10
               safeSouthWest = true;
           end
       end
       
       %northWest (queen/bishop)
       if (whiteKingRow-i) > 0 && (whiteKingCol-i) > 0 && safeNorthWest == false
           if board(whiteKingRow-i, whiteKingCol-i) == 23 || board(whiteKingRow-i, whiteKingCol-i) == 25 || (board(whiteKingRow-i, whiteKingCol-i) == 21 && i == 1) 
               check = true;
               return;
           elseif board(whiteKingRow-i, whiteKingCol-i) > 10
               safeNorthWest = true;
           end
       end
       
       
    end
        
    %knight upper right
    if (whiteKingRow-2) > 0 && (whiteKingCol+1) < 9
        if board(whiteKingRow-2, whiteKingCol+1) == 22
            check = true;
            return;
        end   
    end
    
    %knight right upper
    if (whiteKingRow-1) > 0 && (whiteKingCol+2) < 9
        if board(whiteKingRow-1, whiteKingCol+2) == 22
            check = true;
            return;
        end   
    end
    
    %knight right lower
    if (whiteKingRow+1) < 9 && (whiteKingCol+2) < 9
        if board(whiteKingRow+1, whiteKingCol+2) == 22
            check = true;
            return;
        end   
    end
    
    %knight lower right
    if (whiteKingRow+2) < 9 && (whiteKingCol+1) < 9
        if board(whiteKingRow+2, whiteKingCol+1) == 22
            check = true;
            return;
        end   
    end
    
    %knight lower left
    if (whiteKingRow+2) < 9 && (whiteKingCol-1) > 0
        if board(whiteKingRow+2, whiteKingCol-1) == 22
            check = true;
            return;
        end   
    end
    
    %knight left lower
    if (whiteKingRow+1) < 9 && (whiteKingCol-2) > 0
        if board(whiteKingRow+1, whiteKingCol-2) == 22
            check = true;
            return;
        end   
    end
    
    %knight left upper
    if (whiteKingRow-1) > 0 && (whiteKingCol-2) > 0
        if board(whiteKingRow-1, whiteKingCol-2) == 22
            check = true;
            return;
        end   
    end
    
    %knight upper left
    if (whiteKingRow-2) > 0 && (whiteKingCol-1) > 0
        if board(whiteKingRow-2, whiteKingCol-1) == 22
            check = true;
            return;
        end   
    end
    
    % cant be next to black king
    if abs(blackKingRow-whiteKingRow) < 2 && abs(blackKingCol-whiteKingCol) < 2
        check = true;
        return;
    end
    
end

if colour == 2

    
    safeNorth = false;
    safeEast = false;
    safeSouth = false;
    safeWest = false;
    safeNorthEast = false;
    safeSouthEast = false;
    safeSouthWest = false;
    safeNorthWest = false;
    for i=1:7
        
       %north (queen/rook)
       if (blackKingRow-i) > 0
           if safeNorth == false
               if board(blackKingRow-i, blackKingCol) == 14 || board(blackKingRow-i, blackKingCol) == 15 
                   check = true;
                   return;
               elseif board(blackKingRow-i, blackKingCol) > 20 || board(blackKingRow-i, blackKingCol) == 11 || board(blackKingRow-i, blackKingCol) == 12 || board(blackKingRow-i, blackKingCol) == 13   
                   safeNorth = true;
               end
           end
       end
       
       %east (queen/rook)
       if (blackKingCol+i) < 9
           if safeEast == false
               if board(blackKingRow, blackKingCol+i) == 14 || board(blackKingRow, blackKingCol+i) == 15 
                   check = true;
                   return;
               elseif board(blackKingRow, blackKingCol+i) > 10
                   safeEast = true;
               end 
           end
       end
       
       %south (queen/rook)
       if (blackKingRow+i) < 9 
           if safeSouth == false
               if board(blackKingRow+i, blackKingCol) == 14 || board(blackKingRow+i, blackKingCol) == 15 
                   check = true;
                   return;
               elseif board(blackKingRow+i, blackKingCol) > 10
                   safeSouth = true;
               end 
           end
       end
       
       %west (queen/rook)
       if (blackKingCol-i) > 0 
           if safeWest == false
               if board(blackKingRow, blackKingCol-i) == 14 || board(blackKingRow, blackKingCol-i) == 15 
                   check = true;
                   return;
               elseif board(blackKingRow, blackKingCol-i) > 10
                   safeWest = true;
               end
           end
       end
       
       
       %northEast (queen/bishop)
       if (blackKingRow-i) > 0 
           if (blackKingCol+i) < 9
               if safeNorthEast == false
                   if board(blackKingRow-i, blackKingCol+i) == 13 || board(blackKingRow-i, blackKingCol+i) == 15 
                       check = true;
                       return;
                   elseif board(blackKingRow-i, blackKingCol+i) > 10
                       safeNorthEast = true;
                   end
               end
           end
       end
       
       
       %SouthEast (queen/bishop)
       if (blackKingRow+i) < 9 
           if (blackKingCol+i) < 9 
               if safeSouthEast == false
                   if board(blackKingRow+i, blackKingCol+i) == 13 || board(blackKingRow+i, blackKingCol+i) == 15 || (board(blackKingRow+i, blackKingCol+i) == 11 && i == 1)
                       check = true;
                       return;
                   elseif board(blackKingRow+i, blackKingCol+i) > 10
                       safeSouthEast = true;
                   end
               end
           end
       end
       
       
       %SouthWest (queen/bishop)
       if (blackKingRow+i) < 9 
           if(blackKingCol-i) > 0 
               if safeSouthWest == false
                   if board(blackKingRow+i, blackKingCol-i) == 13 || board(blackKingRow+i, blackKingCol-i) == 15 || (board(blackKingRow+i, blackKingCol-i) == 11 && i == 1)
                       check = true;
                       return;
                   elseif board(blackKingRow+i, blackKingCol-i) > 10
                       safeSouthWest = true;
                   end
               end
           end
       end
       
       %northWest (queen/bishop)
       if (blackKingRow-i) > 0 
           if (blackKingCol-i) > 0 
               if safeNorthWest == false
                   if board(blackKingRow-i, blackKingCol-i) == 13 || board(blackKingRow-i, blackKingCol-i) == 15 
                       check = true;
                       return;
                   elseif board(blackKingRow-i, blackKingCol-i) > 10
                       safeNorthWest = true;
                   end
               end
           end
       end 
    end
    
    %knight upper right
    if (blackKingRow-2) > 0 
        if (blackKingCol+1) < 9
            if board(blackKingRow-2, blackKingCol+1) == 12
                check = true;
                return;
            end   
        end
    end
    
    %knight right upper
    if (blackKingRow-1) > 0 
        if (blackKingCol+2) < 9
            if board(blackKingRow-1, blackKingCol+2) == 12
                check = true;
                return;
            end  
        end
    end
    
    %knight right lower
    if (blackKingRow+1) < 9 
        if (blackKingCol+2) < 9
            if board(blackKingRow+1, blackKingCol+2) == 12
                check = true;
                return;
            end   
        end
    end
    
    %knight lower right
    if (blackKingRow+2) < 9
        if (blackKingCol+1) < 9
            if board(blackKingRow+2, blackKingCol+1) == 12
                check = true;
                return;
            end   
        end
    end
    
    %knight lower left
    if (blackKingRow+2) < 9 
        if (blackKingCol-1) > 0
            if board(blackKingRow+2, blackKingCol-1) == 12
                check = true;
                return;
            end 
        end
    end
    
    %knight left lower
    if (blackKingRow+1) < 9 
        if (blackKingCol-2) > 0
            if board(blackKingRow+1, blackKingCol-2) == 12
                check = true;
                return;
            end   
        end
    end
    
    %knight left upper
    if (blackKingRow-1) > 0 
        if (blackKingCol-2) > 0
            if board(blackKingRow-1, blackKingCol-2) == 12
                check = true;
                return;
            end 
        end
    end
    
    %knight upper left
    if (blackKingRow-2) > 0 
        if (blackKingCol-1) > 0
            if board(blackKingRow-2, blackKingCol-1) == 12
                check = true;
                return;
            end   
        end
    end
    
    % cant be next to white king
    if abs(whiteKingRow-blackKingRow) < 2 && abs(whiteKingCol-blackKingCol) < 2
        check = true;
        return;
    end
    
    
end

end