#!/usr/bin/perl

use strict;
use warnings;
use Getopt::Long;
use feature qw (say);
use Time::HiRes qw (time);

my @errorCodes = (
    [
        'Success',
        'Success'
    ],
    [
        'EPERM',
        'Operation not permitted'
    ],
    [
        'ENOENT',
        'No such file or directory'
    ],
    [
        'ESRCH',
        'No such process'
    ],
    [
        'EINTR',
        'Interrupted system call'
    ],
    [
        'EIO',
        'I/O error'
    ],
    [
        'ENXIO',
        'No such device or address'
    ],
    [
        'E2BIG',
        'Argument list too long'
    ],
    [
        'ENOEXEC',
        'Exec format error'
    ],
    [
        'EBADF',
        'Bad file number'
    ],
    [
        'ECHILD',
        'No child processes'
    ],
    [
        'EAGAIN',
        'Try again'
    ],
    [
        'ENOMEM',
        'Out of memory'
    ],
    [
        'EACCES',
        'Permission denied'
    ],
    [
        'EFAULT',
        'Bad address'
    ],
    [
        'ENOTBLK',
        'Block device required'
    ],
    [
        'EBUSY',
        'Device or resource busy'
    ],
    [
        'EEXIST',
        'File exists'
    ],
    [
        'EXDEV',
        'Cross-device link'
    ],
    [
        'ENODEV',
        'No such device'
    ],
    [
        'ENOTDIR',
        'Not a directory'
    ],
    [
        'EISDIR',
        'Is a directory'
    ],
    [
        'EINVAL',
        'Invalid argument'
    ],
    [
        'ENFILE',
        'File table overflow'
    ],
    [
        'EMFILE',
        'Too many open files'
    ],
    [
        'ENOTTY',
        'Not a typewriter'
    ],
    [
        'ETXTBSY',
        'Text file busy'
    ],
    [
        'EFBIG',
        'File too large'
    ],
    [
        'ENOSPC',
        'No space left on device'
    ],
    [
        'ESPIPE',
        'Illegal seek'
    ],
    [
        'EROFS',
        'Read-only file system'
    ],
    [
        'EMLINK',
        'Too many links'
    ],
    [
        'EPIPE',
        'Broken pipe'
    ],
    [
        'EDOM',
        'Math argument out of domain of func'
    ],
    [
        'ERANGE',
        'Math result not representable'
    ],
    [
        'EDEADLK',
        'Resource deadlock would occur'
    ],
    [
        'ENAMETOOLONG',
        'File name too long'
    ],
    [
        'ENOLCK',
        'No record locks available'
    ],
    [
        'ENOSYS',
        'Function not implemented'
    ],
    [
        'ENOTEMPTY',
        'Directory not empty'
    ],
    [
        'ELOOP',
        'Too many symbolic links encountered'
    ],
    [
        'ENOMSG',
        'No message of desired type'
    ],
    [
        'EIDRM',
        'Identifier removed'
    ],
    [
        'ECHRNG',
        'Channel number out of range'
    ],
    [
        'EL2NSYNC',
        'Level 2 not synchronized'
    ],
    [
        'EL3HLT',
        'Level 3 halted'
    ],
    [
        'EL3RST',
        'Level 3 reset'
    ],
    [
        'ELNRNG',
        'Link number out of range'
    ],
    [
        'EUNATCH',
        'Protocol driver not attached'
    ],
    [
        'ENOCSI',
        'No CSI structure available'
    ],
    [
        'EL2HLT',
        'Level 2 halted'
    ],
    [
        'EBADE',
        'Invalid exchange'
    ],
    [
        'EBADR',
        'Invalid request descriptor'
    ],
    [
        'EXFULL',
        'Exchange full'
    ],
    [
        'ENOANO',
        'No anode'
    ],
    [
        'EBADRQC',
        'Invalid request code'
    ],
    [
        'EBADSLT',
        'Invalid slot'
    ],
    [
        'EBFONT',
        'Bad font file format'
    ],
    [
        'ENOSTR',
        'Device not a stream'
    ],
    [
        'ENODATA',
        'No data available'
    ],
    [
        'ETIME',
        'Timer expired'
    ],
    [
        'ENOSR',
        'Out of streams resources'
    ],
    [
        'ENONET',
        'Machine is not on the network'
    ],
    [
        'ENOPKG',
        'Package not installed'
    ],
    [
        'EREMOTE',
        'Object is remote'
    ],
    [
        'ENOLINK',
        'Link has been severed'
    ],
    [
        'EADV',
        'Advertise error'
    ],
    [
        'ESRMNT',
        'Srmount error'
    ],
    [
        'ECOMM',
        'Communication error on send'
    ],
    [
        'EPROTO',
        'Protocol error'
    ],
    [
        'EMULTIHOP',
        'Multihop attempted'
    ],
    [
        'EDOTDOT',
        'RFS specific error'
    ],
    [
        'EBADMSG',
        'Not a data message'
    ],
    [
        'EOVERFLOW',
        'Value too large for defined data type'
    ],
    [
        'ENOTUNIQ',
        'Name not unique on network'
    ],
    [
        'EBADFD',
        'File descriptor in bad state'
    ],
    [
        'EREMCHG',
        'Remote address changed'
    ],
    [
        'ELIBACC',
        'Can not access a needed shared library'
    ],
    [
        'ELIBBAD',
        'Accessing a corrupted shared library'
    ],
    [
        'ELIBSCN',
        '.lib section in a.out corrupted'
    ],
    [
        'ELIBMAX',
        'Attempting to link in too many shared libraries'
    ],
    [
        'ELIBEXEC',
        'Cannot exec a shared library directly'
    ],
    [
        'EILSEQ',
        'Illegal byte sequence'
    ],
    [
        'ERESTART',
        'Interrupted system call should be restarted'
    ],
    [
        'ESTRPIPE',
        'Streams pipe error'
    ],
    [
        'EUSERS',
        'Too many users'
    ],
    [
        'ENOTSOCK',
        'Socket operation on non-socket'
    ],
    [
        'EDESTADDRREQ',
        'Destination address required'
    ],
    [
        'EMSGSIZE',
        'Message too long'
    ],
    [
        'EPROTOTYPE',
        'Protocol wrong type for socket'
    ],
    [
        'ENOPROTOOPT',
        'Protocol not available'
    ],
    [
        'EPROTONOSUPPORT',
        'Protocol not supported'
    ],
    [
        'ESOCKTNOSUPPORT',
        'Socket type not supported'
    ],
    [
        'EOPNOTSUPP',
        'Operation not supported on transport endpoint'
    ],
    [
        'EPFNOSUPPORT',
        'Protocol family not supported'
    ],
    [
        'EAFNOSUPPORT',
        'Address family not supported by protocol'
    ],
    [
        'EADDRINUSE',
        'Address already in use'
    ],
    [
        'EADDRNOTAVAIL',
        'Cannot assign requested address'
    ],
    [
        'ENETDOWN',
        'Network is down'
    ],
    [
        'ENETUNREACH',
        'Network is unreachable'
    ],
    [
        'ENETRESET',
        'Network dropped connection because of reset'
    ],
    [
        'ECONNABORTED',
        'Software caused connection abort'
    ],
    [
        'ECONNRESET',
        'Connection reset by peer'
    ],
    [
        'ENOBUFS',
        'No buffer space available'
    ],
    [
        'EISCONN',
        'Transport endpoint is already connected'
    ],
    [
        'ENOTCONN',
        'Transport endpoint is not connected'
    ],
    [
        'ESHUTDOWN',
        'Cannot send after transport endpoint shutdown'
    ],
    [
        'ETOOMANYREFS',
        'Too many references: cannot splice'
    ],
    [
        'ETIMEDOUT',
        'Connection timed out'
    ],
    [
        'ECONNREFUSED',
        'Connection refused'
    ],
    [
        'EHOSTDOWN',
        'Host is down'
    ],
    [
        'EHOSTUNREACH',
        'No route to host'
    ],
    [
        'EALREADY',
        'Operation already in progress'
    ],
    [
        'EINPROGRESS',
        'Operation now in progress'
    ],
    [
        'ESTALE',
        'Stale NFS file handle'
    ],
    [
        'EUCLEAN',
        'Structure needs cleaning'
    ],
    [
        'ENOTNAM',
        'Not a XENIX named type file'
    ],
    [
        'ENAVAIL',
        'No XENIX semaphores available'
    ],
    [
        'EISNAM',
        'Is a named type file'
    ],
    [
        'EREMOTEIO',
        'Remote I/O error'
    ],
    [
        'EDQUOT',
        'Quota exceeded'
    ],
    [
        'ENOMEDIUM',
        'No medium found'
    ],
    [
        'EMEDIUMTYPE',
        'Wrong medium type'
    ],
    [
        'ECANCELED',
        'Operation Canceled'
    ],
    [
        'ENOKEY',
        'Required key not available'
    ],
    [
        'EKEYEXPIRED',
        'Key has expired'
    ],
    [
        'EKEYREVOKED',
        'Key has been revoked'
    ],
    [
        'EKEYREJECTED',
        'Key was rejected by service'
    ],
    [
        'EOWNERDEAD',
        'Owner died'
    ],
    [
        'ENOTRECOVERABLE',
        'State not recoverable'
    ]
);

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
    say "----- TESTCASE ".($i + 1)." -----\n";

    my $start = Time::HiRes::gettimeofday();
    system "$program $argument < $inputDirectory/$input";
    my $exitCode = $? >> 8;
    my $end = Time::HiRes::gettimeofday();
    print "\n\n";

    say "==== ", int(($end - $start) * 1000), "ms ====";
    say "~~~~ $exitCode: $errorCodes[$exitCode]->[0]  $errorCodes[$exitCode]->[1] ~~~~\n\n";

    $i++;
} while (($fixedArgument or (defined($argument = <ARGUMENT>) and chomp $argument)) and ($fixedInput or $input = $inputFiles[$i]));

close ARGUMENT;

say "---- TESTCASE END ----\n";
