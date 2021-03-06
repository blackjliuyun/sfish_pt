#
# (C) Tenable Network Security, Inc.
#


include("compat.inc");

if (description)
{
 script_id(11387);
 script_version ("$Revision: 1.8 $");

 script_name(english:"L2TP Network Server Detection");

 script_set_attribute(attribute:"synopsis", value:
"A VPN service is listening on this port." );
 script_set_attribute(attribute:"description", value:
"The report host understands the L2TP tunneling protocol and appears to
be a VPN endpoint, or more specifically, an L2TP Network Server." );
 script_set_attribute(attribute:"see_also", value:"http://en.wikipedia.org/wiki/L2TP" );
 script_set_attribute(attribute:"risk_factor", value:"None" );
 script_set_attribute(attribute:"solution", value:"n/a" );

script_end_attributes();

 script_summary(english:"Determine if a remote host is running a L2TP (VPN) service");
 script_category(ACT_GATHER_INFO);
 script_family(english:"Firewalls");
 script_copyright(english:"This script is Copyright (C) 2003-2009 Tenable Network Security, Inc.");
 exit(0);
}



req = raw_string(0xC8, 2, 0, 76, 0, 0, 0, 0,0,0,0,0,
		 0x80, 8, 0,0,0,0,0,1,
		 0x80, 8, 0,0,0,2,1,0,
		 0x80, 10,0,0,0,3,0,0,0,3,
		 0x80, 10,0,0,0,4,0,0,0,0,
		 0x80, 12,0,0,0,7) + "nessus" +
      raw_string(0x80, 8, 0,0,0,8,42,42,
                 0x80, 8, 0,0,0,10,0,4);
		 
soc = open_sock_udp(1701);
if ( ! soc ) exit(0);
send(socket:soc, data:req);
r = recv(socket:soc, length:1024);
if(!r)exit(0);
close(soc);
if((ord(r[1]) & 0x0F) == 0x02){
	set_kb_item(name:"Services/udp/l2tp", value:1701);
	security_note(port:1701, proto:"udp");
	}
