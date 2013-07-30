h1. r509-validity-crl
This project is related to [r509](http://github.com/reaperhulk/r509) and [r509-ocsp-responder](http://github.com/reaperhulk/r509-ocsp-responder) projects. It allows certificate validity and revocation information to be read from a pre-generated CRL and used to populate OCSP responses.

h2. Limitations
Due to the way CRLs work the responder can only operate in "known bad" mode. That is, the OCSP responder will respond "VALID" to all queries for certificates that are not explicitly revoked. This is in contrast to "known good" mode enabled by tracking all issuances with a plugin like [r509-validity-redis](http://github.com/sirsean/r509-validity-redis), which allows for VALID, REVOKED, and UNKNOWN responses.
