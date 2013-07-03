use strict;
use lib "t";
use TestDB;
use Test::More;
use Test::MockObject;
use Test::MockObject::Extends;
use DateTime;
use MoDo::Model;
use MoDo::Model::Todo;

my $config = test_db_config();
my $db = MoDo::Model->new($config);

my $delete_todo = sub {
   $db->do(
       q{ delete from todo where id <> ? },
       undef,
       [0]
   );
};

my $insert_todos = sub {
    my $values_ref = shift;
    $db->bulk_insert('todo', $values_ref);
};

subtest ".find" => sub {
    my $subject = Test::MockObject::Extends->new( 'MoDo::Model::Todo' );
    $subject->set_always('db', $db);
    my $before = sub { $insert_todos->([{ id => 1, title => "hoge" },{ id => 2, title => "hoge" }]) };
    my $after  = $delete_todo;
    subtest "該当データが存在する場合" => sub {
        subtest "指定したwhere条件で検索した結果最初に見つかった結果を返す" => sub {
            $before->();

            my $actual = $subject->find( { title => 'hoge' } );
            ok $actual, "結果がある";
            is $actual->id, 1, "idは１である";

            $after->();
        };
    };
    subtest "該当データが存在しない場合" => sub {
        subtest "undefを返す" => sub {
            my $actual = $subject->find( { id => 1} );
            is $actual, undef;
        };
    };
};

subtest ".where" => sub {
    my $subject = Test::MockObject::Extends->new( 'MoDo::Model::Todo' );
    $subject->set_always('db', $db);
    my $before = sub { $insert_todos->([{ id => 1, title => "hoge" },{ id => 2, title => "hoge" },{ id => 3, title => "foo" }]) };
    my $after  = $delete_todo;
    subtest "該当データがある場合" => sub {
        subtest "Todoの配列を返す" => sub {
            $before->();
            my @actual = $subject->where({ title => 'hoge'});
            is @actual, 2;
            $after->();
        };
    };
    subtest "該当データが無い場合" => sub {
        subtest "空配列を返す" => sub {
            $before->();
            my @actual = $subject->where({ title => 'bar'});
            is @actual, 0;
            $after->();
        };
    };
};

subtest ".all" => sub {
    my $subject = Test::MockObject::Extends->new( 'MoDo::Model::Todo' );
    $subject->set_always('db', $db);
    my $before = sub { $insert_todos->([{ id => 1, title => "hoge" },{ id => 2, title => "hoge" },{ id => 3, title => "foo" }]) };
    my $after  = $delete_todo;
    subtest "全データの配列を返す" => sub {
        $before->();
        my @actual = $subject->all;
        is @actual, 3;
        $after->();
    };
};

subtest "constructor" => sub {
    my $subject = MoDo::Model::Todo->new(title => "hoge", created_at => DateTime->now);
    subtest "idのデフォルト値は-1" => sub {
        is $subject->id, -1, "default id is -1";
    };
};

done_testing();
