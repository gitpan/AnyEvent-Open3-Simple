package AnyEvent::Open3::Simple::Process;

use strict;
use warnings;

# ABSTRACT: Process run using AnyEvent::Open3::Simple
our $VERSION = '0.79_02'; # VERSION


sub new
{
  my($class, $pid, $stdin) = @_;
  bless { pid => $pid, stdin => $stdin, user => '' }, $class;
}


sub pid { shift->{pid} }


if($^O eq 'MSWin32')
{
  require Carp;
  *print = sub { Carp::croak("AnyEvent::Open3::Simple::Process#print is unsupported on this platform") };
  *say = sub { Carp::croak("AnyEvent::Open3::Simple::Process#say is unsupported on this platform") };
}
else
{
  *print = sub {
    my $stdin = shift->{stdin};
    print $stdin @_;
  };
  *say = sub {
    my $stdin = shift->{stdin};
    print $stdin @_, "\n";
  };
}


sub close
{
  CORE::close(shift->{stdin});
}


sub user
{
  my($self, $data) = @_;
  $self->{user} = $data if defined $data;
  $self->{user};
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

AnyEvent::Open3::Simple::Process - Process run using AnyEvent::Open3::Simple

=head1 VERSION

version 0.79_02

=head1 DESCRIPTION

This class represents a process being handled by L<AnyEvent::Open3::Simple>.

=head1 ATTRIBUTES

=head2 pid

 my $pid = $proc->pid;

Return the Process ID of the child process.

=head1 METHODS

=head2 print

 $proc->print(@data);

Write to the subprocess' stdin.

Be careful to use either the C<stdin> attribute on the L<AnyEvent::Open::Simple>
object or this C<print> methods for a given instance of L<AnyEvent::Open3::Simple>,
but not both!  Otherwise bad things may happen.

Currently on (non cygwin) Windows (Strawberry, ActiveState) this method is not
supported, so if you need to send (standard) input to the subprocess, use the
C<stdin> attribute on the L<AnyEvent::Open::Simple> constructor.

=head2 say

 $proc->say(@data);

Write to the subprocess' stdin, adding a new line at the end.  This functionality
is unsupported on Microsoft Windows.

Be careful to use either the C<stdin> attribute on the L<AnyEvent::Open::Simple>
object or this C<say> methods for a given instance of L<AnyEvent::Open3::Simple>,
but not both!  Otherwise bad things may happen.

Currently on (non cygwin) Windows (Strawberry, ActiveState) this method is not
supported, so if you need to send (standard) input to the subprocess, use the
C<stdin> attribute on the L<AnyEvent::Open::Simple> constructor.

=head2 close

 $proc->close

Close the subprocess' stdin.

=head2 user

Version 0.77

 $proc->user($user_data);
 my $user_data = $proc->user;

Get or set user defined data tied to the process object.  Any
Perl data structure may be used.  Useful for persisting data 
between callbacks, for example:

 AnyEvent::Open3::Simple->new(
   on_start => sub {
     my($proc) = @_;
     $proc->user({ message => 'hello there' });
   },
   on_stdout => sub {
     my($proc) = @_;
     say $proc->user->{message};
   },
 );

=head1 AUTHOR

author: Graham Ollis <plicease@cpan.org>

contributors:

Stephen R. Scaffidi

Scott Wiersdorf

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
