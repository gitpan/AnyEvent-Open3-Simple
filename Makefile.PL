
use strict;
use warnings;

use 5.010000;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "interface to open3 under AnyEvent",
  "AUTHOR" => "Graham Ollis <plicease\@cpan.org>",
  "BUILD_REQUIRES" => {
    "Exporter" => 0,
    "File::Spec" => 0,
    "File::Temp" => 0,
    "Test::More" => 0,
    "base" => 0
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "AnyEvent-Open3-Simple",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "AnyEvent::Open3::Simple",
  "PREREQ_PM" => {
    "AnyEvent" => 0,
    "IPC::Open3" => 0,
    "Scalar::Util" => 0,
    "Symbol" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "VERSION" => "0.6",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



