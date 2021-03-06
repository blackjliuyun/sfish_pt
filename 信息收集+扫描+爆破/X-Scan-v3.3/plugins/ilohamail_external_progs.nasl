#
# This script was written by George A. Theall, <theall@tifaware.com>.
#
# See the Nessus Scripts License for details.
#


include("compat.inc");

if (description) {
  script_id(14635);
  script_xref(name:"OSVDB", value:"7332");
  script_xref(name:"OSVDB", value:"7333");
  script_version("$Revision: 1.4 $");

# script_cve_id("CVE-MAP-NOMATCH");
# NOTE: no CVE id assigned (gat, 09/2004)
 
  script_name(english:"IlohaMail Multiple External Programs Arbitrary Command Execution");
 
 script_set_attribute(attribute:"synopsis", value:
"The remote hsot is running a webmail application that is affected by 
a remote command execution vulnerability.");
 script_set_attribute(attribute:"description", value:
"The target is running at least one instance of IlohaMail version
0.8.6.  This version may contain flaws in the spell check and GnuPG
features that allow an authenticated attacker to run arbitrary
commands with the privileges of the web user simply by enclosing them
in backticks when spell checking or sending a message. 

***** Nessus has determined the vulnerability exists on the target
***** simply by looking at the version number of IlohaMail 
***** installed there." );
 script_set_attribute(attribute:"see_also", value:"http://www.nessus.org/u?066bde18" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to IlohaMail version 0.8.7 or later or disable
spell check and GPG features (see conf/conf.inc)." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );

script_end_attributes();

 
  summary["english"] = "Checks for External Programs vulnerabilities in IlohaMail";
  script_summary(english:summary["english"]);
 
  script_category(ACT_GATHER_INFO);
  script_copyright(english:"This script is Copyright (C) 2004-2009 George A. Theall");

  family["english"] = "CGI abuses";
  script_family(english:family["english"]);

  script_dependencie("global_settings.nasl", "ilohamail_detect.nasl");
  script_require_ports("Services/www", 80);

  exit(0);
}

include("global_settings.inc");
include("http_func.inc");

host = get_host_name();
port = get_http_port(default:80);
if (debug_level) display("debug: searching for IlohaMail External Programs vulnerabilities on ", host, ":", port, ".\n");

if (!get_port_state(port)) exit(0);

# Check each installed instance, stopping if we find a vulnerable version.
installs = get_kb_list(string("www/", port, "/ilohamail"));
if (isnull(installs)) exit(0);
foreach install (installs) {
  matches = eregmatch(string:install, pattern:"^(.+) under (/.*)$");
  if (!isnull(matches)) {
    ver = matches[1];
    dir = matches[2];
    if (debug_level) display("debug: checking version ", ver, " under ", dir, ".\n");

   if (ver =~ "^0\.8\.6") {
      security_hole(port);
      exit(0);
    }
  }
}
