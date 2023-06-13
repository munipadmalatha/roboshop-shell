echo -e "\e[33m Installing Python Module \e[0m"
yum install python36 gcc python3-devel -y &>>/tmp/roboshop.log
echo -e "\e[33m  Adding the application user\e[0m"
useradd roboshop &>>/tmp/roboshop.log
echo -e "\e[33m creating directory to store payment artifacts locally \e[0m"
mkdir /app 
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip &>>/tmp/roboshop.log
cd /app 
unzip /tmp/payment.zip &>>/tmp/roboshop.log
echo -e "\e[33m Installing pip requirements \e[0m"
pip3.6 install -r requirements.txt &>>/tmp/roboshop.log
echo -e "\e[33m Copying payment service to etc\e[0m"
cp /root/payment.service /etc/systemd/system/payment.service &>>/tmp/roboshop.log
echo -e "\e[33m Starting Payment service \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable payment &>>/tmp/roboshop.log
systemctl restart payment &>>/tmp/roboshop.log