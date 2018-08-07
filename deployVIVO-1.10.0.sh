apt-get -y update
apt-get -y upgrade
apt-get -y install git tomcat8 default-jdk maven mariadb-server

cd /usr/local/src
# from https://github.com/vivo-project/VIVO/releases
mkdir vivo-1.10.0
cd vivo-1.10.0
wget https://github.com/vivo-project/VIVO/releases/download/vivo-1.10.0/VIVO-1.10.0.tar.gz
tar xf VIVO-1.10.0.tar.gz
rm VIVO-1.10.0.tar.gz
wget http://mirrors.supportex.net/apache/freemarker/engine/2.3.28/binaries/apache-freemarker-2.3.28-bin.tar.gz
tar xf apache-freemarker-2.3.28-bin.tar.gz
mkdir /usr/local/vivo
mkdir /usr/local/vivo/home

cat >settings.xml << EOF
<settings xmlns="http://maven.apache.org/SETTINGS/1.1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.1.0 http://maven.apache.org/xsd/settings-1.1.0.xsd">

    <profiles>
        <profile>
            <id>defaults</id>
            <properties>
                <app-name>vivo</app-name>

                <vivo-dir>/usr/local/vivo/home</vivo-dir>
                <tomcat-dir>/var/lib/tomcat8</tomcat-dir>

                <default-theme>wilma</default-theme>
            </properties>
        </profile>
    </profiles>

    <activeProfiles>
        <activeProfile>defaults</activeProfile>
    </activeProfiles>
</settings>
EOF
mvn install -s settings.xml

# setup mysql
mysql << EOF
CREATE DATABASE vitrodb CHARACTER SET utf8;
GRANT ALL ON vitrodb.* TO 'vitrodbUsername'@'localhost' IDENTIFIED BY 'vitrodbPassword';
flush privileges;
EOF


cd /usr/local/vivo/home
cp config/example.runtime.properties runtime.properties
cd config
cp example.applicationSetup.n3 applicationSetup.n3
chown -R tomcat8:tomcat8 /usr/local/vivo/home

# set tomcat8 to utf-8
cp /etc/tomcat8/server.xml /etc/tomcat8/server.xml.org
sed -e "s/<Connector/<Connector URIEncoding=\"UTF-8\"/" </etc/tomcat8/server.xml.org >/etc/tomcat8/server.xml

/etc/init.d/tomcat8 restart
cd /tmp
## add latest freemarker (optional)
#wget http://mirrors.supportex.net/apache/freemarker/engine/2.3.28/binaries/apache-freemarker-2.3.28-bin.tar.gz
#tar xf apache-freemarker-2.3.28-bin.tar.gz
#mv apache-freemarker-2.3.28-bin/freemarker.jar /var/lib/tomcat8/webapps/vivo/WEB-INF/lib/freemarker-2.3.28.jar
#rm /var/lib/tomcat8/webapps/vivo/WEB-INF/lib/freemarker-2.3.23.jar

# the script is too fast, so wait for tomcat to start
wget --verbose http://localhost:8080/vivo/

#echo login on http://localhost:8080/vivo/
echo login on http://`hostname`:8080/vivo/
echo with username vivo_root@mydomain.edu
echo and password rootPassword
