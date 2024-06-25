#!/bin/bash

sudo apt update
sudo apt install jq -y

install_expect() {
    sudo apt install -y expect
}

# Kiểm tra nếu expect đã được cài đặt, nếu chưa, cài đặt nó
if ! command -v expect &>/dev/null; then
    echo "Expect is not installed. Installing..."
    install_expect
fi

KEYSTORE_DIR="$HOME/piccadilly-keystore"
DATA_DIR="$HOME/autonity-client/autonity-chaindata"
MSG="Application for the stake delegation program"

echo -e "\n ----- Begin get SIGNATURE OF MESSAGE FOR SDP APPLICATION...\n"
sleep 1

read -r -p "Enter wallet password: " WALLET_PASSWORD

# Xóa các khóa cũ nếu có
sudo rm -rf $KEYSTORE_DIR/node.priv $KEYSTORE_DIR/node.key

# Trích xuất khóa từ tệp autonitykeys
head -c 64 "$DATA_DIR/autonity/autonitykeys" > "$KEYSTORE_DIR/node.priv"

# Sử dụng expect để tự động nhập mật khẩu
expect << EOF
spawn aut account import-private-key -s $KEYSTORE_DIR -k "$KEYSTORE_DIR/node.key" "$KEYSTORE_DIR/node.priv"
expect "Password for new account:"
send "$WALLET_PASSWORD\r"
expect "Confirm account password:"
send "$WALLET_PASSWORD\r"
expect eof
EOF

echo -e "\n\nSign command: aut account sign-message -p $WALLET_PASSWORD -k $KEYSTORE_DIR/node.key \"$MSG\""

signature_message=$(aut account sign-message -p $WALLET_PASSWORD -k "$KEYSTORE_DIR/node.key" "$MSG")

admin_enode=$(aut node info | jq -r '.admin_enode')

echo -e "\n======== ENODE OF YOUR VALIDATOR NODE ========\n"
echo -e "\e[1m\e[32m$admin_enode \e[0m"
echo -e "\n===============================================\n"

echo -e "\n======== SIGNATURE OF MESSAGE FOR SDP APPLICATION ========\n"
echo -e "\e[1m\e[32m$signature_message \e[0m"
echo -e "\n==========================================================\n"

echo -e "\e[1m\e[32m GOOD LUCK ! \e[0m"
