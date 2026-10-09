#let today = datetime.today().display("[month repr:long] [day], [year]")
#let LANL_Blue = oklab(37.69%, -0.022, -0.134)
#import "content.typ": sec-ack, sec-bib
#import "@preview/tiaoma:0.3.0"

#let poster(
  title: "",
  authors: (),
  body,
) = {
  set document(
    author: authors.map(a => (a.name,).flatten().join(", ")),
    title: title,
  )

  set page(
    paper: "ansi-e",
    height: 36in,
    width: 56in,
    margin: (
      // bottom: 2in,
      rest: 1in,
    ),
  )

  set text(
    font: "Arial",
    lang: "en",
    30pt,
  )

  set par(
    justify: true,
    leading: .55em,
  )
  set grid(gutter: 1.5em)

  set heading(numbering: none)
  show heading: set text(LANL_Blue)

  show heading.where(level: 1): it => {
    set text(1.25em, weight: "bold")
    block(
      it.body,
      above: 1em,
      // below: 0.4em,
    )
  }

  show heading.where(level: 2): it => {
    set text(.8em, weight: "bold", tracking: 1.5pt)
    // v(.5em)
    block(upper(it.body))
  }

  set math.equation(
    numbering: "(1)",
  )

  // In-Line Code
  show raw.where(block: false): box.with(
    fill: luma(240),
    inset: (x: 3pt, y: 0pt),
    outset: (y: 3pt),
    radius: 2pt,
  )

  // Code Block
  show raw.where(block: true): block.with(
    fill: luma(96%),
    inset: 10pt,
    radius: 4pt,
  )

  show list: set par(justify: false)
  show list.where(tight: false): set par(spacing: .8em)

  show figure.caption: set text(
    .8em,
    fill: LANL_Blue,
  )

  show figure.caption: set par(justify: false)


  show bibliography: set par(
    spacing: .9em
  )

  // Title
  context {
    let styled-title = {
      text(
        76pt,
        LANL_Blue,
        weight: "bold",
        par(
          leading: .5em,
          title,
        ),
      )
    }

    set stack(
      spacing: .45in,
    )
    show stack: set align(horizon)
    // set image(
    //   height: 2in
    // )
    let logo-height = measure(
      block(
        styled-title,
      ),
    ).height

    let school-width = 5.25in

    place(
      top,
      float: true,
      grid(
        columns: (1fr, auto, 1fr),
        stack(
          dir: ltr,
          move(
            dy: (school-width * -.02),
            image(
              "../logos/OSU.svg",
              alt: "Oregon State University Logo",
              width: school-width,
            ),
          ),
          h(.7in),
          image(
            "../logos/UCD.svg",
            alt: "University of California, Davis Logo",
            width: (school-width * 1),
          ),
        ),
        align(
          center,
          styled-title,
        ),
        align(
          right,
          stack(
            dir: rtl,
            image(
              "../logos/Regular Paper Graphic.svg",
              alt: "Regular Paper Label",
              height: logo-height,
            ),
            image(
              "../logos/O26M.png",
              alt: "OCEANS 2026 Conference Logo",
              height: (logo-height * 1.07),
            ),
            image(
              "../logos/OES.png",
              alt: "IEEE Oceanic Engineering Society Logo",
              height: logo-height,
            ),
          ),
        ),
      ),
    )
  }

  context {
    // show rect: set align(horizon)
    set text(
      // white,
      .9em,
    )
    // set image(height: )
    let logo-height = measure(
      block(
        width: 9in,
        sec-ack,
      ),
    ).height

    place(
      bottom,
      float: false,
      rect(
        fill: rgb("#E5ECF6"),
        width: 100%,
        
        // height: 2in,
        inset: (
          // left: 1.5in,
          rest: 0.5in,
        ),
        grid(
          columns: (9in, 2fr, auto, auto),
          column-gutter: 2em,
          align: top,
          // column-gutter: 1.5in,
          sec-ack,
          sec-bib,
          stack(
            dir: ltr,
            spacing: 2em,
            box(
              // fill: white,
              height: logo-height,
              // width: logo-height,
              width: (logo-height * 1.1),
              // clip: false,
              place(
                center + horizon,
                float: false,
                image(
                  "../logos/NSF_1200ppi.png",
                  alt: "National Science Foundation Logo",
                  height: (logo-height * 1.1),
                ),
              ),
            ),
            h(1.8em),
            image(
              "../logos/ONR.png",
              alt: "Office of Naval Research Logo",
              height: logo-height,
            ),
            image(
              "../logos/SOI.svg",
              alt: "Schmidt Ocean Institute Logo",
              height: logo-height,
            ),
          ),
          {
          link(
            "https://youtu.be/fF1kQjQwKIU?si=J2sV9zELxlGbCdGg",
            tiaoma.qrcode(
              options: (scale: 3.0),
              "https://youtu.be/fF1kQjQwKIU?si=J2sV9zELxlGbCdGg",
            ),
          )
          place(
            center,
            dy: 0.1in,
            text(.7em)[(link to video)]
          )

          }
        ),
      ),
    )
  }

  // Author Information
  rect(
    inset: 1em,
    fill: LANL_Blue,
    width: 100%,
    align(
      center,
      text(
        white,
        1em,
        [
          #strong[
            #authors.at(0).name#super[1],
            #authors.at(1).name#super[2],
            #authors.at(2).name#super[2]
          ]
          // \
          --
          #super[1]#authors.at(0).affiliation
          #authors.at(0).department,
          #super[2]#authors.at(1).affiliation
          #authors.at(1).department
        ],
      ),
    ),
  )
  v(.25em)

  body
}
