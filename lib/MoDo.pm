package MoDo;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');

  # Router
  my $r = $self->routes;

  my $logged_in = $r->under(
      sub {
          my $self = shift;
          return $self->session('user') || !$self->redirect_to('login');
      }
  );
  $logged_in->get('/')->to('example#welcome')->name('index');
  $r->get('/login')->to('login#index')->name('login');
  $r->post('/login')->to('login#login')->name('login_post');
  $r->delete('/logout')->to('login#logout')->name('logout');

  $self->hook(
      before_dispatch => sub {
          my $c = shift;
          my $_method = $c->req->param('_method');
          if($c->req->method eq 'POST' && $_method) {
              my $methods = [qw/GET POST PUT DELETE/];
              if ( grep { $_ eq uc $_method } @$methods ) {
                  $c->req->method( $_method );
              }
          }
      }
  );

  $self->helper(
      model => sub {
          my ($self, $name) = @_;
          Modo::Model->new->load($name);
      }
  );

}

1;
