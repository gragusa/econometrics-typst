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
  $if(papersize)$
  paper: "$papersize$",
  $endif$
  $if(margin)$
  margin: ($for(margin/pairs)$$margin.key$: $margin.value$,$endfor$),
  $endif$
  $if(number-sections)$
  sectionnumbering: "1.1.1",
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
  doc,
)

$if(titlepage)$
#make-titlepage(
  $if(title)$title: [$title$],$endif$
  $if(author)$authors: ($for(author)$"$author$",$endfor$),$endif$
  $if(date)$date: [$date$],$endif$
  $if(titlepage-background)$background: "$titlepage-background$",$endif$
  $if(titlepage-rule-color)$rule-color: rgb("#$titlepage-rule-color$"),$endif$
)
$endif$
