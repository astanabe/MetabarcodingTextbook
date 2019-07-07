use utf8;
use open ':encoding(utf8)';
use open ':std';
my $content;
while (<>) {
	$content .= $_;
}
while ($content =~ /<math[ >](.+?)<\/math>/si) {
	my $mathml = $1;
	$mathml =~ m/altimg-height=\"(\d+)\"/si;
	my $height = $1;
	$mathml =~ m/altimg-valign=\"(\-?\d+)\"/si;
	my $verticalalign = $1;
	$mathml =~ m/altimg-width=\"(\d+)\"/si;
	my $width = $1;
	$mathml =~ m/alttext=\"([^\"]+)\"/si;
	my $alt = $1;
	$mathml =~ m/display=\"([^\"]+)\"/si;
	my $display = $1;
	$mathml =~ m/altimg=\"([^\"]+)\"/si;
	my $img = $1;
	$img =~ s/\\/\//g;
	if ($display eq 'inline') {
		$content =~ s/<math[ >].+?<\/math>/<img src="$img" width="$width" height="$height" alt="">/si;
	}
	elsif ($display eq 'block') {
		$content =~ s/<math[ >].+?<\/math>/<img src="$img" width="$width" height="$height" alt="">/si;
	}
	else {
		die();
	}
}
print($content);
