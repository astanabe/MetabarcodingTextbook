del metabarcodingtextbook.en.bib
copy metabarcodingtextbook.bib metabarcodingtextbook.en.bib
platex --kanji=utf8 metabarcodingtextbook.en
pbibtex --kanji=utf8 metabarcodingtextbook.en
platex --kanji=utf8 metabarcodingtextbook.en
platex --kanji=utf8 metabarcodingtextbook.en
dvipdfmx metabarcodingtextbook.en
perl convert4latexml.pl < metabarcodingtextbook.en.tex > metabarcodingtextbook.en.temp.tex
call latexml --xml --nocomments --inputencoding=utf8 --destination=metabarcodingtextbook.en.xml metabarcodingtextbook.en.temp.tex
del metabarcodingtextbook.en.temp.tex
perl convertxml2xml.pl < metabarcodingtextbook.en.xml > metabarcodingtextbook.en.temp.xml
del metabarcodingtextbook.en.xml
rename metabarcodingtextbook.en.temp.xml metabarcodingtextbook.en.xml
call latexmlpost --format=html5 --crossref --index --mathimages --graphicimages --destination=metabarcodingtextbook.en.html metabarcodingtextbook.en.xml
perl converthtml2html.en.pl < metabarcodingtextbook.en.html > metabarcodingtextbook.en.temp.html
del metabarcodingtextbook.en.html
rename metabarcodingtextbook.en.temp.html metabarcodingtextbook.en.html
perl -i.bak -npe "s/<dc:date>.+<\/dc:date>/<dc:date>%date:~0,4%-%date:~5,2%-%date:~8,2%<\/dc:date>/" metabarcodingtextbook.en.opf
ebook-convert metabarcodingtextbook.en.html metabarcodingtextbook.en.epub --max-toc-links=0 --toc-threshold=1 --level1-toc=//h:h2 --level2-toc=//h:h3 --level3-toc=//h:h4 --read-metadata-from-opf=metabarcodingtextbook.en.opf --cover=metabarcodingtextbook.en.png --preserve-cover-aspect-ratio
kindlegen metabarcodingtextbook.en.epub
