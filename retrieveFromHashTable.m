function entry = retrieveFromHashTable(hashTable, key)
    if isKey(hashTable, key)
        entry = hashTable(key);
    else
        entry = [];
    end
end