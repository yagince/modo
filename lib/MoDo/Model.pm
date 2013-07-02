package MoDo::Model;
use strict;
use warnings;

use DBIx::Skinny connect_info => +{
    dsn => 'dbi:mysql:modo',
    username => 'root',
    password => 'password',
};

1;

