echo -e "\e[33m Installing maven \e[0m"
yum install maven -y &>>/tmp/roboshop.log
echo -e "\e[33m Adding application user \e[0m"
useradd roboshop &>>/tmp/roboshop.log
echo -e "\e[33m Create Application directory \e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app 
echo -e "\e[33m Download Application Content \e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip &>>/tmp/roboshop.log
cd /app 
echo -e "\e[33m  Extract Application Content\e[0m"
unzip /tmp/shipping.zip &>>/tmp/roboshop.log
echo -e "\e[33m Download Maven dependencies \e[0m"
mvn clean package &>>/tmp/roboshop.log
mv target/shipping-1.0.jar shipping.jar &>>/tmp/roboshop.log
echo -e "\e[33m Install mysqll client \e[0m" 
yum install mysql -y&>>/tmp/roboshop.log
echo -e "\e[33m Load schema \e[0m"
mysql -h mysql-dev.teawithdevops.store -uroot -pRoboShop@1 < /app/schema/shipping.sql &>>/tmp/roboshop.log
echo -e "\e[33m setting up systemd Shipping service \e[0m"
cp /root/roboshop-shell/shipping.service /etc/systemd/system/shipping.service &>>/tmp/roboshop.log 
echo -e "\e[33m Start Shipping service \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable shipping &>>/tmp/roboshop.log
systemctl restart shipping &>>/tmp/roboshop.log