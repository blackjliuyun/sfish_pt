#
#  (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description)
{
  script_id(25524);
  script_version("$Revision: 1.6 $");

  script_cve_id("CVE-2007-2923");
  script_bugtraq_id(24493);
  script_xref(name:"OSVDB", value:"37318");

  script_name(english:"Novell exteNd Director LocalExec ActiveX (LocalExec.ocx) launch() Method Arbitrary Command Execution");
  script_summary(english:"Checks versions of LocalExec ActiveX control"); 
 
 script_set_attribute(attribute:"synopsis", value:
"The remote Windows host has an ActiveX control that allows execution
of arbitrary commands." );
 script_set_attribute(attribute:"description", value:
"The remote host contains the LocalExec ActiveX control from Novell
exteND Director, a set of development tools for creating enterprise
web applications. 

The version of this control on the remote host reportedly contains a
method named 'launch()' that can be used to execute arbitrary
commands.  If an attacker can trick a user on the affected host into
visiting a specially-crafted web page, he may be able to leverage
these issues to execute arbitrary code on the host subject to the
user's privileges." );
 script_set_attribute(attribute:"see_also", value:"http://www.kb.cert.org/vuls/id/793433" );
 script_set_attribute(attribute:"see_also", value:"http://www.nessus.org/u?adc5b43f" );
 script_set_attribute(attribute:"solution", value:
"Disable the use of this ActiveX control from within Internet Explorer
by setting its 'kill' bit." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:M/Au:N/C:C/I:C/A:C" );


script_end_attributes();

 
  script_category(ACT_GATHER_INFO);
  script_family(english:"Windows");

  script_copyright(english:"This script is Copyright (C) 2007-2009 Tenable Network Security, Inc.");

  script_dependencies("smb_hotfixes.nasl");
  script_require_keys("SMB/Registry/Enumerated");
  script_require_ports(139, 445);

  exit(0);
}


include("global_settings.inc");
include("smb_func.inc");
include("smb_activex_func.inc");


if (!get_kb_item("SMB/Registry/Enumerated")) exit(0);


# Locate files used by the controls.
if (activex_init() != ACX_OK) exit(0);

clsid = "{2B1AA38D-2D12-11D5-AAD0-00C04FA03D78}";
file = activex_get_filename(clsid:clsid);
if (file)
{
  report = NULL;
  if (report_paranoia > 1)
    report = string(
      "According to the registry, the vulnerable control is installed as :\n",
      "\n",
      "  ", file, "\n",
      "\n",
      "Note, though, that Nessus did not check whether the 'kill' bit was\n",
      "set for the control's CLSID because of the Report Paranoia setting\n",
      "in effect when this scan was run.\n"
    );
  else if (activex_get_killbit(clsid:clsid) != TRUE)
    report = string(
      "According to the registry, the vulnerable control is installed as :\n",
      "\n",
      "  ", file, "\n",
      "\n",
      "Moreover, its 'kill' bit is not set so it is accessible via\n",
      "Internet Explorer."
    );
  if (report) security_hole(port:kb_smb_transport(), extra:report);
}
activex_end();
