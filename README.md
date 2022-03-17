# HAProxy OCSP Updater - Test Environment

To test a HAProxy OCSP updater script this docker-compose environment has been created.

# Usage
* Determine which version of HAProxy should be used. The version tag can be changed within Dockerfile. Default is HAProxy version 1.8.19.
* Put your certificate PEM file containing at least root, intermediate and company certificate as well into `haproxy/certs`. If the PEM file contains more than the certificates, make sure the private key appears directly after the certificates.
* Spin up environment using `docker-compose up -d --build`
* New files will be created in `haproxy/certs`:
	* <your-cert.pem>.issuer
	* <your-cert.pem>.ocsp
* wildcard certificates and multiple certificates do work.

## Get OCSP response of certificate using HAProxy
`echo quit | openssl s_client -connect 127.0.0.1:443 -tlsextdebug -status`

```
[...]
OCSP resonse should look like that:
======================================
OCSP Response Data:
    OCSP Response Status: successful (0x0)
    Response Type: Basic OCSP Response
    Version: 1 (0x0)
    Responder Id: A3C85E6554E53078C105EA070A6A59CCB9FEDE5A
    Produced At: Mar 16 16:00:35 2022 GMT
    Responses:
    Certificate ID:
      Hash Algorithm: sha1
      Issuer Name Hash: 85BE7D3DE1027E716193C16584CBE0573D9916F0
      Issuer Key Hash: A3C85E6554E53078C105EA070A6A59CCB9FEDE5A
      Serial Number: 0744A9E3DBA3AE22A5C940DFE193327F
    Cert Status: good
    This Update: Mar 16 15:45:01 2022 GMT
    Next Update: Mar 23 15:00:01 2022 GMT
[...]
```

## Log files
Check logs with `docker logs haproxy_ssl_test_haproxy_ssl_test_1` to get log output from:
* /var/log/haproxy/haproxy.log
* /var/log/haproxy/ocsp.log

All your files and folders are presented as a tree in the file explorer. You can switch from one to another by clicking a file in the tree.

## CRON
Cron executes the HAProxy updater script every minute to check if it's working.
