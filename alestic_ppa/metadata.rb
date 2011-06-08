maintainer        "Capsunlock.Net "
maintainer_email  "rodney@capsunlock.net"
license           "Apache 2.0"
description       "Installs and configures Alestic PPA"
version           "0.0.4"
recipe            "alestic_ppa", "Installs and configures Alestic PPA"
%w{ ubuntu }.each do |os|
  supports os
end
