// Eisvogel-style title page
// Replicates the LaTeX eisvogel template layout:
// - Full-page background image (PNG, JPEG, SVG — not PDF)
//   or solid background color via titlepage-color
// - Colored horizontal rule spanning wider than text
// - Title, subtitle, author, date in left-aligned flushleft block
// - Text color defaults to dark gray (#5F5F5F), white when background is present
//
// Note: Typst does not support PDF images. If you have a PDF background,
// convert it first:  pdftoppm -png -r 300 background.pdf bg  →  bg-1.png
//                    or: convert background.pdf background.png
#let make-titlepage(
  title: "",
  authors: (),
  date: "",
  background: none,
  titlepage-color: none,
  rule-color: rgb("#435488"),
  text-color: auto,
  rule-height: 4pt,
) = {
  let has-bg = background != none
  let has-color = titlepage-color != none

  // Resolve text color: white if background present, dark gray otherwise
  let tc = if text-color == auto {
    if has-bg or has-color { white } else { rgb("#5F5F5F") }
  } else {
    text-color
  }

  // Margins differ depending on whether background is present
  let tp-margin = if has-bg or has-color {
    (top: 2cm, right: 4cm, bottom: 3cm, left: 4cm)
  } else {
    (top: 2.5cm, right: 2.5cm, bottom: 2.5cm, left: 6cm)
  }

  set page(margin: tp-margin, header: none, footer: none)

  // Background: image or solid color
  if has-bg {
    place(
      top + left,
      dx: -tp-margin.left,
      dy: -tp-margin.top,
      image(background, width: 100% + tp-margin.left + tp-margin.right, height: 100% + tp-margin.top + tp-margin.bottom),
    )
  } else if has-color {
    place(
      top + left,
      dx: -tp-margin.left,
      dy: -tp-margin.top,
      rect(
        width: 100% + tp-margin.left + tp-margin.right,
        height: 100% + tp-margin.top + tp-margin.bottom,
        fill: titlepage-color,
      ),
    )
  }

  // Colored rule: extends 30% beyond text width (like eisvogel's 1.3\textwidth)
  place(
    top + left,
    dy: -0.5em,
    line(length: 130%, stroke: rule-height + rule-color),
  )

  // Vertical fill, then content at the bottom
  set text(fill: tc)

  if has-bg or has-color {
    // With background/color: double spacing, text near bottom
    v(1fr)
    v(-8em)
    text(size: 24pt, weight: "bold")[#title]
    v(2em)
    text(size: 16pt)[#authors.join(", ")]
    v(0.6em)
    text(size: 16pt)[#date]
    v(1fr)
  } else {
    // Without background: tighter spacing
    v(1fr)
    text(size: 24pt, weight: "bold")[#title]
    v(2em)
    text(size: 16pt)[#authors.join(", ")]
    v(1fr)
    text(size: 12pt)[#date]
  }

  pagebreak()
}
