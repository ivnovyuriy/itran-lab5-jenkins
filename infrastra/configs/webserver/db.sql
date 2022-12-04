-- creating database && user
CREATE DATABASE db DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
CREATE USER 'db_user'@'localhost' IDENTIFIED BY 'db_P@ssw0rd';
GRANT ALL ON db.* TO 'db_user'@'localhost';