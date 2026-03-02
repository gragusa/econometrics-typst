// Main template function for the econometrics book
#let article(
  title: none,
  authors: (),
  date: none,
  abstract: none,
  cols: 1,
  margin: (x: 2.5cm, y: 2.5cm),
  paper: "a4",
  lang: "en",
  region: "US",
  font: "Latin Modern Roman",
  mathfont: "Latin Modern Math",
  monofont: "JuliaMono",
  fontsize: 11pt,
  sectionnumbering: "1.1.1",
  titlepage: false,
  titlepage-background: none,
  titlepage-rule-color: rgb("#360049"),
  toc: false,
  doc,
) = {
  set page(paper: paper, margin: margin)
  set text(lang: lang, region: region, font: font, size: fontsize)
  show math.equation: set text(font: mathfont)
  show raw: set text(font: monofont, size: 0.9em)
  set par(justify: true)

  // Heading numbering
  if sectionnumbering != none {
    set heading(numbering: sectionnumbering)
  }

  // Title page
  if titlepage {
    // Import and call titlepage
    // (handled via typst-show.typ preamble)
  }

  // Table of contents
  if toc {
    outline(indent: auto)
    pagebreak()
  }

  // Main content
  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}
