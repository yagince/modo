package MoDo::Login;
use Mojo::Base 'Mojolicious::Controller';

sub index {
    my $self = shift;
    $self->render;
}

sub login {
    my $self = shift;
    my $id = $self->param('id');
    my $pwd = $self->param('pass');

    if ($id eq "hoge" && $pwd eq "pass") {
        $self->session(user => $id);
        return $self->redirect_to('index');
    }
    $self->redirect_to('login-index');
}

sub logout {
    my $self = shift;
    $self->session(expires => 1);
    $self->redirect_to('login');
}

1;
