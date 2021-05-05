use utf8;
use open ':encoding(utf8)';
use open ':std';
my $switch1;
while (<>) {
	if ($switch1 && /\\makeatother/) {
		$switch1 = 0;
		next;
	}
	elsif ($switch1) {
		next;
	}
	elsif (!$switch1 && /\\makeatletter/) {
		$switch1 = 1;
		next;
	}
	elsif (/\\documentclass/ && /jsbook/) {
		s/jsbook[a-zA-Z0-9]*/book/;
		s/titlepage, *//;
		s/english, *//;
		s/uplatex, *//;
		s/, *titlepage//;
		s/, *english//;
		s/, *uplatex//;
		s/\[ *titlepage *\]//;
		s/\[ *english *\]//;
		s/\[ *uplatex *\]//;
		s/\[ *\]//;
	}
	elsif (/\\documentclass/ && /jsarticle/) {
		s/jsarticle[a-zA-Z0-9]*/article/;
		s/titlepage, *//;
		s/english, *//;
		s/uplatex, *//;
		s/, *titlepage//;
		s/, *english//;
		s/, *uplatex//;
		s/\[ *titlepage *\]//;
		s/\[ *english *\]//;
		s/\[ *uplatex *\]//;
		s/\[ *\]//;
	}
	elsif (/\\usepackage/ && /xcolor/) {
		s/dvipdfmx, *//;
		s/hiresbb, *//;
		s/, *dvipdfmx//;
		s/, *hiresbb//;
		s/\[ *dvipdfmx *\]//;
		s/\[ *hiresbb *\]//;
		s/\[ *\]//;
	}
	elsif (/\\bibliographystyle/ && /jecon/) {
		s/jecon/alphanat/;
	}
	elsif (/\\usepackage/ && /(?:pxchfon|pxjahyper|pxcjkcat|otf)/) {
		s/\\usepackage.*\{.+\}//;
	}
	#elsif (/\\includegraphics\{/) {
	#	s/\\includegraphics\{/\\includegraphics[scale=2.0]{/;
	#}
	#elsif (/\\title\{/) {
	#	s/\\title\{.+\}//;
	#}
	elsif (/\\cjkcategory\{/) {
		s/\\cjkcategory\{.+\}//;
	}
	elsif (/\\centering/) {
		s/\\centering//g;
	}
	elsif (/atbegshi/ || /AtBeginShipoutFirst/ || /prepartname/ || /postpartname/ || /prechaptername/ || /postchaptername/ || /presectionname/ || /postsectionname/ || /fullwidth/ || /evensidemargin/ || /oddsidemargin/ || /\\tableofcontents/ || /\\cleardoublepage/ || /\\clearpage/ || /\\maketitle/ || /\\pagenumbering\{roman\}/) {
		s/^/\%/;
	}
	elsif (/\\bibliography\{([^\{\}]+)\}/) {
		my $bibfile = $1;
		$bibfile .= '.bbl';
		my $thebibliography;
		my $switch2;
		open(BIB, "< $bibfile");
		while (my $line = readline(BIB)) {
			if ($line =~ /\\begin\{thebibliography\}/) {
				$switch2 = 1;
			}
			elsif ($line =~ /\\end\{thebibliography\}/) {
				$thebibliography .= $line;
				last;
			}
			if ($switch2) {
				$thebibliography .= $line;
			}
		}
		close(BIB);
		s/\\bibliography\{([^\{\}]+)\}/$thebibliography/;
	}
	elsif (/\\begin\{tabular\}\{.+\}/) {
		s/p\{\d+(?:\.\d+)?[a-z]+\}/l/g;
	}
	elsif (/\\begin\{longtable\}(?:\[.+?\])\{.+\}/) {
		s/p\{\d+(?:\.\d+)?[a-z]+\}/l/g;
	}
	print;
}
