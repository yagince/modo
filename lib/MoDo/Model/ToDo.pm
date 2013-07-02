package MoDo::Model::ToDo;
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

1;
