use utf8;
use open ':encoding(utf8)';
use open ':std';
while (<>) {
	while (/(\\href\{[^\{\}]+\}\{.+?)([\_\-\.\/])([^\{\}]+\})/) {
		my $char = $2;
		if ($char eq '_') {
			s/(\\href\{[^\{\}]+\}\{.+?)\_([^\{\}]+\})/$1\{\\textunderscore\}\\allowbreak\{\}$2/;
		}
		elsif ($char eq '-') {
			s/(\\href\{[^\{\}]+\}\{.+?)\-([^\{\}]+\})/$1\{-\}\\allowbreak\{\}$2/;
		}
		elsif ($char eq '.') {
			s/(\\href\{[^\{\}]+\}\{.+?)\.([^\{\}]+\})/$1\{.\}\\allowbreak\{\}$2/;
		}
		elsif ($char eq '/') {
			s/(\\href\{[^\{\}]+\}\{.+?)\/([^\{\}]+\})/$1\{\/\}\\allowbreak\{\}$2/;
		}
	}
	print;
}
