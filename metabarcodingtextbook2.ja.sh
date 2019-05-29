t=`TZ=JST-9 date +%Y.%m.%d`
rm metabarcodingtextbook2.ja.bib
cp metabarcodingtextbook2.bib metabarcodingtextbook2.ja.bib
platex --kanji=utf8 metabarcodingtextbook2.ja
pbibtex --kanji=utf8 metabarcodingtextbook2.ja
platex --kanji=utf8 metabarcodingtextbook2.ja
platex --kanji=utf8 metabarcodingtextbook2.ja
dvipdfmx -V 7 metabarcodingtextbook2.ja
rm metabarcodingtextbook2.ja.temp.pdf
perl -i.bak -npe "s/<dc:date>.+<\/dc:date>/<dc:date>$t<\/dc:date>/" metabarcodingtextbook2.ja.xmp
cpdf -set-metadata metabarcodingtextbook2.ja.xmp metabarcodingtextbook2.ja.pdf -o metabarcodingtextbook2.ja.temp.pdf
rm metabarcodingtextbook2.ja.pdf
mv metabarcodingtextbook2.ja.temp.pdf metabarcodingtextbook2.ja.pdf
perl convert4latexml.pl < metabarcodingtextbook2.ja.tex > metabarcodingtextbook2.ja.temp.tex
latexml --xml --nocomments --inputencoding=utf8 --destination=metabarcodingtextbook2.ja.xml metabarcodingtextbook2.ja.temp.tex
rm metabarcodingtextbook2.ja.temp.tex
perl convertxml2xml.pl < metabarcodingtextbook2.ja.xml > metabarcodingtextbook2.ja.temp.xml
rm metabarcodingtextbook2.ja.xml
mv metabarcodingtextbook2.ja.temp.xml metabarcodingtextbook2.ja.xml
latexmlpost --format=html5 --crossref --index --mathimages --graphicimages --destination=metabarcodingtextbook2.ja.html metabarcodingtextbook2.ja.xml
perl converthtml2html.ja.pl < metabarcodingtextbook2.ja.html > metabarcodingtextbook2.ja.temp.html
rm metabarcodingtextbook2.ja.html
mv metabarcodingtextbook2.ja.temp.html metabarcodingtextbook2.ja.html
perl -i.bak -npe "s/<dc:date>.+<\/dc:date>/<dc:date>$t<\/dc:date>/" metabarcodingtextbook2.ja.opf
ebook-convert metabarcodingtextbook2.ja.html metabarcodingtextbook2.ja.epub --max-toc-links=0 --toc-threshold=1 --level1-toc=//h:h2 --level2-toc=//h:h3 --level3-toc=//h:h4 --read-metadata-from-opf=metabarcodingtextbook2.ja.opf --cover=metabarcodingtextbook2.ja.title.png --preserve-cover-aspect-ratio
kindlegen metabarcodingtextbook2.ja.epub
