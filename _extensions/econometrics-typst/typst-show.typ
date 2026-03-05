// typst-show.typ: wire Pandoc metadata into the template

#show: doc => article(
  $if(title)$
  title: [$title$],
  $endif$
  $if(author)$
  authors: (
    $for(author)$
    "$author$",
    $endfor$
  ),
  $endif$
  $if(date)$
  date: [$date$],
  $endif$
  $if(lang)$
  lang: "$lang$",
  $endif$
  $if(region)$
  region: "$region$",
  $endif$
  $if(mainfont)$
  font: "$mainfont$",
  $endif$
  $if(mathfont)$
  mathfont: "$mathfont$",
  $endif$
  $if(monofont)$
  monofont: "$monofont$",
  $endif$
  $if(fontsize)$
  fontsize: $fontsize$,
  $endif$
  $if(caption-size)$
  caption-size: $caption-size$,
  $endif$
  $if(papersize)$
  paper: "$papersize$",
  $endif$
  $if(margin)$
  margin: ($for(margin/pairs)$$margin.key$: $margin.value$,$endfor$),
  $endif$
  $if(section-numbering)$
  sectionnumbering: "$section-numbering$",
  $else$
  sectionnumbering: none,
  $endif$
  $if(toc)$
  toc: $toc$,
  $endif$
  titlepage: $if(titlepage)$true$else$false$endif$,
  $if(titlepage-background)$
  titlepage-background: "$titlepage-background$",
  $endif$
  $if(titlepage-rule-color)$
  titlepage-rule-color: rgb("#$titlepage-rule-color$"),
  $endif$
  $if(header-left)$
  header-left: [$header-left$],
  $endif$
  $if(header-right)$
  header-right: [$header-right$],
  $endif$
  $if(footer-left)$
  footer-left: [$footer-left$],
  $endif$
  $if(footer-right)$
  footer-right: [$footer-right$],
  $endif$
  doc,
)

$if(titlepage)$
#make-titlepage(
  $if(title)$title: [$title$],$endif$
  $if(author)$authors: ($for(author)$"$author$",$endfor$),$endif$
  $if(date)$date: [$date$],$endif$
  $if(titlepage-background)$background: "$titlepage-background$",$endif$
  $if(titlepage-color)$titlepage-color: rgb("#$titlepage-color$"),$endif$
  $if(titlepage-rule-color)$rule-color: rgb("#$titlepage-rule-color$"),$endif$
  $if(titlepage-text-color)$text-color: rgb("#$titlepage-text-color$"),$endif$
  $if(titlepage-rule-height)$rule-height: $titlepage-rule-height$,$endif$
)
$endif$
