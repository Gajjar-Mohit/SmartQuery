
# Smart Query

Implementing the features of Structured Query Language to the Solidity Smart Contract.

## Authors

- [@Gajjar-Mohit](https://www.github.com/Gajjar-Mohit)


## Usage

To use this features in your smart contract, import like this:

```bash
  import "https://github.com/Gajjar-Mohit/SmartQuery/blob/main/Main.sol";
```

## Example

Your smart contract will look like this:

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "https://github.com/Smart-Query/SmartQuery/blob/main/Main.sol";

contract Test is Main {
    function insert(string memory tableName, string memory data) public {
        insertRecord(tableName, data);
    }
    function select(string memory tableName,
        uint256 recordId) public view returns (Record memory ) {
        return getRecord(tableName, recordId);
    }
}
```

