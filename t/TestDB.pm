package TestDB;
use parent qw(Exporter);
our @EXPORT = qw(test_db_config);

sub test_db_config {
    print "called\n";
    return {
        dsn => "dbi:mysql:modo-test",
        username => 'root',
        password => 'password',
    };
}

1;
