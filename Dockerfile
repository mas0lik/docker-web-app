#Используем базовый образ Ubuntu 20.04
FROM ubuntu:20.04
RUN apt update

#Установка AdoptOpenJDK
RUN apt install default-jdk -y

#Установка и запуск Tomcat9
RUN apt install tomcat9 -y
EXPOSE 8080

#Установка Git и клонирование репозитория
RUN apt install git -y
RUN mkdir /home/pkhramchenkov
RUN cd /home/pkhramchenkov/
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git

#Установка maven и сборка web-приложения
RUN apt install maven -y
RUN cd /home/pkhramchenkov/boxfuse-sample-java-war-hello/
RUN mvn package

#Копирование приложения в Tomcat9
RUN cd /home/pkhramchenkov/boxfuse-sample-java-war-hello/target/
RUN cp hello-1.0.war /var/lib/tomcat9/webapps/