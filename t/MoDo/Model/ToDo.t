use Test::More;
use DateTime;
use MoDo::Model::ToDo;

my $todo = MoDo::Model::ToDo->new(title => "hoge", created_at => DateTime->now);
is($todo->id, -1);

done_testing();
