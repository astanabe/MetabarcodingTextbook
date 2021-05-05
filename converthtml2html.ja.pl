use utf8;
use open ':encoding(utf8)';
use open ':std';
my $switch;
my $switch2;
my $switch3;
while (<>) {
	if (/<figure.*?>/) {
		$switch3 = 1;
	}
	if ($switch3 && /<\/figure>>/) {
		$switch3 = 0;
	}
	if ($switch3 && /<ul.*?>/) {
		print("<figcaption class=\"ltx_caption\">");
	}
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
	elsif ($switch && /<span /) {
		$switch ++;
	}
	elsif ($switch && /^<\/span>/) {
		$switch --;
		if ($switch == 0) {
			s/^<\/span>/<\/p>/;
		}
	}
	if (/<div class="ltx_date ltx_role_creation">/) {
		s/January (\d+), (\d+)/$2年1月$1日/;
		s/February (\d+), (\d+)/$2年2月$1日/;
		s/March (\d+), (\d+)/$2年3月$1日/;
		s/April (\d+), (\d+)/$2年4月$1日/;
		s/May (\d+), (\d+)/$2年5月$1日/;
		s/June (\d+), (\d+)/$2年6月$1日/;
		s/July (\d+), (\d+)/$2年7月$1日/;
		s/August (\d+), (\d+)/$2年8月$1日/;
		s/September (\d+), (\d+)/$2年9月$1日/;
		s/October (\d+), (\d+)/$2年10月$1日/;
		s/November (\d+), (\d+)/$2年11月$1日/;
		s/December (\d+), (\d+)/$2年12月$1日/;
	}
	#s/(<cite class="ltx_cite[^\"]*">)(.+?)(<a href="\#bib\.bib\d+" title="" class="ltx_ref">)(.+?)(<\/a>)(.+?)(<\/cite>)/$1$3$2$4$6$5$7/g;
	s/<li id="bib.bib\d+" class="ltx_bibitem"/$& style="padding:0em 0em 0.2em 0em;"/;
	s/<ul class="ltx_biblist"/$& style="padding:0em 0em 0em 1em;text-indent:-1em;"/;
	s/style="border-color: #(\d+);padding-top:12pt;padding-bottom:12pt;"/style="border-color #$1;"/g;
	s/<dt ([^<>]+) class="ltx_item">/<dt $1>/g;
	s/<dd class="ltx_item">/<dd>/g;
	s/Chapter\s(\d+)/第$1章/g;
	s/Part\s(\d+)/第$1部/g;
	s/ltx_inline-block ltx_framed_rectangle/ltx_p ltx_framed_rectangle/g;
	s/ltx_td ltx_align_left/$& ltx_wrap/g;
	s/font-size:\d+\%/font-size:100\%/g;
	print;
	if ($switch3 && /<\/ul>/) {
		print("</figcaption>");
	}
}
