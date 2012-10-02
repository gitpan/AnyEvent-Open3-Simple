package AnyEvent::Open3::Simple::Process;

use strict;
use warnings;
use v5.10;

# ABSTRACT: process run using AnyEvent::Open3::Simple
# VERSION


sub new
{
  my($class, $pid, $stdin) = @_;
  bless { pid => $pid, stdin => $stdin }, $class;
}


sub pid { shift->{pid} }


sub print
{
  shift->{stdin}->print(@_);
}


sub say
{
  shift->print(@_, "\n");
}


sub close
{
  shift->{stdin}->close;
}

1;

__END__
=pod

=head1 NAME

AnyEvent::Open3::Simple::Process - process run using AnyEvent::Open3::Simple

=head1 VERSION

version 0.1

=head1 DESCRIPTION

This class represents a process being handled by L<AnyEvent::Open3::Simple>.

=head1 METHODS

=head2 $proc-E<gt>pid

Return the Process ID of the child process.

=head2 $proc-E<gt>print( @data )

Write to the subprocess' stdin.

=head2 $proc-E<gt>say( @data )

Write to the subprocess' stdin, adding a new line at the end.

=head2 $proc-E<gt>close

Close the subprocess' stdin.

=head1 AUTHOR

Graham Ollis <plicease@wdlabs.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

