use utf8;
use open ':encoding(utf8)';
use open ':std';
my $switch;
while (<>) {
	if (/<bibitem xml:id="bib.bib1">/) {
		$switch = 1;
	}
	elsif ($switch && /<\/bibitem>/) {
		$switch = 0;
		next;
	}
	if ($switch || /<bibtag role="refnum">.+<\/bibtag>/) {
		next;
	}
	else {
		print;
	}
}
