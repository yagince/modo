package MoDo;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');

  # Router
  my $r = $self->routes;

  # Normal route to controller
  my $logged_in = $r->under(
      sub {
          my $self = shift;
          return $self->session('user') || !$self->redirect_to('login_index');
      }
  );
  $logged_in->get('/')->to('example#welcome')->name('index');
  $r->get('/login-index')->to('login#index')->name('login_index');
  $r->post('/login')->to('login#login');
  $r->delete('/logout')->to('login#logout');
}

1;
