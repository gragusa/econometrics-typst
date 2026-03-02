-- filters-typst.lua
-- Converts .ananote and .proof divs to raw Typst blocks

function Div(el)
  if quarto == nil or not quarto.doc.is_format("typst") then
    return nil
  end

  if el.classes:includes("ananote") then
    local blocks = pandoc.List({
      pandoc.RawBlock("typst", "#ananote[")
    })
    blocks:extend(el.content)
    blocks:insert(pandoc.RawBlock("typst", "]"))
    return blocks
  end

  if el.classes:includes("proof") then
    local blocks = pandoc.List({
      pandoc.RawBlock("typst", "#block(above: 1em, below: 1em)[_Proof._ "),
    })
    blocks:extend(el.content)
    blocks:insert(pandoc.RawBlock("typst", "#h(1fr) $square$ ]"))
    return blocks
  end
end
