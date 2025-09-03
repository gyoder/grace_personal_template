#import "@preview/rose-pine:0.2.1": apply, rose-pine-moon
#let grace_template(
  title: "Document Title",
  author: "Grace Yoder",
  subtitle: none,
  course: none,
  date: datetime.today(),
  header-color: rose-pine-moon.overlay,
  footer-color: rose-pine-moon.overlay,
  text-color: white,
  font-size: 11pt,
  doc
) = {
  set document(title: title, author: author, date: date)
  set page(
    paper: "us-letter",
    margin: (top: 2.2cm, bottom: 2.2cm, left: 2cm, right: 2cm),
    header: context {
      set text(fill: text-color, size: font-size, style: "italic")
      let page-num = counter(page).get().first()

      if page-num != 1 {
        rect(
          width: 100%,
          height: .8cm,
          fill: header-color,
          radius: .5em,
          stroke: none,
          inset: (x: 1em, y: 0em),
          [
            #set align(center + horizon)
            #grid(
              columns: (1fr, auto),
              align: (left + horizon, right + horizon),
              [#title],
              [#date.display("[year].[month].[day]")]
            )
          ]
        )
      }
    },
    footer: [
      #set text(fill: text-color, size: font-size, style: "italic")
      #rect(
        width: 100%,
        height: 0.8cm,
        fill: footer-color,
        radius: .5em,
        stroke: none,
        inset: (x: 1em, y: 0em),
        [
          #set align(center + horizon)
          #grid(
            columns: (1fr, auto),
            align: (left + horizon, right + horizon),
            [#if author != none [#author] else []],
            [#context counter(page).display()]
          )
        ]
      )
    ]
  )
  set text(font: "Montserrat", size: 11pt)
  set par(justify: true, leading: 0.75em)
  show math.equation: set text(font: "Fira Math", fallback: false)
  set raw(theme: rose-pine-moon.codeThemePath)
  show raw: it => [
    #set text(fill: rose-pine-moon.text)

    #box(
      fill: rose-pine-moon.overlay,
      outset: 4pt,
      radius: 5pt,
      it
    )
  ]

  show heading.where(level: 1): it => [
    #set text(size: 18pt, weight: "bold")
    #pad(top: 1.2em, bottom: 0.6em)[#it]
  ]
  show heading.where(level: 2): it => [
    #set text(size: 15pt, weight: "bold")
    #pad(top: 1em, bottom: 0.4em)[#it]
  ]
  show heading.where(level: 3): it => [
    #set text(size: 13pt, weight: "bold")
    #pad(top: 0.8em, bottom: 0.3em)[#it]
  ]
  place(top + center, dy: -1.5cm,
    rect(
      width: 100%,
      height: auto,
      fill: header-color,
      radius: .5em,
      stroke: none,
      inset: (x: 1em, y: 0em),
      [
        #set align(center + horizon)
        #set text(fill: text-color, size: font-size, weight: "medium")
        #v(1em)
        #grid(
          columns: (1fr),
          rows: (auto, auto, auto),
          row-gutter: 1em,
          [
            #set text(size: font-size + 8pt, weight: "bold")
            #title
          ],
          [
            #if subtitle != none [
              #set text(size: font-size + 4pt, weight: "light", style: "italic")
              #subtitle
            ]
          ],
          [
            #set text(size: font-size + 2pt, weight: "regular")
            #v(2em)
            #grid(
              columns: (1fr, 1fr, 1fr),
              align: (left, center, right),
              [#if author != none [#author]],
              [#if course != none [#course]],
              [#date.display("[month repr:long] [day padding:none], [year]")]
            )
            #v(1em)
          ]
        )
      ]
    )
  )
  v(8em)

  doc
}
