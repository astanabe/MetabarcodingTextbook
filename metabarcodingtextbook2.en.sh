t=`TZ=JST-9 date +%Y-%m-%d`
rm metabarcodingtextbook2.en.bib
cp metabarcodingtextbook2.bib metabarcodingtextbook2.en.bib
platex --kanji=utf8 metabarcodingtextbook2.en
pbibtex --kanji=utf8 metabarcodingtextbook2.en
platex --kanji=utf8 metabarcodingtextbook2.en
platex --kanji=utf8 metabarcodingtextbook2.en
dvipdfmx metabarcodingtextbook2.en
rm metabarcodingtextbook2.en.temp.pdf
perl -i.bak -npe "s/<dc:date>.+<\/dc:date>/<dc:date>$t<\/dc:date>/" metabarcodingtextbook2.en.xmp
cpdf -set-metadata metabarcodingtextbook2.en.xmp metabarcodingtextbook2.en.pdf -o metabarcodingtextbook2.en.temp.pdf
rm metabarcodingtextbook2.en.pdf
mv metabarcodingtextbook2.en.temp.pdf metabarcodingtextbook2.en.pdf
perl convert4latexml.pl < metabarcodingtextbook2.en.tex > metabarcodingtextbook2.en.temp.tex
latexml --xml --nocomments --inputencoding=utf8 --destination=metabarcodingtextbook2.en.xml metabarcodingtextbook2.en.temp.tex
rm metabarcodingtextbook2.en.temp.tex
perl convertxml2xml.pl < metabarcodingtextbook2.en.xml > metabarcodingtextbook2.en.temp.xml
rm metabarcodingtextbook2.en.xml
mv metabarcodingtextbook2.en.temp.xml metabarcodingtextbook2.en.xml
latexmlpost --format=html5 --crossref --index --mathimages --graphicimages --destination=metabarcodingtextbook2.en.html metabarcodingtextbook2.en.xml
perl converthtml2html.en.pl < metabarcodingtextbook2.en.html > metabarcodingtextbook2.en.temp.html
rm metabarcodingtextbook2.en.html
mv metabarcodingtextbook2.en.temp.html metabarcodingtextbook2.en.html
perl -i.bak -npe "s/<dc:date>.+<\/dc:date>/<dc:date>$t<\/dc:date>/" metabarcodingtextbook2.en.opf
ebook-convert metabarcodingtextbook2.en.html metabarcodingtextbook2.en.epub --max-toc-links=0 --toc-threshold=1 --level1-toc=//h:h2 --level2-toc=//h:h3 --level3-toc=//h:h4 --read-metadata-from-opf=metabarcodingtextbook2.en.opf --cover=metabarcodingtextbook2.en.title.png --preserve-cover-aspect-ratio
kindlegen metabarcodingtextbook2.en.epub
