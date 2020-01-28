 #!/bin/bash

####variables####
denom=ubtsg
validator=$1
delegator=$2
wallet_name=$3
wallet_password=$4
path="/usr/local/bin"

reward=$($path/bitsongcli q distribution rewards $delegator $validator | sed -n 2p | cut -d "\"" -f 2 | cut -d "." -f 1)

echo REWARD IS: $reward

#sleep 7

#echo Let's extract the rewar
echo $wallet_password | $path/bitsongcli tx distribution withdraw-rewards --commission $validator --from $wallet_name --chain-id bitsong-testnet-3 --yes
echo WAITING TO APPLY THE TX
sleep 8
#echo --====TX SHOULD BE APPLIED NOW, LET's GO FURTHER===--
balance=$($path/bitsongcli q account $delegator | sed -n 5p | cut -d "\"" -f 2)

echo CURRENT BALANCE IS: $balance
echo "Let's delegate $balance of reward tokens to "$validator
echo ""
echo $wallet_password | $path/bitsongcli tx staking delegate $validator $balance$denom --from $wallet_name --chain-id bitsong-testnet-3 --yes
sleep 8
echo "DONE"


