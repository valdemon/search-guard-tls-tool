# Minimalistic image for the SearchGuard TLS Tool

For detais please refer to [TLS Tool official page](https://docs.search-guard.com/latest/offline-tls-tool)

## Usage

1. Create the confoguration file `conf/config.yml` file following the instructions from [TLS Tool official page](https://docs.search-guard.com/latest/offline-tls-tool).
The `config.yml` could look something like:

```yml
defaults:
  validityDays: 730
  pkPassword: auto
  generatedPasswordLength: 12
  nodesDn:
    - "CN=*.example.com,OU=Ops,O=Example Com\\, Inc.,DC=example,DC=com"
  nodeOid: "1.2.3.4.5.5"
  httpEnabled: true
  reuseTransportCertificatesForHttp: false

ca:
   root:
      dn: CN=root.ca.example.com,OU=CA,O=Example Com\, Inc.,DC=example,DC=com
      keysize: 2048
      pkPassword: root-ca-password 
      validityDays: 3650
      file: root-ca.pem
      
nodes:
  nodes:
  - name: node1
    dn: CN=node1.example.com,OU=Ops,O=Example Com\, Inc.,DC=example,DC=com
    dns: node1.example.com
    ip: 10.0.2.1
  - name: node2
    dn: CN=node2.example.com,OU=Ops,O=Example Com\, Inc.,DC=example,DC=com
    dns: node2.example.com

clients:
  - name: spock
    dn: CN=spock.example.com,OU=Ops,O=Example Com\, Inc.,DC=example,DC=com
  - name: kirk
    dn: CN=kirk.example.com,OU=Ops,O=Example Com\, Inc.,DC=example,DC=com
    admin: true
```

2. Run the command due to generate certificates and the `Elasticsearch` configuration snippet:

```bash
#!/bin/sh
mkdir -p .certs
docker run -it --rm -v $PWD/conf:/workspace/conf -v $PWD/.certs:/workspace/out -w /workspace valdemon/search-guard-tls-tool:latest -c conf/config.yml -ca -crt
```
