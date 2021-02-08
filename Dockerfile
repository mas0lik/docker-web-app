#Используем базовый образ Ubuntu 20.04
FROM ubuntu:20.04
RUN apt update
#Установка AdoptOpenJDK
RUN apt-get install default-jdk -y
#Установка Git
RUN apt-get install git -y
#Установка maven
RUN apt-get install maven -y
#Клонирование репозитория, сборка веб-приложения
WORKDIR /home/pkhramchenkov/
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
WORKDIR /home/pkhramchenkov/boxfuse-sample-java-war-hello/
RUN mvn package
#Запуск Tomcat9 и развертывание веб-приложения
ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME
RUN wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.43/bin/apache-tomcat-9.0.43.tar.gz -O /tmp/tomcat.tar.gz
RUN cd /tmp && tar xvfz tomcat.tar.gz
RUN cp -Rv /tmp/apache-tomcat-9.0.43/* /usr/local/tomcat/
EXPOSE 8080
RUN cp /home/pkhramchenkov/boxfuse-sample-java-war-hello/target/hello-1.0.war /usr/local/tomcat/webapps/
CMD ["catalina.sh", "run"]