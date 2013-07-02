package MoDo::Model::Schema;
use strict;
use warnings;

use DBIx::Skinny::Schema;
use DateTime;
use DateTime::Format::Strptime;
use DateTime::Format::MySQL;
use DateTime::TimeZone;

my $timezone = DateTime::TimeZone->new(name => 'Asia/Tokyo');
install_inflate_rule '^.+_at$' => callback {
    inflate {
        my $value = shift;
        my $dt = DateTime::Format::Strptime->new(
            pattern   => '%Y-%m-%d %H:%M:%S',
            time_zone => $timezone,
        )->parse_datetime($value);
        return DateTime->from_object( object => $dt );
    };
    deflate {
        my $value = shift;
        return DateTime::Format::MySQL->format_datetime($value);
    };
};

install_table 'todo' => schema {
    pk 'id';
    columns qw(id title created_at);
};

1;

__DATA__;
DROP TABLE if EXISTS 'todo';
CREATE TABLE todo (
  id INT(11) NOT NULL AUTO_INCREMENT,
  title TEXT,
  created_at TIMESTAMP NOT NULL,
  PRIMARY KEY(id)
);

