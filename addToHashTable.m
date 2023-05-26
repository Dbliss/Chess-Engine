function addToHashTable(hashTable, key, depth, bestMove, evaluation, colour, flag)
% Store the position data in the hash table
data.depth = depth;
data.value = evaluation;
data.move = bestMove;
data.colour = colour;
data.flag = flag;

hashTable(key) = data;
end