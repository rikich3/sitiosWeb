#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use LWP::Simple;

my $cgi = CGI->new;
my $url = "https://www.datosabiertos.gob.pe/sites/default/files/Programas de Universidades.csv";
print $cgi->header('text/html');

my $kind = $cgi->param('category');
my $keyword = $cgi->param('searchTerm');
my @lines = ();

if ($file_url =~ /^https?:\/\/\S+$/) {
    my $file_content = get($file_url);
    if (defined $file_content) {
        @lines = split /\n/, $file_content;
    } else {
        print "Failed to fetch file. Check the URL and try again.";
    }
} else {
    print "Invalid file URL. Please enter a valid URL.";
}
if(!($kind eq "") && !($keyword eq "")){
  #open(IN,"../data/data.txt") or die "<h1>ERROR: open file</h1>\n";
  #esta comentado esta ultima linea debido a que el archivo se esta extrayendo de la misma web
  for my $line (@lines){
    my %dict = matchLine($line);
    my $value = $dict{$kind};
    if(defined($value) && $value =~ /.*$keyword.*/){
      print "<h1>Encontrado: $line</h1>\n";
      print "<p>".$value."</p>";
      $flag = 1;
      next; #continue the loop
    }
  }
}
sub matchLine{
  my %dict = ();
  my $line = $_[0];
  my @split_array = split (/\|/, $line);
  $dict{"nombre"} = $split_array[1];
  $dict{"licenciamiento"} = $split_array[3];
  $dict{"departamento"} = $split_array[7];
  $dict{"programa"} = $split_array[18];
  return %dict;
}
