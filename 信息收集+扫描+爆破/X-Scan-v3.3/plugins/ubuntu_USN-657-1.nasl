# This script was automatically generated from the 657-1 Ubuntu Security Notice
# It is released under the Nessus Script Licence.
# Ubuntu Security Notices are (C) 2005 Canonical, Inc.
# USN2nasl Convertor is (C) 2005 Tenable Network Security, Inc.
# See http://www.ubuntulinux.org/usn/
# Ubuntu(R) is a registered trademark of Canonical, Inc.

if (! defined_func("bn_random")) exit(0);
include('compat.inc');

if (description) {
script_id(37944);
script_version("$Revision: 1.1 $");
script_copyright("Ubuntu Security Notice (C) 2009 Canonical, Inc. / NASL script (C) 2009 Tenable Network Security, Inc.");
script_category(ACT_GATHER_INFO);
script_family(english: "Ubuntu Local Security Checks");
script_dependencies("ssh_get_info.nasl");
script_require_keys("Host/Ubuntu", "Host/Ubuntu/release", "Host/Debian/dpkg-l");

script_xref(name: "USN", value: "657-1");
script_summary(english:"amarok vulnerability");
script_name(english:"USN657-1 : amarok vulnerability");
script_set_attribute(attribute:'synopsis', value: 'These remote packages are missing security patches :
- amarok 
- amarok-engines 
- amarok-xine 
');
script_set_attribute(attribute:'description', value: 'Dwayne Litzenberger discovered that Amarok created temporary files in
an insecure way. Local users could exploit a race condition to create
or overwrite files with the privileges of the user invoking the
program. (CVE-2008-3699)');
script_set_attribute(attribute:'solution', value: 'Upgrade to : 
- amarok-1.4.9.1-0ubuntu3.1 (Ubuntu 8.04)
- amarok-engines-1.4.9.1-0ubuntu3.1 (Ubuntu 8.04)
- amarok-xine-1.4.9.1-0ubuntu3.1 (Ubuntu 8.04)
');
script_set_attribute(attribute: 'cvss_vector', value: 'CVSS2#AV:L/AC:M/Au:N/C:N/I:P/A:P');
script_end_attributes();

script_cve_id("CVE-2008-3699");
exit(0);
}

include('ubuntu.inc');

if ( ! get_kb_item('Host/Ubuntu/release') ) exit(1, 'Could not gather the list of packages');

extrarep = NULL;

found = ubuntu_check(osver: "8.04", pkgname: "amarok", pkgver: "1.4.9.1-0ubuntu3.1");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package amarok-',found,' is vulnerable in Ubuntu 8.04
Upgrade it to amarok-1.4.9.1-0ubuntu3.1
');
}
found = ubuntu_check(osver: "8.04", pkgname: "amarok-engines", pkgver: "1.4.9.1-0ubuntu3.1");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package amarok-engines-',found,' is vulnerable in Ubuntu 8.04
Upgrade it to amarok-engines-1.4.9.1-0ubuntu3.1
');
}
found = ubuntu_check(osver: "8.04", pkgname: "amarok-xine", pkgver: "1.4.9.1-0ubuntu3.1");
if (! isnull(found)) {
w++;
extrarep = strcat(extrarep, '
The package amarok-xine-',found,' is vulnerable in Ubuntu 8.04
Upgrade it to amarok-xine-1.4.9.1-0ubuntu3.1
');
}

if (w) { security_note(port: 0, extra: extrarep); }
else exit(0, "Host is not vulnerable");
