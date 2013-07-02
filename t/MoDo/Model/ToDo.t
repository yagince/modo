use Test::More;
use DateTime;
use MoDo::Model::Todo;

my $todo = MoDo::Model::Todo->new(title => "hoge", created_at => DateTime->now);
is($todo->id, -1);

done_testing();
