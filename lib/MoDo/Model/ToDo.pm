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
# class methods
sub all {
    my ($class) = @_;
    map { $class->to_todo($_) } $class->db->search('todo');
}
sub find {
    my ($class, $query_ref) = @_;
    my $result = $class->db->single('todo', $query_ref);
    return unless $result;
    $class->to_todo($result);
}
sub where {
    my ($class, $query_ref) = @_;
    map { $class->to_todo($_) } $class->db->search('todo', $query_ref);
}
sub to_todo {
    my ($class, $hash_ref) = @_;
    MoDo::Model::Todo->new(id => $hash_ref->id, title => $hash_ref->title, created_at => $hash_ref->created_at);
}
sub db {
    MoDo::Model->new
}

1;
