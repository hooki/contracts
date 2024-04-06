#!/bin/bash

source .env

USER=`forge create src/USER.sol:User --rpc-url $OASYS_RPC_URL --private-key $PRIVATE_KEY --constructor-args $KEEPER | grep "Deployed to:" | awk '{print $3}'`
SURVEY=`forge create src/Survey.sol:Survey --rpc-url $OASYS_RPC_URL --private-key $PRIVATE_KEY --constructor-args $USER | grep "Deployed to:" | awk '{print $3}'`
GF=`forge create src/GF.sol:GF --rpc-url $OASYS_RPC_URL --private-key $PRIVATE_KEY | grep "Deployed to:" | awk '{print $3}'`

echo "NEXT_PUBLIC_SURVEY_ADDRESS=$SURVEY"
echo "NEXT_PUBLIC_GF_ADDRESS=$GF"
echo "NEXT_PUBLIC_USER_ADDRESS=$USER"


sed -i '' "s/SURVEY=.*/SURVEY=$SURVEY/" .env
sed -i '' "s/GF=.*/GF=$GF/" .env
sed -i '' "s/USER=.*/USER=$USER/" .env

USER=`forge create src/USER.sol:User --rpc-url $XPLA_RPC_URL --private-key $PRIVATE_KEY --constructor-args $KEEPER | grep "Deployed to:" | awk '{print $3}'`
SURVEY=`forge create src/Survey.sol:Survey --rpc-url $XPLA_RPC_URL --private-key $PRIVATE_KEY --constructor-args $USER | grep "Deployed to:" | awk '{print $3}'`
GF=`forge create src/GF.sol:GF --rpc-url $XPLA_RPC_URL --private-key $PRIVATE_KEY | grep "Deployed to:" | awk '{print $3}'`

echo "NEXT_PUBLIC_SURVEY_ADDRESS=$SURVEY"
echo "NEXT_PUBLIC_GF_ADDRESS=$GF"
echo "NEXT_PUBLIC_USER_ADDRESS=$USER"


sed -i '' "s/SURVEY=.*/SURVEY=$SURVEY/" .env
sed -i '' "s/GF=.*/GF=$GF/" .env
sed -i '' "s/USER=.*/USER=$USER/" .env