
#
# (C) Tenable Network Security, Inc.
#
# This plugin text was extracted from Fedora Security Advisory 2008-0282
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);
if(description)
{
 script_id(29862);
 script_version ("$Revision: 1.3 $");
script_name(english: "Fedora 7 2008-0282: mantis");
 script_set_attribute(attribute: "synopsis", value: 
"The remote host is missing the patch for the advisory FEDORA-2008-0282 (mantis)");
 script_set_attribute(attribute: "description", value: "Mantis is a web-based bugtracking system.
It is written in the PHP scripting language and requires the MySQL
database and a webserver. Mantis has been installed on Windows, MacOS,
OS/2, and a variety of Unix operating systems. Any web browser should
be able to function as a client.

Documentation can be found in: /usr/share/doc/mantis-1.1.0

When the package has finished installing, you will need to perform some
additional configuration steps; these are described in:
/usr/share/doc/mantis-1.1.0/README.Fedora

-
Update Information:

Please note this is a major mantis release, and a upgrade to the DB schema is n
eeded.

Please refer to the package documentation to complete the upgrade.
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:N/I:P/A:N");
script_set_attribute(attribute: "solution", value: "Get the newest Fedora Updates");
script_end_attributes();

 script_cve_id("CVE-2007-6611");
script_summary(english: "Check for the version of the mantis package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security, Inc.");
 script_family(english: "Fedora Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/RedHat/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( rpm_check( reference:"mantis-1.1.0-1.fc7", release:"FC7") )
{
 security_warning(port:0, extra:rpm_report_get());
 exit(0);
}
exit(0, "Host is not affected");
