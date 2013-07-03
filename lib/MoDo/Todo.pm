package MoDo::Todo;
use Mojo::Base 'Mojolicious::Controller';
use MoDo::Model::Todo;

sub index {
    my $self = shift;
    my @todos = MoDo::Model::Todo->all;
    $self->stash( todos => \@todos );
}

1;
