package MoDo::Model::Todo;
use Mouse;

has 'id' => (
    is => 'ro',
    isa => 'Int',
    default => sub { -1 },
);

has 'title' => (
    is => "rw",
    isa => "Str",
    default => q(),
    required => 1,
);

has 'created_at' => (
    is => "ro",
    isa => "DateTime",
    required => 1,
);

use MoDo::Model;
sub find {
    my ($class, $query_ref) = @_;
    my $result = MoDo::Model->new->single('todo', $query_ref);
    return unless $result;
    MoDo::Model::Todo->new(id => $result->id, title => $result->title, created_at => $result->created_at);
}

1;
