#Используем базовый образ Ubuntu 20.04
FROM ubuntu:20.04
RUN apt update

#Установка AdoptOpenJDK
RUN apt-get install default-jdk -y

#Установка и запуск Tomcat9
RUN apt-get install tomcat9 -y
EXPOSE 8080

#Установка Git
RUN apt-get install git -y

#Установка maven
RUN apt-get install maven -y


#Клонирование репозитория, сборка, копирование веб-приложения в Tomcat9
WORKDIR /usr/local/tomcat/webapps
WORKDIR /home/pkhramchenkov/
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
WORKDIR /home/pkhramchenkov/boxfuse-sample-java-war-hello/
RUN mvn package
WORKDIR /home/pkhramchenkov/boxfuse-sample-java-war-hello/target/
RUN cp hello-1.0.war /usr/local/tomcat/webapps/

#Запуск службы Tomcat9
ENV CATALINA_HOME /usr/share/tomcat9
ENV PATH $CATALINA_HOME/bin:$PATH
WORKDIR $CATALINA_HOME
CMD ["catalina.sh", "run"]