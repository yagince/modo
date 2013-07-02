use strict;
use FindBin;
use lib "$FindBin::Bin/lib";
use Mojo::Server::PSGI;
use Plack::Builder;
use MoDo;

my $psgi = Mojo::Server::PSGI->new(app => MoDo->new);

builder {
    enable "Runtime";
    $psgi->to_psgi_app;
}
