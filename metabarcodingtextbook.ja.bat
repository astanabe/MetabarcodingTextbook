del metabarcodingtextbook.ja.bib
copy metabarcodingtextbook.bib metabarcodingtextbook.ja.bib
platex --kanji=utf8 metabarcodingtextbook.ja
pbibtex --kanji=utf8 metabarcodingtextbook.ja
platex --kanji=utf8 metabarcodingtextbook.ja
platex --kanji=utf8 metabarcodingtextbook.ja
dvipdfmx metabarcodingtextbook.ja
perl convert4latexml.pl < metabarcodingtextbook.ja.tex > metabarcodingtextbook.ja.temp.tex
call latexml --xml --nocomments --inputencoding=utf8 --destination=metabarcodingtextbook.ja.xml metabarcodingtextbook.ja.temp.tex
del metabarcodingtextbook.ja.temp.tex
perl convertxml2xml.pl < metabarcodingtextbook.ja.xml > metabarcodingtextbook.ja.temp.xml
del metabarcodingtextbook.ja.xml
rename metabarcodingtextbook.ja.temp.xml metabarcodingtextbook.ja.xml
call latexmlpost --format=html5 --crossref --index --mathimages --graphicimages --destination=metabarcodingtextbook.ja.html metabarcodingtextbook.ja.xml
perl converthtml2html.ja.pl < metabarcodingtextbook.ja.html > metabarcodingtextbook.ja.temp.html
del metabarcodingtextbook.ja.html
rename metabarcodingtextbook.ja.temp.html metabarcodingtextbook.ja.html
perl -i.bak -npe "s/<dc:date>.+<\/dc:date>/<dc:date>%date:~0,4%-%date:~5,2%-%date:~8,2%<\/dc:date>/" metabarcodingtextbook.ja.opf
ebook-convert metabarcodingtextbook.ja.html metabarcodingtextbook.ja.epub --max-toc-links=0 --toc-threshold=1 --level1-toc=//h:h2 --level2-toc=//h:h3 --level3-toc=//h:h4 --read-metadata-from-opf=metabarcodingtextbook.ja.opf --cover=metabarcodingtextbook.ja.png --preserve-cover-aspect-ratio
kindlegen metabarcodingtextbook.ja.epub
