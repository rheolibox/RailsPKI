#--
# Copyright (c) 2006 Stephan Toggweiler
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++

class Role < ActiveRecord::Base 
  has_and_belongs_to_many :users
  has_and_belongs_to_many :auth_methods
  
  belongs_to :ca_domain
  belongs_to :ra_server

  validates_presence_of :name
  validates_presence_of :ca_domain_id
  validates_presence_of :ra_server_id
  
  ROLE_CA_ADMIN="ca_admin"
  ROLE_CA_CERT_MGR="ca_cert_mgr"
  ROLE_RA_CERT_MGR="ra_cert_mgr"
  ROLE_RA_APPLICANT="ra_applicant"

  def to_name
    ca_domain="Local"
    ca_domain=self.ca_domain.name if !self.ca_domain.nil?
    ra_server="-local-"
    ra_server=self.ra_server.name if !self.ra_server.nil?
    "#{self.name}(#{ca_domain}/#{ra_server})"
  end
end
