echo -e "\e[33m Copying mongodb.repo file \e[0m"
cp /root/roboshop-shell/mongodb.repo /etc/yum.repos.d/mongodb.repo 
echo -e "\e[33m Installing mongodb \e[0m"
yum install mongodb-org -y &>>/tmp/roboshop.log 
echo -e "\e[33m update mongodb listener address \e[0m"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>/tmp/roboshop.log

echo -e "\e[33m retsarting mongodb service \e[0m"
systemctl enable mongod &>>/tmp/roboshop.log

systemctl restart mongod &>>/tmp/roboshop.log