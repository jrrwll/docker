
-- role
create role sonarqube;
alter role sonarqube with password 'sonarqube';
alter role sonarqube login;

-- database
create database sonarqube
    with owner=sonarqube template=template0
    encoding='UTF8' connection limit = 100;

grant all privileges on database sonarqube to sonarqube;
