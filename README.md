# Econometrics Typst Extension for Quarto

A Quarto format extension that produces PDF output via [Typst](https://typst.app/) for econometrics lecture notes. It handles custom LaTeX math commands (expectations, variances, conditional expectations, bold vectors, etc.), theorem-like environments with colored backgrounds, ananote boxes, and an eisvogel-style title page --- all without requiring changes to `.qmd` source files.

## Installation

```bash
quarto add gragusa/econometrics-typst
```

This will install the extension under the `_extensions` subdirectory. If you are using version control, you should check in this directory.

## Usage

Add the format to your document YAML header or `_quarto.yml`:

```yaml
format:
  econometrics-typst-typst:
    number-sections: true
    papersize: a4
    mainfont: "Latin Modern Roman"
    mathfont: "Latin Modern Math"
    monofont: "JuliaMono"
    titlepage: true
    titlepage-background: "background3.pdf"
    titlepage-rule-color: "360049"
```

Then render with:

```bash
quarto render document.qmd --to econometrics-typst-typst
```

## Features

### Math Command Expansion

Custom LaTeX commands are automatically expanded to primitive LaTeX before Pandoc converts to Typst. Supported commands include:

- **Expectations**: `\E*{X}`, `\Eb*{X}`, `\Ec*{X}`, `\Ea*{X}`
- **Conditional expectations**: `\CE*{Y \given X}`, `\CEb*{Y \given X}`
- **Variance/covariance**: `\var*{X}`, `\cov*{X, Y}`, `\cor*{X, Y}`, `\avar*{X}`
- **Linear projection**: `\LP*{Y \given X}`, `\LPb*{Y \given X}`
- **Probability**: `\Prob*{A \given B}`
- **Delimiters**: `\paren*{}`, `\brock*{}`, `\norm*{}`, `\abs*{}`, `\anglebrackets*{}`, `\ceil*{}`, `\floor*{}`, `\curly*{}`, `\card*{}`
- **Vectors/matrices**: `\va`--`\vz`, `\mA`--`\mZ`, `\vbeta`, `\mSigma`, etc.
- **Calligraphic**: `\calA`--`\calZ`
- **Convergence**: `\pto`, `\dto`, `\simiid`, `\simnid`, `\sima`
- **Independence**: `\indep`, `\nindep`
- **Operators**: `\argmin`, `\argmax`, `\sign`, `\trace`, `\Normal`, `\boldone`

Nested commands work: `\CE*{(Y - \CE*{Y \given X})^2 \given X}`.

### Theorem Environments

Quarto fenced divs with specific prefixes are rendered as colored boxes with automatic numbering:

| Prefix | Display | Color |
|--------|---------|-------|
| `ass-` | Assumption | Light green |
| `definition-` | Definition | Light cream |
| `theorem-` | Theorem | Light purple |
| `lemma-` | Lemma | Light purple |
| `remark-` | Remark | Light blue |
| `example-` | Example | Light blue |

Example:

```markdown
::: {#theorem-clt}
## Central Limit Theorem

Content here.
:::

See @theorem-clt for a cross-reference.
```

### Ananote Boxes

Framed explanatory notes with a light blue background:

```markdown
::: {.ananote}
Explanatory content here.
:::
```

### Title Page

Eisvogel-style title page with optional background image and colored rule. Set `titlepage: true` and provide `titlepage-background` and `titlepage-rule-color` in YAML.

## File Overview

| File | Purpose |
|------|---------|
| `expand-macros.lua` | Expands custom LaTeX math commands to primitives |
| `assumption-typst.lua` | Converts theorem divs to Typst boxes with cross-references |
| `filters-typst.lua` | Converts ananote divs to Typst blocks |
| `theorem.typ` | Theorem box definitions, counters, and reset logic |
| `ananote.typ` | Ananote framed box definition |
| `titlepage.typ` | Eisvogel-style title page |
| `typst-template.typ` | Main Typst template (page, fonts, margins) |
| `typst-show.typ` | Wires YAML metadata into the template |

## License

MIT
