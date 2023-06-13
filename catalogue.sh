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
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
cd /app 
echo -e "\e[33m Extract application content \e[0m"
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log
cd /app 
echo -e "\e[33m Installing node js dependencies \e[0m"
npm install &>>/tmp/roboshop.log
echo -e "\e[33m Setup systemd service \e[0m"
cp /root/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl restart catalogue &>>/tmp/roboshop.log
echo -e "\e[33m Copy Mongodb repo file \e[0m"
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log
yum install mongodb-org-shell -y &>>/tmp/roboshop.log
mongo --host mongodb-dev.teawithdevops.store </app/schema/catalogue.js &>>/tmp/roboshop.log