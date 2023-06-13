echo -e "\e[33m Installing nginx \e[0m"
yum install nginx -y &>>/tmp/roboshop.log
echo -e "\e[33m Removing old app content \e[0m"
rm -rf /usr/share/nginx/html/* &>>/tmp/roboshop.log
echo -e "\e[33m Loading the front end content \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>/tmp/roboshop.log
echo -e "\e[33m extracting the front end content \e[0m"
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip &>>/tmp/roboshop.log
echo -e "\e[33m updating roboshop configuration file \e[0m"
cp /root/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf 
echo -e "\e[33m Starting nginx server \e[0m"
systemctl enable nginx &>>/tmp/roboshop.log
systemctl restart nginx &>>/tmp/roboshop.log