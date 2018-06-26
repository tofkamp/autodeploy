apt-get update
apt-get -y upgrade
apt-get -y install git tomcat8 default-jdk maven mariadb-server

cd /usr/local/src
mkdir vitrolib
cd vitrolib
git clone https://github.com/ld4l-labs/Vitro.git -b vitrolib/master
git clone https://github.com/ld4l-labs/vitrolib.git -b master

# http://bit.ly/2elwbY0

mkdir /usr/local/vitrolib
mkdir /usr/local/vitrolib/home

cd vitrolib
cat >settings.xml << EOF
<settings xmlns="http://maven.apache.org/SETTINGS/1.1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.1.0 http://maven.apache.org/xsd/settings-1.1.0.xsd">

    <profiles>
        <profile>
            <id>defaults</id>
            <properties>
                <app-name>vitrolib</app-name>

                <vitrolib-home-dir>/usr/local/vitrolib/home</vitrolib-home-dir>
                <tomcat-dir>/var/lib/tomcat8</tomcat-dir>

                <default-theme>vitrolib</default-theme>
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
CREATE DATABASE vitrolib CHARACTER SET utf8;
GRANT ALL ON vitrolib.* TO 'vitrolibUsername'@'localhost' IDENTIFIED BY 'vitrolibPassword';
flush privileges;
EOF

cd /usr/local/vitrolib/home
cp config/example.runtime.properties runtime.properties
cd config
cp example.applicationSetup.n3 applicationSetup.n3
chown -R tomcat8:tomcat8 /usr/local/vitrolib/home

# set tomcat8 to utf-8
cp /etc/tomcat8/server.xml /etc/tomcat8/server.xml.org
sed -e "s/<Connector/<Connector URIEncoding=\"UTF-8\"/" </etc/tomcat8/server.xml.org >/etc/tomcat8/server.xml

# fix bug with wrong directory of tomcat8
ln -s /var/log/tomcat8 /usr/share/tomcat8/logs

/etc/init.d/tomcat8 restart
# then wait for tomcat to start
cd /tmp
wget --verbose http://localhost:8080/vitrolib/

# only for test servers
#chmod 777 /var/log/tomcat8
#apt-get -y install mc

#echo login on http://localhost:8080/vitrolib/
echo
echo
echo login on http://`hostname`:8080/vitrolib/
echo with username vitrolib_root@mydomain.edu
echo and password rootPassword
