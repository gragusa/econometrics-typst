-- assumption-typst.lua
-- Handles custom theorem-like environments and cross-references for Typst output.
-- Adapted from assumption.lua. For non-Typst formats, falls through unchanged.

local counters = {
  ass = 0,
  remark = 0,
  theorem = 0,
  lemma = 0,
  example = 0,
  definition = 0
}

local labels = {}
local current_section = 0

-- Environment configuration: prefix -> {display_name, fill_color}
local env_config = {
  ass       = {display = "Assumption", fill = "#F0FFF0"},
  remark    = {display = "Remark",     fill = "#F0F8FF"},
  theorem   = {display = "Theorem",    fill = "#F8F0FF"},
  lemma     = {display = "Lemma",      fill = "#F8F0FF"},
  example   = {display = "Example",    fill = "#F0F8FF"},
  definition = {display = "Definition", fill = "#FFFDF0"}
}

-- Counter variable names in Typst (must match theorem.typ)
local counter_names = {
  ass        = "assumption-counter",
  remark     = "remark-counter",
  theorem    = "theorem-counter",
  lemma      = "lemma-counter",
  example    = "example-counter",
  definition = "definition-counter"
}

function Header(header)
  if quarto == nil or not quarto.doc.is_format("typst") then
    return nil
  end
  if header.level == 1 then
    current_section = current_section + 1
    for k, _ in pairs(counters) do
      counters[k] = 0
    end
  end
  return nil
end

function Div(div)
  if quarto == nil or not quarto.doc.is_format("typst") then
    return nil
  end

  if not div.identifier then
    return nil
  end

  -- Check which prefix this div matches
  local prefix = nil
  for p, _ in pairs(env_config) do
    if div.identifier:match("^" .. p .. "%-") then
      prefix = p
      break
    end
  end

  if not prefix then
    return nil
  end

  local config = env_config[prefix]
  local label = div.identifier
  counters[prefix] = counters[prefix] + 1
  local number = current_section .. "." .. counters[prefix]
  labels[label] = {number = number, display = config.display}

  -- Extract title from first header if present
  local title = ""
  local content = pandoc.List({})
  local found_header = false

  for _, block in ipairs(div.content) do
    if not found_header and block.t == "Header" then
      title = pandoc.utils.stringify(block.content)
      found_header = true
    else
      content:insert(block)
    end
  end

  -- Escape quotes in title for Typst string literal
  local escaped_title = title:gsub('"', '\\"')

  -- Build raw Typst block using theorem-box from theorem.typ
  local blocks = pandoc.List({})
  blocks:insert(pandoc.RawBlock("typst",
    '#theorem-box(' ..
    counter_names[prefix] .. ', ' ..
    '"' .. config.display .. '", ' ..
    '"' .. escaped_title .. '", ' ..
    '"' .. label .. '", ' ..
    'rgb("' .. config.fill .. '")' ..
    ')['))
  blocks:extend(content)
  blocks:insert(pandoc.RawBlock("typst", "]"))
  return blocks
end

function Cite(cite)
  if quarto == nil or not quarto.doc.is_format("typst") then
    return nil
  end

  for _, citation in ipairs(cite.citations) do
    local id = citation.id

    -- Check which prefix this citation matches
    local prefix = nil
    for p, _ in pairs(env_config) do
      if id:match("^" .. p .. "%-") then
        prefix = p
        break
      end
    end

    if prefix then
      local config = env_config[prefix]
      local suppress_prefix = citation.mode == "SuppressAuthor"

      -- Check if we have a resolved label from this run
      local info = labels[id]

      if info then
        -- We have the number from this render pass
        if suppress_prefix then
          return pandoc.RawInline("typst",
            '#link(label("' .. id .. '"))[' .. info.number .. ']')
        else
          return pandoc.RawInline("typst",
            '#link(label("' .. id .. '"))[' .. info.display .. ' ' .. info.number .. ']')
        end
      else
        -- Cross-lecture reference: use Typst ref mechanism
        if suppress_prefix then
          return pandoc.RawInline("typst",
            '#link(label("' .. id .. '"))[' .. config.display .. ']')
        else
          return pandoc.RawInline("typst",
            '#link(label("' .. id .. '"))[' .. config.display .. ']')
        end
      end
    end
  end
end

-- Return filter in correct order (Header must come before Div)
return {
  {Header = Header},
  {Div = Div, Cite = Cite}
}
