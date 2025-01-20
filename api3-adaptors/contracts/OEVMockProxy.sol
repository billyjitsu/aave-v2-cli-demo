// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@api3/contracts/v0.8/interfaces/IProxy.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract OEVMockProxy is Ownable {

    int224 private VALUE = 999903720000000000; // $1.00 
    uint256 private TIMESTAMP = block.timestamp;
    uint private referenceTimestamp = block.timestamp;

    address public assetProxy;

    function setAssetProxy(address _assetProxy) external onlyOwner {
        assetProxy = _assetProxy;
        referenceTimestamp = block.timestamp;
    }

    // function read() external view returns (int224, uint256) {
    //     return (VALUE, TIMESTAMP);
    // }

    function read() external view returns (int224, uint256) {
        (int224 value, uint256 timestamp) = IProxy(assetProxy).read();
        if (referenceTimestamp > timestamp) {
            return (value, referenceTimestamp);
        }else {
            return (VALUE, TIMESTAMP);
        }
    }


    function updateValue(int224 _value) external {
        VALUE = _value;
        TIMESTAMP = block.timestamp;
    }
}