#!/usr/bin/perl
use Facebook::Graph;
use Data::Dumper;
use strict;

#my $fb = Facebook::Graph->new;my $perl_page = $fb->fetch(16665510298);
#print %$perl_page;

my $fb_app_id ='685856528092684';
my $fb_app_secret = 'b6cd719c518f494b1967efd4fc65b972';
my $token ='CAACEdEose0cBAPvCObGKuDMgqSR6W3u4DZAveIeUkN7rihqrst0WLQ8gZCBZB11rCZBfJ93xCM0gu5M8MqIZAheBRojBSePmNsPHTq70NhPWhTZB5X6aEPsbrixdNpcqpOpizIkYOSXaRsZBRpEODjdPMrN42L5ZAEKnBpD3mQNlCRlVlIPs8dGB1LNn1Kq2BlrubdF2t3xZCBwZDZD';
my $fb = Facebook::Graph->new(
	app_id => $fb_app_id,
	secret => $fb_app_secret,
	postback => 'http://baidu.com',
);

my $uri = $fb
	->authorize
	->extend_permissions(qw(offline_access push_stream))
	->uri_as_string;

$fb ->access_token($token);
my $user = $fb->fetch('me');
my $friends = $fb->fetch('me/friends');

open (F, ">friends");
print F Dumper($friends); 
close (F,)
while (<F>){
print $_;
};

