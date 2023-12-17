# Autonity-API-Trading

Create MESSAGE:

    MESSAGE=$(jq -nc --arg nonce "$(date +%s%N)" '$ARGS.named')

Display the content of MESSAGE:

    echo $MESSAGE

Create a signature and save it to the message.sig file:

    aut account sign-message "$MESSAGE" > message.sig

Display the signature:

    cat message.sig

Send the API key to the server:

    curl -X POST -H "Content-Type: application/json" -H "API-Sig: $(cat message.sig)" -d "$MESSAGE" https://cax.piccadilly.autonity.org/api/apikeys

Verify access and check your balance:

    https GET https://cax.piccadilly.autonity.org/api/balances/ API-Key:<APIKEY>

        


    
    


    
