#
# Cookbook Name:: php-fpm
# Recipe:: xhprof
#
# Copyright 2010-2011, Till Klampaeckel
#
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this list
#   of conditions and the following disclaimer.
# * Redistributions in binary form must reproduce the above copyright notice, this
#   list of conditions and the following disclaimer in the documentation and/or other
#   materials provided with the distribution.
# * The names of its contributors may not be used to endorse or promote products
#   derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
# IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
# NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#

package "graphviz"

remote_file "/tmp/xhprof-#{node["php-fpm"][:xhprof_version]}.tgz" do
  source "http://pecl.php.net/get/xhprof-#{node["php-fpm"][:xhprof_version]}.tgz"
end

execute "XHProf: unpack" do
  command "cd /tmp && tar -xzf xhprof-#{node["php-fpm"][:xhprof_version]}.tgz"
end

## Due to a bug, we have to build xhprof by hand
## Reference: http://pecl.php.net/bugs/bug.php?id=16438

execute "XHProf: phpize" do
  cwd "/tmp/xhprof-#{node["php-fpm"][:xhprof_version]}/extension"
  command "phpize"
end

execute "XHProf: ./configure" do
  cwd "/tmp/xhprof-#{node["php-fpm"][:xhprof_version]}/extension"
  command "./configure"
end

execute "XHProf: make, make install" do
  cwd "/tmp/xhprof-#{node["php-fpm"][:xhprof_version]}/extension"
  command "make && make install"
end

remote_file "#{node["php-fpm"][:prefix]}/etc/php/xhprof.ini" do
  source "xhprof.ini"
  mode "0644"
end
