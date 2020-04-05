#!/usr/bin/perl

use strict;
use warnings;
use Getopt::Long;
use feature qw (say);
use Time::HiRes qw (time);

sub getFileContent {
    open INPUT, $_[0];
    my $input = "";

    while (my $line = <INPUT>) {
        $input .= $line;
    }

    close INPUT;

    return $input;
};

my $fixedInput = 0;
my $fixedArgument = 0;
my $help = 0;
my $program = "";
my $argumentFile = "";
my $inputDirectory = "";

GetOptions(
    'a'                   => \$fixedArgument,
    'fixed-argument'      => \$fixedArgument,
    'i'                   => \$fixedInput,
    'fixed-input'         => \$fixedInput,
    'p=s'                 => \$program,
    'program=s'           => \$program,
    'f=s'                 => \$argumentFile,
    '--argument-file=s'   => \$argumentFile,
    'd=s'                 => \$inputDirectory,
    '--input-directory=s' => \$inputDirectory,
    'h'                   => \$help,
    'help'                => \$help
) or die 'Error in argument parsing';

if ($help) {
    say "Tester";
    say "Usage: tester [OPTIONS]";
    say "    -a, --fixed-argument    always use first line of arguments.txt as argument";
    say "    -i, --fixed-input       always use input/0.txt as input";
    say "    -p, --program           set program name";
    say "    -f, --argument-file     set argument file path";
    say "    -d, --input-directory   set input files directory path";
    say "    -h, --help              display this page";
    say "Exit status:";
    say "    0: OK";
    say "    1: arguments.txt not found";
    say "    2: input directory not found";
    say "    3: program not specified";
    say "    4: argument file not specified";
    say "    5: input directory not specified";
    say "    6: --fixed-argument and --fixed-input used at same time";

    exit 0;
}

if (not $program) {
    say STDERR "Program not specified";

    exit 3;
}

if (not $argumentFile) {
    say STDERR "Argument file not specified";

    exit 4;
}

if (not $inputDirectory) {
    say STDERR "Input files directory not specified";

    exit 5;
}

if (not -e $argumentFile) {
    say STDERR "Argument file not found";

    exit 1;
}

if ($fixedArgument and $fixedInput) {
    say STDERR "--fixed-argument and --fixed-input used at same time";

    exit 6;
}

my $doInputDirectoryExist = 1;

opendir my $directory, "input" or $doInputDirectoryExist = 0;
if (not $doInputDirectoryExist) {
    say STDERR "Cannot open directory 'input/'";
    exit 2;
}
my @inputFiles = readdir $directory;
@inputFiles = grep {$_ ne '.' and $_ ne '..'} @inputFiles;
@inputFiles = sort {$a =~ /^\d+/ <=> $b =~ /^\d+/} @inputFiles;

closedir $directory;

my $input = $inputFiles[0];
my $argument;

open ARGUMENT, $argumentFile;
$argument = <ARGUMENT>;
chomp $argument;

say "\n";

my $i = 0;
do {
    say "-----TESTCASE-".($i + 1)."-----\n";

    my $start = Time::HiRes::gettimeofday();
    system "$program $argument < $inputDirectory/$input";
    my $end = Time::HiRes::gettimeofday();
    print "\n\n";

    say "==== ", int(($end - $start) * 1000), "ms spent ====\n";

    $i++;
} while (($fixedArgument or (defined($argument = <ARGUMENT>) and chomp $argument)) and ($fixedInput or $input = $inputFiles[$i]));

close ARGUMENT;

say "----TESTCASE-END----\n";
