// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract User is Ownable {
    address public keeper;

    mapping(address => bytes32) public kycDatas;

    constructor(address keeper_) Ownable(msg.sender) {
        keeper = keeper_;
    }

    function kyc(address account, bytes32 data) external {
        require(msg.sender == keeper, "User: not authorized");
        kycDatas[account] = data;
    }
}
