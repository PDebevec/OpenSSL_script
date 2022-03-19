cd C:\Programs\nevem\src\cert
::Deleiting old certificates
del /f *.pem

::::GENERATE PASSWORD::::
::Generate passwd to file
openssl rand -base64 96 > passwd

::::CERTIFICATE AUTORITY'S CERTIFICATE and KEY::::
::Generate private key for ca
openssl genrsa 2048 > ca-key.pem

::Generate x509 certificat
openssl req -new -x509 -passout file:passwd -days 365 -key ca-key.pem -out ca-cert.pem -subj "/C=SI/ST=Ljubljana, L=Ljubljana, O=Organization d.o.o, OU=Organization, CN=ca-privkey-sscert/emailAddress=cohoxo4727@forfity.com"

::::SERVER'S CERTIFICATE and KEYS::::
::Generate private key and certificate request
openssl req -newkey rsa:2048 -passout file:passwd -days 365 -keyout server-key.pem -out server-req.pem -subj "/C=SI/ST=Postojna, L=Postojna, O=Organization d.o.o, OU=Organization, CN=ca-privkey-sscert/emailAddress=dareve3285@tonaeto.com"

::Generate x509 certificate
openssl x509 -req -days 365 -set_serial 01 -in server-req.pem -out server-cert.pem -CA ca-cert.pem -CAkey ca-key.pem

::::CLIENT'S CERTIFICATE and KEYS
::Generate private key and certificate request
openssl req -newkey rsa:2048 -passout file:passwd -days 365 -keyout client-key.pem -out client-req.pem -subj "/C=SI/ST=Postojna, L=Potojna, O=Organization d.o.o, OU=Organization, CN=ca-privkey-sscert/emailAddress=dareve3285@tonaeto.com"

::Generate x509 for client
openssl x509 -req -days 365 -set_serial 01 -in client-req.pem -out client-cert.pem -CA ca-cert.pem -CAkey ca-key.pem

::::VERIFY::::
::Verify server certificate
openssl verify -CAfile ca-cert.pem ca-cert.pem server-cert.pem

::Verify client certificate
openssl verify -CAfile ca-cert.pem ca-cert.pem client-cert.pem

ECHO %ERRORLEVEL%
PAUSE
CLS