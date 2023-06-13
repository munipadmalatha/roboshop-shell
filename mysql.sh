echo -e "\e[33m Disable mysql default version\e[0m"
yum module disable mysql -y &>>/tmp/roboshop.log
echo -e "\e[33m copying and configuring mysql repo file \e[0m"
cp /root/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo
echo -e "\e[33m Installing mysql-server \e[0m"
yum install mysql-community-server -y &>>/tmp/roboshop.log
echo -e "\e[33m starting mysql service \e[0m"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl restart mysqld &>>/tmp/roboshop.log
echo -e "\e[33m setting up mysql password\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/roboshop.log
