function entry = retrieveFromHashTable2(hashTable, key)
    keys = cell2mat(hashTable.keys);
    keyIndex = ismember(keys, key);
    
    if any(keyIndex)
        entry = hashTable(keys(keyIndex));
    else
        entry = [];
    end
end