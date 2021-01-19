t=`TZ=JST-9 date +%Y-%m-%d`
rm metabarcodingtextbook1.ja.bib
cp metabarcodingtextbook1.bib metabarcodingtextbook1.ja.bib
uplatex --kanji=utf8 metabarcodingtextbook1.ja
upbibtex --kanji=utf8 metabarcodingtextbook1.ja
perl convertbbl.pl < metabarcodingtextbook1.ja.bbl > metabarcodingtextbook1.ja.temp.bbl
rm -f metabarcodingtextbook1.ja.bbl
mv metabarcodingtextbook1.ja.temp.bbl metabarcodingtextbook1.ja.bbl
uplatex --kanji=utf8 metabarcodingtextbook1.ja
uplatex --kanji=utf8 metabarcodingtextbook1.ja
dvipdfmx metabarcodingtextbook1.ja
rm metabarcodingtextbook1.ja.temp.pdf
perl -i.bak -npe "s/<dc:date>.+<\/dc:date>/<dc:date>$t<\/dc:date>/" metabarcodingtextbook1.ja.xmp
cpdf -set-metadata metabarcodingtextbook1.ja.xmp metabarcodingtextbook1.ja.pdf -o metabarcodingtextbook1.ja.temp.pdf
rm metabarcodingtextbook1.ja.pdf
mv metabarcodingtextbook1.ja.temp.pdf metabarcodingtextbook1.ja.pdf
perl convert4latexml.pl < metabarcodingtextbook1.ja.tex > metabarcodingtextbook1.ja.temp.tex
latexml --xml --nocomments --inputencoding=utf8 --destination=metabarcodingtextbook1.ja.xml metabarcodingtextbook1.ja.temp.tex
rm metabarcodingtextbook1.ja.temp.tex
perl convertxml2xml.pl < metabarcodingtextbook1.ja.xml > metabarcodingtextbook1.ja.temp.xml
rm metabarcodingtextbook1.ja.xml
mv metabarcodingtextbook1.ja.temp.xml metabarcodingtextbook1.ja.xml
latexmlpost --format=html5 --crossref --index --mathimages --nomathsvg --nopresentationmathml --nocontentmathml --noopenmath --nomathtex --graphicimages --verbose --destination=metabarcodingtextbook1.ja.html metabarcodingtextbook1.ja.xml
perl converthtml2html.ja.pl < metabarcodingtextbook1.ja.html > metabarcodingtextbook1.ja.temp.html
rm metabarcodingtextbook1.ja.html
mv metabarcodingtextbook1.ja.temp.html metabarcodingtextbook1.ja.html
perl -i.bak -npe "s/<dc:date>.+<\/dc:date>/<dc:date>$t<\/dc:date>/" metabarcodingtextbook1.ja.opf
ebook-convert metabarcodingtextbook1.ja.html metabarcodingtextbook1.ja.epub --max-toc-links=0 --toc-threshold=1 --level1-toc=//h:h2 --level2-toc=//h:h3 --level3-toc=//h:h4 --read-metadata-from-opf=metabarcodingtextbook1.ja.opf --cover=metabarcodingtextbook1.ja.title.png --preserve-cover-aspect-ratio
kindlegen metabarcodingtextbook1.ja.epub
