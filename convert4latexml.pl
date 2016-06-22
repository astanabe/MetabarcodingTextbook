use utf8;
use open ':encoding(utf8)';
use open ':std';
my $switch;
while (<>) {
	if ($switch && /\\makeatother/) {
		$switch = 0;
		next;
	}
	elsif ($switch) {
		next;
	}
	elsif (!$switch && /\\makeatletter/) {
		$switch = 1;
		next;
	}
	elsif (/\\documentclass/ && /jsbook/) {
		s/jsbook/book/;
		s/titlepage,//;
		s/,titlepage//;
		s/english,//;
		s/,english//;
	}
	elsif (/\\bibliographystyle/ && /jecon/) {
		s/jecon/alphanat/;
	}
	elsif (/atbegshi/ || /AtBeginShipoutFirst/ || /prepartname/ || /postpartname/ || /prechaptername/ || /postchaptername/ || /presectionname/ || /postsectionname/ || /fullwidth/ || /evensidemargin/ || /oddsidemargin/ || /\\tableofcontents/ || /\\cleardoublepage/ || /\\clearpage/ || /\\maketitle/ || /\\pagenumbering\{roman\}/) {
		s/^/\%/;
	}
	elsif (/\\bibliography\{([^\{\}]+)\}/) {
		my $bibfile = $1;
		$bibfile .= '.bbl';
		my $thebibliography;
		my $switch;
		open(BIB, "< $bibfile");
		while (my $line = readline(BIB)) {
			if ($line =~ /\\begin\{thebibliography\}/) {
				$switch = 1;
			}
			elsif ($line =~ /\\end\{thebibliography\}/) {
				$thebibliography .= $line;
				last;
			}
			if ($switch) {
				$thebibliography .= $line;
			}
		}
		close(BIB);
		s/\\bibliography\{([^\{\}]+)\}/$thebibliography/;
	}
	print;
}
