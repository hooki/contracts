#!/bin/bash

source .env

cast send $SURVEY --rpc-url $OASYS_RPC_URL --private-key $PRIVATE_KEY "function newSurvey(bytes32 key, address rewardToken, uint256 reward, uint256 startedAt, uint256 endedAt, uint256 maxParticipants)" 0x48bed44d1bcd124a28c27f343a817e5f5243190d3c52bf347daf876de1dbbf77 $GF `cast to-wei 1` 0 1713497643 100
cast send $SURVEY --rpc-url $XPLA_RPC_URL --private-key $PRIVATE_KEY "function newSurvey(bytes32 key, address rewardToken, uint256 reward, uint256 startedAt, uint256 endedAt, uint256 maxParticipants)" 0x48bed44d1bcd124a28c27f343a817e5f5243190d3c52bf347daf876de1dbbf77 $GF `cast to-wei 1` 0 1713497643 100