// Theorem-like environment counters
#let assumption-counter = counter("assumption-counter")
#let remark-counter = counter("remark-counter")
#let theorem-counter = counter("theorem-counter")
#let lemma-counter = counter("lemma-counter")
#let example-counter = counter("example-counter")
#let definition-counter = counter("definition-counter")

// Reset all theorem counters on level-1 headings
#show heading.where(level: 1): it => {
  assumption-counter.update(0)
  remark-counter.update(0)
  theorem-counter.update(0)
  lemma-counter.update(0)
  example-counter.update(0)
  definition-counter.update(0)
  it
}

// Generic theorem box function
// counter: the specific counter for this environment type
// kind: display name (e.g., "Theorem", "Assumption")
// title: optional title string (can be empty)
// lbl: label string for cross-referencing (e.g., "theorem-clt")
// fill-color: background color
// body: content
#let theorem-box(ctr, kind, title, lbl, fill-color, body) = {
  ctr.step()
  let number = context {
    let section = counter(heading).get().first()
    let n = ctr.get().first()
    [#section.#n]
  }
  let header = {
    set text(font: "Latin Modern Sans", weight: "bold")
    [#kind #number]
    if title != "" {
      [ (#title)]
    }
  }
  [
    #block(
      width: 100%,
      fill: fill-color,
      radius: 0pt,
      inset: (left: 8pt, right: 8pt, top: 6pt, bottom: 6pt),
      above: 10pt,
      below: 10pt,
      breakable: true,
      [#header #label(lbl)

      #body],
    )
  ]
}
