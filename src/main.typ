#import "template.typ": *
#import "@preview/oasis-align:0.4.1": *
#import "content.typ": *

#show: poster.with(
  title: "URCHIN – Underwater Robotic Construction \n Modules Using High-Tolerance Interlocking Nodes",
  authors: (
    (
      name: "Jason Daniel Pieck", 
      affiliation: "UC Davis",
      department: "Mechanical and Aerospace Engineering Department",
      email: "jdpieck@ucdavis.edu"
    ),
    (
      name: "Akshaya Agrawal", 
      affiliation: "Oregon State University",
      department: "Collaborative Robotics and Intelligent Systems (CoRIS Institute)",
      email: "agrawaak@oregonstate.edu"
    ),
    (
      name: "Geoffrey A. Hollinger",
      affiliation: "Oregon State University",
      department: "Collaborative Robotics and Intelligent Systems (CoRIS Institute)",
      email: "geoff.hollinger@oregonstate.edu"
    ),
  )
)

#set image(width: 100.0%)


// #let outer-column-widths = 1.5fr
#grid(
  // columns: (1fr, 1.4fr, 1.5fr),
  columns: (.9fr, 1.4fr, 1.4fr),
  // columns: (outer-column-widths, 2fr, outer-column-widths),
  column-gutter: 2em,
  [
    #sec-intro
    // #sec-related-work
  ],
  [
    #sec-architecture
    #sec-modeling
  ],
  [
    #sec-experiments
    // #sec-results
    // #sec-acknowledgements
    #sec-conc
    // #sec-bib
  ]
)
