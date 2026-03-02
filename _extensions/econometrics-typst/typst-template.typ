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
  mathfont: "New Computer Modern Math",
  monofont: "JuliaMono",
  fontsize: 11pt,
  sectionnumbering: "1.1.1",
  titlepage: false,
  titlepage-background: none,
  titlepage-rule-color: rgb("#360049"),
  toc: false,
  header-left: none,
  header-right: none,
  footer-left: none,
  footer-right: none,
  doc,
) = {
  set page(paper: paper, margin: margin)
  set text(lang: lang, region: region, font: font, size: fontsize)
  show math.equation: set text(font: mathfont)
  show raw: set text(font: monofont, size: 0.9em)
  set par(justify: true)

  // Heading numbering — must be a top-level set rule (not inside `if`)
  // so that it propagates to doc. Passing `none` disables numbering.
  set heading(numbering: sectionnumbering)

  // Heading spacing: add space below subsections
  show heading.where(level: 2): set block(above: 1.4em, below: 1em)
  show heading.where(level: 3): set block(above: 1.2em, below: 0.8em)

  // Header and footer
  let hl = if header-left != none { header-left } else if title != none { title } else { [] }
  let hr = if header-right != none { header-right } else if date != none { date } else { [] }
  let fl = if footer-left != none {
    footer-left
  } else {
    authors.join(", ")
  }
  let fr = if footer-right != none { footer-right } else {
    context counter(page).display("1")
  }

  set page(
    header: context {
      if counter(page).get().first() > 1 {
        set text(size: 9pt)
        grid(
          columns: (1fr, 1fr),
          align: (left, right),
          hl, hr,
        )
        v(-3pt)
        line(length: 100%, stroke: 0.5pt)
      }
    },
    footer: context {
      if counter(page).get().first() > 1 {
        set text(size: 9pt)
        line(length: 100%, stroke: 0.5pt)
        v(-3pt)
        grid(
          columns: (1fr, 1fr),
          align: (left, right),
          fl, fr,
        )
      }
    },
  )

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
