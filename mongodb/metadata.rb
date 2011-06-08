maintainer        "Capsunlock.Net "
maintainer_email  "rodney@capsunlock.net"
license           "Apache 2.0"
description       "Installs and configures mongodb"
version           "0.0.4"
recipe            "mongodb", "Installs and configures mongodb"

%w{ ubuntu }.each do |os|
  supports os
end

