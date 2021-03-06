#
# (C) Tenable Network Security, Inc.
#



include("compat.inc");

if (description)
{
  script_id(24761);
  script_version("$Revision: 1.12 $");

  script_cve_id("CVE-2006-4965", "CVE-2007-0059", "CVE-2007-0711", "CVE-2007-0712", "CVE-2007-0713",
                "CVE-2007-0714", "CVE-2007-0715", "CVE-2007-0716", "CVE-2007-0717", "CVE-2007-0718");
  script_bugtraq_id(20138, 22827, 22839, 22843, 22844);
  script_xref(name:"OSVDB", value:"29064");
  script_xref(name:"OSVDB", value:"33898");
  script_xref(name:"OSVDB", value:"33899");
  script_xref(name:"OSVDB", value:"33900");
  script_xref(name:"OSVDB", value:"33901");
  script_xref(name:"OSVDB", value:"33902");
  script_xref(name:"OSVDB", value:"33903");
  script_xref(name:"OSVDB", value:"33904");
  script_xref(name:"OSVDB", value:"33905");

  script_name(english:"QuickTime < 7.1.5 Multiple Vulnerabilities (Windows)");
  script_summary(english:"Checks version of QuickTime on Windows");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote Windows host contains an application that is prone to
multiple attacks." );
 script_set_attribute(attribute:"description", value:
"According to its version, the installation of QuickTime on the remote
Windows host is affected by multiple buffer overflows.  An attacker
may be able to leverage these issues to crash the affected application
or to execute arbitrary code on the remote host by sending a
specially-crafted file to a victim and having him open it using
QuickTime." );
 script_set_attribute(attribute:"see_also", value:"http://docs.info.apple.com/article.html?artnum=305149" );
 script_set_attribute(attribute:"see_also", value:"http://lists.apple.com/archives/Security-announce/2007/Mar/msg00000.html" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to QuickTime version 7.1.5 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C" );

script_end_attributes();

  script_category(ACT_GATHER_INFO);
  script_family(english:"Windows");
  script_copyright(english:"This script is Copyright (C) 2007-2009 Tenable Network Security, Inc.");
  script_dependencies("quicktime_installed.nasl");
  script_require_keys("SMB/QuickTime/Version");
  exit(0);
}


ver = get_kb_item("SMB/QuickTime/Version");
if (
  ver && 
  ver =~ "^([0-6]\.|7\.(0\.|1\.[0-4]([^0-9]|$)))"
) security_hole(get_kb_item("SMB/transport"));
