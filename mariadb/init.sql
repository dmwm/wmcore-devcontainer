CREATE DATABASE wmagent;

CREATE USER 'unittestagent'@'localhost' IDENTIFIED BY 'dmwmtest';
GRANT ALL ON wmagent.* TO unittestagent@localhost;
CREATE USER 'unittestagent'@'127.0.0.1' IDENTIFIED BY 'dmwmtest';
GRANT ALL ON wmagent.* TO unittestagent@127.0.0.1;
