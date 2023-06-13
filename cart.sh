echo -e "\e[33m Installing nodejsrepos \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log
echo -e "\e[33m Installing nodejs\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log
echo -e "\e[33m Add application user \e[0m"
useradd roboshop &>>/tmp/roboshop.log
echo -e "\e[33m Create app location directory \e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app 
echo -e "\e[33m download application content\e[0m"
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/roboshop.log
cd /app 
echo -e "\e[33m Extract application content \e[0m"
unzip /tmp/cart.zip &>>/tmp/roboshop.log
cd /app 
echo -e "\e[33m Installing node js dependencies \e[0m"
npm install &>>/tmp/roboshop.log
echo -e "\e[33m Setup systemd service \e[0m"
cp /root/roboshop-shell/cart.service /etc/systemd/system/cart.service &>>/tmp/roboshop.log
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable cart &>>/tmp/roboshop.log
systemctl restart cart &>>/tmp/roboshop.log
