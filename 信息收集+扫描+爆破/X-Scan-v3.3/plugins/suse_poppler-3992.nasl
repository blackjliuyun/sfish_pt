
#
# (C) Tenable Network Security
#
# The text description of this plugin is (C) Novell, Inc.
#

include("compat.inc");

if ( ! defined_func("bn_random") ) exit(0);

if(description)
{
 script_id(29554);
 script_version ("$Revision: 1.8 $");
 script_name(english: "SuSE Security Update:  Security update for poppler,poppler-devel (poppler-3992)");
 script_set_attribute(attribute: "synopsis", value: 
"The remote SuSE system is missing the security patch poppler-3992");
 script_set_attribute(attribute: "description", value: "A buffer overflow in the xpdf code contained in poppler
could be exploited by attackers to potentially execute
arbitrary code (CVE-2007-3387).
");
 script_set_attribute(attribute: "cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:P/I:P/A:P");
script_set_attribute(attribute: "solution", value: "Install the security patch poppler-3992");
script_end_attributes();

script_cve_id("CVE-2007-3387");
script_summary(english: "Check for the poppler-3992 package");
 
 script_category(ACT_GATHER_INFO);
 
 script_copyright(english:"This script is Copyright (C) 2009 Tenable Network Security");
 script_family(english: "SuSE Local Security Checks");
 script_dependencies("ssh_get_info.nasl");
 script_require_keys("Host/SuSE/rpm-list");
 exit(0);
}

include("rpm.inc");

if ( ! get_kb_item("Host/SuSE/rpm-list") ) exit(1, "Could not gather the list of packages");

if ( rpm_check( reference:"poppler-0.4.4-19.12", release:"SLES10") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"poppler-0.4.4-19.12", release:"SLED10") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
if ( rpm_check( reference:"poppler-devel-0.4.4-19.12", release:"SLED10") )
{
	security_warning(port:0, extra:rpm_report_get());
	exit(0);
}
# END OF TEST
exit(0,"Host is not affected");
