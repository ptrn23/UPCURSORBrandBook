// ==========================================
// THEME VARIABLES (UP CURSOR Brand Book 2.0)
// ==========================================

#let font-title = "Aleo"
#let font-heading = "Montserrat"
#let font-body = "Inter"

#let size-h1 = 36pt
#let size-h2 = 24pt
#let size-h3 = 18pt
#let size-h4 = 12pt
#let size-body = 10pt
#let size-pullquote = 18pt
#let size-small = 8pt

#let weight-h1 = "bold"
#let weight-h2 = "extrabold"
#let weight-h3 = "bold"
#let weight-h4 = "bold"
#let weight-body = "regular"

#let cursor-green = rgb("#10743C")
#let cursor-black = rgb("#161616")
#let cursor-white = rgb("#F6F7F8")

#let color-white = rgb("#FFFFFF")
#let color-muted = rgb("#52525B")
#let color-footer = rgb("#3F3F46")
#let color-border = rgb("#E5E7EB")
#let color-error = rgb("#D93838")

#let global-tracking = -0.25pt
#let global-leading = 0.5em


// ==========================================
// MAIN TEMPLATE FUNCTION
// ==========================================

#let brandbook(title: "UP CURSOR Brand Book 2.0", body) = {
  set heading(numbering: "1.1")

  set page(
    paper: "a4",
    flipped: true, 
    margin: (left: 1in, right: 1in, top: 1in, bottom: 1in),
    
    header: context {
      let current-page = here().page()

      let all-h1 = query(selector(heading.where(level: 1)))
      let is-divider = all-h1.filter(h => h.location().page() == current-page).len() > 0
      if is-divider { return none }
      
      let all-h2 = query(selector(heading.where(level: 2)))
      
      let h2-on-page = all-h2.filter(h => h.location().page() == current-page)
      let h2-before = all-h2.filter(h => h.location().page() < current-page)
      
      let subsections = if h2-on-page.len() > 0 {
        h2-on-page.map(h => h.body)
      } else if h2-before.len() > 0 {
        (h2-before.last().body,)
      } else {
        ()
      }
      
      align(left)[
        #text(font: font-title, weight: weight-h1, size: size-small, fill: cursor-green)[UP CURSOR] #h(2em) #text(font: font-body, size: size-small, fill: cursor-black)[Brand Book 2.0] #if subsections.len() > 0 [
          #h(1fr)
          #subsections.map(name => text(font: font-body, size: size-small, fill: cursor-black, weight: weight-h1)[#name]).join(h(2em))
        ]
      ]
    },
    
    footer: context {
      let current-page = here().page()
      let all-h1 = query(selector(heading.where(level: 1)))

      let is-divider = all-h1.filter(h => h.location().page() == current-page).len() > 0
      if is-divider { return none }
      
      let h1-on-page = all-h1.filter(h => h.location().page() == current-page)
      let h1-before = all-h1.filter(h => h.location().page() < current-page)
      let page-num-str = str(counter(page).get().first())
      
      let section-name = if h1-on-page.len() > 0 {
        h1-on-page.first().body
      } else if h1-before.len() > 0 {
        h1-before.last().body
      } else {
        "INTRODUCTION"
      }
      
      set text(size: size-small, font: font-body, fill: color-footer)
      
      align(right)[
        #text(weight: weight-h1)[#section-name] 
        #h(2em) 
        #text(weight: weight-h2)[#page-num-str]
      ]
    },
    numbering: "1",
  )
  
  set text(font: font-body, size: size-body, fill: cursor-black, tracking: global-tracking)
  set par(leading: global-leading)
  
  show heading: it => {
    set block(above: 1.5em, below: 1em)
    
    if it.level == 1 {
      pagebreak(weak: true)
      let num = counter(heading).display()
      
      place(top + left, dx: -1in, dy: -1in)[
        #block(width: 297mm, height: 210mm, fill: cursor-green)[
          #place(bottom + left, dx: 1in, dy: -1in)[
            #align(left)[
              #text(font: font-body, size: size-h4, fill: color-white, tracking: 1pt, weight: weight-h1)[SECTION #num] \
              #v(-4em)
              #text(font: font-title, size: 72pt, fill: color-white, weight: weight-h1)[#it.body]
            ]
          ]
        ]
      ]
      pagebreak(weak: true)
      
    } else if it.level == 2 {
      let num = counter(heading).display()
      text(font: font-body, size: size-small, fill: cursor-green, weight: weight-h1, tracking: 1pt)[SECTION #num]
      linebreak()
      v(-1.5em)
      
      let heading-text = if it.has("label") and it.label == <lowercase> { it.body } else { upper(it.body) }
      text(font: font-heading, size: size-h2, fill: cursor-green, weight: weight-h2)[#heading-text]
      
    } else if it.level == 3 {
      text(font: font-heading, size: size-h3, fill: cursor-green, weight: weight-h3)[#it.body]
      
    } else if it.level == 4 {
      text(font: font-heading, size: size-h4, fill: cursor-green, weight: weight-h4)[#it.body]
      
    } else {
      it
    }
  }

  show figure.caption: it => {}
  
  body
}


// ==========================================
// BRANDBOOK COMPONENTS
// ==========================================

#let font-showcase(
  name: "Font Name",
  category: "Primary Typeface",
  description: [],
  notes: [],
  weights: ("Regular", "Bold"),
  font-family: font-body
) = {
  pagebreak(weak: true)
  v(1in)

  grid(
    columns: (1fr, 4fr),
    gutter: 4em,
    
    [
      #text(fill: cursor-green, weight: weight-h1, size: 1.4em, font: font-heading)[#category]
      #v(1.5em)
      #set text(size: size-body, fill: cursor-black, font: font-body)
      #description
      #v(3em)
      #line(length: 2in, stroke: 0.5pt + color-muted)
      #v(1.5em)
      #text(size: 9pt, fill: color-muted)[#notes]
    ],
    
    [
      #text(font: font-family, size: 7em, weight: weight-h1, fill:  cursor-green)[#name]
      #v(-6em)
      #line(length: 100%, stroke: 1pt + color-muted)
      #v(1em)
      
      #grid(
        columns: (2.5fr, 1fr),
        gutter: 5em,
        
        [
          #grid(
            columns: (2fr, 1fr),
            row-gutter: 1em,
            
            ..weights.map(w => (
              [
                #text(font: font-family, size: 2.5em, weight: lower(w))[
                  #w #text(style: "italic")[Italic]
                ]
              ],
              [
                #set text(font: font-family, size: 7pt, fill: cursor-black, weight: lower(w))
                abcdefghijklmnopqrstuvwxyz \
                ABCDEFGHIJKLMNOPQRSTUVWXYZ \
                01234567890—\$€£¥&
              ]
            )).flatten()
          )
        ],
        
        [
          #text(font: font-family, size: 2.5em, fill: cursor-black)[012345]
          #v(-2em)
          #text(font: font-family, size: 2.5em, fill: cursor-black, weight: weight-h1)[6789—]
          #v(-2em)
          #text(font: font-family, size: 2.5em, fill: cursor-black, weight: "black")[\$€£¥&]
        ]
      )
    ]
  )
}

#let type-row(role: "H1", specs: "Font Name, Size/Leading", body) = {
  grid(
    columns: (1.5in, 1fr),
    gutter: 2em,
    
    align(right)[
      #set text(size: size-small, font: font-body)
      #text(weight: weight-h1, fill: cursor-black)[#role]\
      #v(-0.5em)
      #text(fill: color-muted)[#specs]
    ],
    
    align(left)[
      #block()[#body] 
    ]
  )
}

#let color-swatch(
  name: "Color Name", 
  c: rgb("#000000"), 
  text-c: white,
  border: none,
  hex: "", 
  rgb-val: "", 
  cmyk: "", 
  pantone: none 
) = {
  block(
    width: 100%, 
    height: 100%,
    fill: c, 
    stroke: border,
    inset: 1.5em,
    radius: 4pt
  )[
    #text(font: font-heading, weight: weight-h2, size: 1.4em, fill: text-c)[#name]
    #v(1fr)
    
    #set text(font: font-body, size: size-body, fill: text-c)
    #grid(
      columns: (5em, 1fr),
      row-gutter: 0.6em,
      
      ..if pantone != none { (text(weight: weight-h1)[PMS], pantone) } else { () },
      text(weight: weight-h1)[CMYK], cmyk,
      text(weight: weight-h1)[RGB], rgb-val,
      text(weight: weight-h1)[HEX], hex
    )
  ]
}

#let color-swatch-compact(
  name: "Color Name", 
  c: rgb("#000000"), 
  text-c: white,
  border: none,
  hex: "", 
  rgb-val: "", 
  cmyk: "", 
  pantone: none 
) = {
  block(
    width: 100%, 
    height: 100%,
    fill: c, 
    stroke: border,
    inset: 1.2em,
    radius: 4pt
  )[
    #text(font: font-heading, weight: weight-h2, size: 1.1em, fill: text-c)[#name]
    #v(1fr)
    
    #set text(font: font-body, size: 8pt, fill: text-c)
    #grid(
      columns: (5em, 1fr), 
      row-gutter: 0.5em,
      
      ..if pantone != none { (text(weight: weight-h1)[PMS], pantone) } else { () },
      text(weight: weight-h1)[CMYK], cmyk,
      text(weight: weight-h1)[RGB], rgb-val,
      text(weight: weight-h1)[HEX], hex
    )
  ]
}

#let color-pairing(
  bg: cursor-white,
  fg: cursor-green,
  label: "Green on White",
  ratio: "4.5:1",
  pass: true
) = {
  block(
    width: 100%,
    height: 100%,
    fill: bg,
    radius: 4pt,
    stroke: if bg == color-white or bg == cursor-white { 1pt + color-border } else { none },
    inset: 1em
  )[
    #text(font: font-body, size: size-small, fill: fg, weight: weight-h1)[#label]
    #v(1fr)
    #align(center)[
      #text(font: font-title, weight: weight-h1, size: size-h2, fill: fg)[UP CURSOR]
    ]
    #v(1fr)
    #place(bottom + right)[
      #let badge-color = if pass { cursor-green } else { color-error }
      #let icon = if pass { "✓" } else { "✕" }
      
      #block(
        fill: color-white, 
        stroke: 1pt + badge-color, 
        inset: (x: 8pt, y: 5pt), 
        radius: 4pt
      )[
        #text(font: font-body, size: size-small, weight: weight-h2, fill: badge-color)[#icon  #ratio]
      ]
    ]
  ]
}

#let type-rule(pass: true, title: "Rule Title", desc: "Rule description", visual: []) = {
  block(width: 100%)[
    #block(
      width: 100%,
      height: 1.6in,
      fill: cursor-white,
      stroke: 1pt + color-border,
      radius: 4pt,
      inset: 1.5em
    )[
      #place(top + left)[
        #let badge-color = if pass { cursor-green } else { color-error }
        #let icon = if pass { "✓  DO" } else { "✕  DON'T" }
        #text(font: font-body, size: size-small, weight: weight-h2, fill: badge-color)[#icon]
      ]
      
      #align(center + horizon)[#visual]
    ]
    
    #v(0.8em)
    
    #text(font: font-body, weight: weight-h1, size: size-body, fill: cursor-black)[#title] \
    #v(-0.2em)
    #set text(font: font-body, size: size-small, fill: color-muted)
    #desc
  ]
}

#let wireframe(w: 100%, h: 100%, label: "") = {
  block(
    width: w,
    height: h,
    fill: cursor-white,
    stroke: (paint: color-muted, thickness: 1pt, dash: "dashed"),
    align(center + horizon)[
      #text(fill: color-muted, weight: "bold", size: size-h3)[#label]
    ]
  )
}

#let asset-folder(name: "", desc: "", path: "", target: "") = {
  block(
    width: 100%,
    stroke: 1pt + rgb("#E5E7EB"),
    radius: 6pt,
    fill: white,
    [
      #block(
        width: 100%, 
        fill: rgb("#F6F7F8"), 
        inset: (x: 1em, y: 0.6em),
        radius: (top: 6pt),
        stroke: (bottom: 1pt + rgb("#E5E7EB"))
      )[
        #text(font: "DejaVu Sans Mono", size: 9pt, weight: "bold", fill: cursor-green)[\> ]
        #text(font: "DejaVu Sans Mono", size: 9pt, fill: color-muted)[#path]
      ]
      
      #block(inset: 1.5em)[
        #text(font: font-heading, weight: "extrabold", size: 14pt, fill: cursor-black)[#name]
        #v(0.5em)
        #text(font: font-body, size: 10pt, fill: color-muted)[#desc]
        #v(1em)
        
        // Link Button
        #link(target)[
          #block(
            fill: cursor-green,
            radius: 4pt,
            inset: (x: 1.5em, y: 0.8em)
          )[
            #text(font: font-body, weight: "bold", size: 10pt, fill: white)[Access Files \u{2192}]
          ]
        ]
      ]
    ]
  )
}