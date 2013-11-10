#!/usr/bin/perl
use Facebook::Graph;
use Data::Dumper;
use strict;

#my $fb = Facebook::Graph->new;my $perl_page = $fb->fetch(16665510298);
#print %$perl_page;

my $fb_app_id ='685856528092684';
my $fb_app_secret = 'b6cd719c518f494b1967efd4fc65b972';
#my $token ='CAACEdEose0cBAP1iUkAtoZAlHtMYDZB56MtgTfH2ithW3kQ05PkMncV6fsaDh7xQXstjHOZCaZAklQGvMMOb7GnpCYx4un5tfOUCPEzpTGlvsBn45po84ck4FYdK66YHcIPSopL5XpJinuDnnm3Kdvi0QLVv6bBiWCZAFvfmLF3DcLRS2FohtkeTQuGJVEAOuZCxp5132QUwZDZD';

my $fb = Facebook::Graph->new(

	app_id => $fb_app_id,

	secret => $fb_app_secret,

	postback => 'http://google.com',

);



my $uri = $fb

	->authorize

	->extend_permissions(qw(offline_access push_stream))

	->uri_as_string;


my $q = Plack::Request->new($env);
$fb->request_access_token($q->query_param('code'));

my $user = $fb->fetch('me');

my $friends = $fb->fetch('me/friends');

my $friend = $fb->query->find('me/friends')->select_fields('id', 'name', 'gender', 'hometown', 'location')->request->as_hashref;



#my $friends = $fb->fetch('friends');

open (F, '>fri.txt');
print F Dumper(\$friend);
close (F);
my $ht = 0;
my $lc = 0;
open (F, 'fri.txt');
open (FILE1, '>friend.txt');
open (FILE2, '>location.txt');
open (FILE3, '>hometown.txt');
my $htname;
my $lcname;
my $name;
my $id;
my $gd;
my %location;
my %hometown;
my %gender= (
	"\'male\'"=>0,
	"\'female\'"=>0,
);
while (<F>){
	if (/hometown/){$ht = 1;}
	if (/location/){$lc = 1;}
	if (/name\'\s=>(.*)$/){
		if ($ht){$htname = $1;chop $htname;$ht =0;}
		if ($lc){$lcname = $1;chop $lcname;$lc =0;}
		else {$name = $1;chop $name;}
	}
	if (/id\'\s=>(.*)$/){$id = $1;chop $id;}
	if (/gender\'\s=>\s(.*)$/){$gd =$1;
		if (exists $location{$lcname}){$location{$lcname}+=1;}
		else {$location{$lcname}=1;}
		if (exists $hometown{$htname}){$hometown{$htname}+=1;}
		else {$location{$htname}=1;}
		$gender{$gd}+=1; 
		print FILE1 $name, $gd, $id, $htname, $lcname."\n";
	}
}
for (keys(%location)){print FILE2 $_, $location{$_}."\n";}

for (keys(%hometown)){print FILE3 $_, $hometown{$_}."\n";}

for (keys(%gender)){print $_, $gender{$_}."\n";}
#printf "name:%15s, id:%15s,hometown:%15s, location:%15s", $name, $id, $htname, $lcname;





