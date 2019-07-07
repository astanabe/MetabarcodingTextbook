use utf8;
use open ':encoding(utf8)';
use open ':std';
use File::Spec;
my $devnull = File::Spec->devnull();
my $switch;
while (<>) {
	if (/<\?latexml package=\"hyperref\" options=\".+?\"\?>/) {
		s/ options=\".+?\"//;
	}
	if (/\<graphics .*graphic=\"(.+?)\" .*>/ && -e $1) {
		my $graphic = $1;
		my $converted = $graphic;
		$converted =~ s/\.[^\.]+$/.png/;
		system("gswin32c -dSAFER -dBATCH -dNOPAUSE -sDEVICE=png16m -r300 -sOutputFile=$converted $graphic 1> $devnull");
		s/$graphic/$converted/g;
	}
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
