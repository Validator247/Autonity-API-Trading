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

Lấy orderbook:

        https GET https://cax.piccadilly.autonity.org/api/orderbooks/ API-Key:<APIKEY>

Lấy giá hiện tại:

Đối với ATN-USD:

        https GET https://cax.piccadilly.autonity.org/api/orderbooks/ATN-USD/quote API-Key:<APIKEY>


Đối với NTN-USD:

        https GET https://cax.piccadilly.autonity.org/api/orderbooks/NTN-USD/quote API-Key:<APIKEY>

Tạo lệnh mua ATN hoặc NTN:

        https POST https://cax.piccadilly.autonity.org/api/orders/ API-Key:$KEY pair=ATN-USD side=bid price=1.00 amount=10


Hoặc nếu bạn muốn bán ATN hoặc NTN:

        https POST https://cax.piccadilly.autonity.org/api/orders/ API-Key:$KEY pair=NTN-USD side=ask price=1.00 amount=10

Xác nhận lệnh hoàn thành: Ghi chú: Thay {order_id} bằng ID lệnh bạn đã tạo.

        https GET https://cax.piccadilly.autonity.org/api/orders/{order_id} API-Key:$KEY

Chuyển ATN và NTN on-chain và off-chain:

Chuyển on-chain:  ( ATN or TNT )

        https POST https://cax.piccadilly.autonity.org/api/withdraws/ API-Key:$KEY symbol=ATN amount=10

Chuyển off-chain:  ( Ghi chú: Thay <RECIPIENT_ADDRESS> và <AMOUNT> bằng địa chỉ và số lượng )

        aut tx make --to <RECIPIENT_ADDRESS> --value <AMOUNT> --ntn | aut tx sign - | aut tx send -

Lịch sử chuyển khoản:

        https GET https://cax.piccadilly.autonity.org/api/deposits/ API-Key:$KEY


                

        


    
    


    
