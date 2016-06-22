use utf8;
use open ':encoding(utf8)';
use open ':std';
my $switch;
my $switch2;
while (<>) {
	if (/<footer class="ltx_page_footer">/) {
		$switch2 = 1;
		next;
	}
	elsif ($switch2 && /<\/footer>/) {
		$switch2 = 0;
		next;
	}
	elsif ($switch2) {
		next;
	}
	if (/^<span class="ltx_inline-block" /) {
		$switch = 1;
		s/^<span class="ltx_inline-block" /<p class="ltx_p ltx_align_left" /;
	}
	elsif ($switch && /^<\/span>/) {
		$switch = 0;
		s/^<\/span>/<\/p>/;
	}
	s/(<cite class="ltx_cite">)(.+?)(<a href="\#bib\.bib\d+" title="" class="ltx_ref">)(.+?)(<\/a>)(.+?)(<\/cite>)/$1$3$2$4$6$5$7/g;
	s/<li id="bib.bib\d+" class="ltx_bibitem"/$& style="padding:0em 0em 0.2em 0em;"/;
	s/<ul class="ltx_biblist"/$& style="padding:0em 0em 0em 1em;text-indent:-1em;"/;
	s/style="border-left:1px solid #000000;"/style="border-left:0.5em solid #000000;padding:0.5em 1em 0.5em 1em;"/g;
	s/style="border:1px solid #000000;padding-top:12pt;padding-bottom:12pt;"/style="border:1px solid #000000;padding:0.5em 0em 0.5em 0em;"/g;
	s/<dt ([^<>]+) class="ltx_item">/<dt $1>/g;
	s/<dd class="ltx_item">/<dd>/g;
	print;
}
