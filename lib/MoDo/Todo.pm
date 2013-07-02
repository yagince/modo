package MoDo::Todo;
use Mojo::Base 'Mojolicious::Controller';
use MoDo::Model::Todo;

sub index {
    my $self = shift;
    print "================  Todo\n";
    my $todo = MoDo::Model::Todo->find( { id => 1 } );
    $self->stash( todo => $todo );
    print $todo;
}

1;
