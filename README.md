#r509-validity-crl
This project is related to [r509](http://github.com/reaperhulk/r509) and [r509-ocsp-responder](http://github.com/reaperhulk/r509-ocsp-responder) projects. It allows certificate validity and revocation information to be read from a pre-generated CRL and used to populate OCSP responses.

##Usage
Remove the redis-related lines of the [config.ru](https://github.com/reaperhulk/r509-ocsp-responder#set-up-configru) for r509-ocsp-responder and replace them with this:
```ruby
require 'r509/validity/crl'
crl_paths = ['/path/to/crl','/path/to/crl2']
reload_interval = '60m'
Dependo::Registry[:validity_checker] = R509::Validity::CRL::Checker.new(crl_paths,reload_interval)
```
* Each element in crl_paths is an absolute path to a CRL to load on the filesystem. You should load those via an external cronjob.
* The reload_interval defines the interval at which the checker will reload the CRL from the filesystem. By default it is 60m.

##Limitations
Due to the way CRLs work the responder can only operate in "known bad" mode. That is, the OCSP responder will respond "VALID" to all queries for certificates that are not explicitly revoked. This is in contrast to "known good" mode enabled by tracking all issuances with a plugin like [r509-validity-redis](http://github.com/sirsean/r509-validity-redis), which allows for VALID, REVOKED, and UNKNOWN responses.
