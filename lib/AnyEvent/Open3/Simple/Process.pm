package AnyEvent::Open3::Simple::Process;

use strict;
use warnings;
use Carp qw( croak );

# ABSTRACT: process run using AnyEvent::Open3::Simple
our $VERSION = '0.76'; # VERSION


sub new
{
  my($class, $pid, $stdin) = @_;
  bless { pid => $pid, stdin => $stdin }, $class;
}


sub pid { shift->{pid} }


sub print
{
  my $stdin = shift->{stdin};
  croak "AnyEvent::Open3::Simple::Process#print is unsupported on this platform"
    if $^O eq 'MSWin32';
  print $stdin @_;
}


sub say
{
  shift->print(@_, "\n");
}


sub close
{
  CORE::close(shift->{stdin});
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

AnyEvent::Open3::Simple::Process - process run using AnyEvent::Open3::Simple

=head1 VERSION

version 0.76

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

=head2 $proc-E<gt>close

Close the subprocess' stdin.

=head1 AUTHOR

author: Graham Ollis <plicease@cpan.org>

contributors:

Stephen R. Scaffidi

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
