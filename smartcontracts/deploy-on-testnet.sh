source .env

forge script script/deploy.testnet.s.sol:Testnet \
    --private-key $SEPOLIA_PRIVATE_KEY \
    --rpc-url $SEPOLIA_RPC_URL \
    --broadcast
