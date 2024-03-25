// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Main {
   
    string public lastInsertedValue = "";
    string public lastManipulatedTable = "";
    // Struct to represent a record in a table
    struct Record {
        uint256 id;
        string data;
    }

    // Struct to represent a table
    struct Table {
        mapping(uint256 => Record) records;
        uint256 recordCount;
    }

    // Mapping to store tables
    mapping(string => Table) private tables;

    // Event to log INSERT, UPDATE, DELETE operations
    event Operation(
        string operation,
        string tableName,
        uint256 recordId,
        string data
    );

    // Function to insert a record into a table
    function insertRecord(string memory tableName, string memory data) public {
        Table storage table = tables[tableName];
        uint256 recordId = table.recordCount;
        table.records[recordId] = Record(recordId, data);
        table.recordCount++;
        lastInsertedValue = data;
        lastManipulatedTable = tableName;
        getTable(tableName);
        emit Operation("INSERT", tableName, recordId, data);
    }

    // Function to update a record in a table
    function updateRecord(
        string memory tableName,
        uint256 recordId,
        string memory newData
    ) public {
        require(
            recordId < tables[tableName].recordCount,
            "Record does not exist"
        );
        tables[tableName].records[recordId].data = newData;
        lastManipulatedTable = tableName;
        getTable(tableName);
        emit Operation("UPDATE", tableName, recordId, newData);
    }

    // Function to delete a record from a table
    function deleteRecord(string memory tableName, uint256 recordId) public {
        require(
            recordId < tables[tableName].recordCount,
            "Record does not exist"
        );
        string memory deletedData = tables[tableName].records[recordId].data;
        delete tables[tableName].records[recordId];
        lastManipulatedTable = tableName;
        getTable(tableName);
        emit Operation("DELETE", tableName, recordId, deletedData);
    }

    // Function to get data of a record from a table
    function getRecord(
        string memory tableName,
        uint256 recordId
    ) public view returns (Record memory) {
        require(
            recordId < tables[tableName].recordCount,
            "Record does not exist"
        );
        Record memory record = tables[tableName].records[recordId];
        getTable(tableName);
        return Record(record.id, record.data);
    }

    // Function to get all records from a table
    function getTable(
        string memory tableName
    ) public view returns (Record[] memory) {
        uint256 recordCount = tables[tableName].recordCount;
        Record[] memory allRecords = new Record[](recordCount);
        for (uint256 i = 0; i < recordCount; i++) {
            allRecords[i] = tables[tableName].records[i];
        }
        return allRecords;
    }
}
