// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {User} from "./User.sol";

contract Survey is Ownable {
    User public user;

    struct SurveyData {
        bytes32 key;
        address rewardToken;
        uint256 reward;
        uint256 participants;
        uint256 maxParticipants;
        uint256 startedAt;
        uint256 endedAt;
        bool paused;
    }

    SurveyData[] public surveys;
    mapping(uint256 => mapping(address => bool)) public participants;
    mapping(uint256 => bytes) public answers;

    event NewSurvey(
        uint256 id, bytes32 surveyKey, uint256 reward, uint256 maxParticipants, uint256 startedAt, uint256 endedAt
    );

    constructor(address user_) Ownable(msg.sender) {
        user = User(user_);
    }

    function surveyCount() external view returns (uint256) {
        return surveys.length;
    }

    function surveyData(uint256 id) external view returns (SurveyData memory) {
        return surveys[id];
    }

    ///@notice Add a survey to the contract
    ///@param key The key of the survey(IPFS hash for survey form data JSON)
    ///@param rewardToken The address of the token to be used as reward
    ///@param reward The reward for completing the survey
    ///@param startedAt The time the survey starts
    ///@param endedAt The time the survey ends
    ///@param maxParticipants The maximum number of participants allowed for the survey
    function newSurvey(
        bytes32 key,
        address rewardToken,
        uint256 reward,
        uint256 startedAt,
        uint256 endedAt,
        uint256 maxParticipants
    ) external onlyOwner {
        require(endedAt > startedAt, "Invalid time range");
        require(maxParticipants > 0, "Invalid max participants");

        surveys.push(SurveyData(key, rewardToken, reward, 0, maxParticipants, startedAt, endedAt, false));

        // IERC20(rewardToken).transferFrom(msg.sender, address(this), reward * maxParticipants);

        emit NewSurvey(surveys.length - 1, key, reward, maxParticipants, startedAt, endedAt);
    }

    function participate(uint256 id, bytes memory answer) external {
        require(!participants[id][msg.sender], "Already participated");
        require(surveys[id].participants < surveys[id].maxParticipants, "Survey is full");
        require(block.timestamp >= surveys[id].startedAt, "Survey has not started");
        require(block.timestamp < surveys[id].endedAt, "Survey has ended");
        require(!surveys[id].paused, "Survey is paused");

        bytes32 kycData = user.kycDatas(msg.sender);
        require(kycData != 0, "KYC verification required");

        surveys[id].participants++;
        answers[id] = answer;
        participants[id][msg.sender] = true;
    }
}
