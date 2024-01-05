#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use LWP::Simple;  # Make sure to have LWP::Simple installed

# Create a CGI object
my $cgi = CGI->new;
my $url = "https://www.datosabiertos.gob.pe/sites/default/files/Programas de Universidades.csv";
# Print Content-Type header
print $cgi->header('text/html');

# Retrieve the file URL from the form submission
my $file_url = $cgi->param('nomUni');
my $file_url = $cgi->param('periodo');
my $file_url = $cgi->param('depar');
my $file_url = $cgi->param('programa');
my @lines = ();

# Validate the file URL (add more validation if needed)
if ($file_url =~ /^https?:\/\/\S+$/) {
    # Use LWP::Simple to fetch the file content
    my $file_content = get($file_url);

    if (defined $file_content) {
        # Split the content into lines
        @lines = split /\n/, $file_content;
    } else {
        print "Failed to fetch file. Check the URL and try again.";
    }
} else {
    print "Invalid file URL. Please enter a valid URL.";
}
