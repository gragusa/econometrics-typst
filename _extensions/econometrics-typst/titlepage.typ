// Eisvogel-style title page
#let make-titlepage(
  title: "",
  authors: (),
  date: "",
  background: none,
  rule-color: rgb("#360049"),
) = {
  set page(margin: 0pt)

  // Background image
  if background != none {
    place(top + left, image(background, width: 100%, height: 100%))
  }

  // Content overlay
  place(
    bottom + left,
    dx: 2.5cm,
    dy: -4cm,
    block(width: 60%)[
      // Colored rule line
      #line(length: 100%, stroke: 3pt + rule-color)
      #v(0.5cm)

      // Title
      #text(size: 28pt, weight: "bold", fill: white)[#title]
      #v(0.5cm)

      // Authors
      #for author in authors {
        text(size: 16pt, fill: white)[#author]
        linebreak()
      }
      #v(0.3cm)

      // Date
      #text(size: 14pt, fill: white)[#date]
    ],
  )

  pagebreak()
}
