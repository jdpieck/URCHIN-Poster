#import "@preview/oasis-align:0.4.1": *

#let re-route = "/reports/src/"


// ==========================================
// 1. INTRODUCTION / MOTIVATION
// ==========================================
#let intro-text = [
  Underwater construction is hazardous and resource-intensive~@tell2025NavigatingChallengesUnderwater~@melenbrink2020OnsiteAutonomousConstruction. Robotic automation enables safer, scalable assembly; however subsea manipulation suffers from high spatial uncertainty. We propose *URCHIN*: a modular voxel system using specialized geometry and passive magnetic alignment to overcome marine manipulation errors.
]

#let intro-bullets = [
  Key contributions include:

  - *Self-Aligning Interface:* Magnetostatic model predicts inter-voxel pull forces for passive snapping without high-precision sensing.

  - *Manipulator-Agnostic:* Grasp-optimized geometry fits standard commercial parallel-jaw grippers.

  - *Localization-Ready:* Integrated slots for fiducial tracking markers.
]

#let fig-master = [
  #figure(
    image(
      "../figures/master.jpg",
    ),
    caption: [
      (A)~A REACH Robotics Alpha Arm moves an URCHIN voxel into position. (B)~The released voxel drops into initial misalignment. (C)~Passive magnetic attraction aligns and snaps the voxel into place.
    ],
  ) <fig:master>
]

#let sec-intro = [
  = Introduction///Motivation
  #intro-text
  #intro-bullets
  #fig-master
]


// ==========================================
// 2. RELATED WORK
// ==========================================
#let related-work-text = [
  = Related Work
  - *Underwater Assembly:* Unlike systems requiring top-down constraints or custom end-effectors~@lensgraf2021DropletAutonomousUnderwater, URCHIN works with general-purpose robotic arms.

  - *The Connector Problem:* Replaces complex mechanical fasteners with passive magnetic alignment under spatial uncertainty.

  - *Force Modeling:* Introduces a reciprocal cubic model optimized for close-range magnetic planning where standard FEM/analytical models diverge.
]


// ==========================================
// 3. ARCHITECTURE
// ==========================================

#let fig-labeled-voxel = [
  #figure(
    image("../figures/voxel.jpg"),
    // image(re-route + "figures/voxel.png"),
    caption: [
      URCHIN voxel component overview and defining features
    ],
  ) <fig:labeled_voxel>
]

#let fig-section-view = [
  #figure(
    image("../figures/section_view.png"),
    // image(re-route + "figures/section_view.png"),
    caption: [
      Section view showing interlocking anti-shear node geometry
    ],
  ) <fig:section_view>
]

#let fig-sizes = [
  #figure(
    image("../figures/sizes.png"),
    caption: [
      Scalable module geometry
      // (4 in, 6 in, and 8 in prototypes).
    ],
  ) <fig:sizes>
]

#let fig-snap-diagram = [
  #figure(
    image("../figures/snaping_diagram.pdf"),
    caption: [
      Evaluated snapping directions
    ],
  ) <fig:snap_diagram>
]

#let fig-explode = [
  #figure(
    image("../figures/explode.png"),
    // image(re-route + "figures/explode.png"),
    caption: [
      Exploded view showing internal structure and leg geometry.
    ],
  ) <fig:explode>
]

#let fig-pattern = [
  #figure(
    image("../figures/pattern.png"),
    caption: [
      Magnetic leg configurations
    ],
  ) <fig:pattern>
]

#let fig-arch-row1 = [
  #oasis-align(
    max-iterations: 50,
    fig-labeled-voxel,
    fig-explode,
  )
]

#let fig-arch-row2 = [
  #oasis-align(
    force-frac: .53,
  )[
    #oasis-align(
      fig-snap-diagram,
      fig-sizes,
    )
  ][
    #oasis-align(
      // override: true,
      fig-section-view,
      fig-pattern,
    )
  ]
]

#let arch-bullets = [
  - *Parallel-Jaw Compatibility:* Flat-parallel faces fit standard commercial grippers.

  - *Passive Magnetic Alignment:* N52 neodymium magnets draw modules together across positional~offsets.

  - *Shear Resistance:* Interlocking male-female node geometry transfers off-axis shear loads directly through structural features.

  - *Buoyancy Mitigation:* Internal gyroid infill vents allow complete water flooding during submersion.

  - *Structural Rigidity:* Internal aluminum hexagonal braces lock shell halves against bending and torsion.
]

#let sec-architecture = [
  = Architecture
  URCHIN is guided by the following core design principles:
  #arch-bullets
  #fig-arch-row1
  #fig-arch-row2
]


// ==========================================
// 4. MODELING
// ==========================================

#let model-interaction-body = [
  A reciprocal cubic model captures near-field ($1/d^2$) and far-field ($1/d^4$) inter-voxel pull force $F_"est"(d)$ as a function of separation distance $d$:

  $ F_"est" (d) = frac(a K, b d^3 + c d^2 + e d + f) $ <eq:cube_fit>

  where $K = pi B^2 R^4 / mu$. Empirical parameters ($a, b, c, e, f$) are solved via nonlinear optimization.
]

#let model-bending-body = [
  Max allowable external point load $F_"applied"$ at the center of an $N$-voxel cantilevered chain before joint detachment:

  $ F_"applied" <= frac(l / L F_"ref" - 1 / 2 N^2 W, N - 1 / 2) $ <eq:f_applied>

  where $F_"ref"$ is contact pull force, $l$ is moment arm, $L$ is voxel length, and $W$ is submerged weight.
]

#let subsec-model-interaction = [
  == Voxel-to-Voxel Interaction Model
  #model-interaction-body
]

#let subsec-model-bending = [
  == Analytical Bending Model
  #model-bending-body
]

#let sec-modeling = [
  = Modeling
  #oasis-align(
    int-frac: .5,
    // force-frac: .42,
    // columns: (1fr, 1.35fr),
    subsec-model-interaction,
    subsec-model-bending,
  )
]



// ==========================================
// 5. EXPERIMENTS
// ==========================================
#let exp-snapping-text = [
  Evaluated snapping limits using a 4-DOF REACH Alpha Arm. Demonstrated reliable passive alignment underwater up to:
  #v(-.3em)
  - *Top-Down Offset:* 4.44 cm (1.75 in)
  - *Side-In Offset:* 1.90 cm (0.75 in)
  - *Bottom-Up Offset:* 1.51 cm (0.59 in)
]

#let fig-snap = [
  #figure(
    image(
      "../figures/snap_success.pdf",
    ),
    caption: [
      Snap success rates for top-down and side-in configurations underwater vs. land (10 trials per offset).
    ],
  ) <fig:snap>
]

#let subsec-exp-snapping = [
  == Snapping Distances
  #exp-snapping-text
  #fig-snap
]

#let exp-pull-text = [
  Used a tensile testing system to determine:
  #v(-.3em)
  - *Mean Contact Separation Force:* $64.8 plus.minus 5.95 "N"$.
  - *Model Accuracy:* Reciprocal cubic model achieved an *RMSE of 0.118 N*—a *20#sym.times error reduction* over standard Zurek models~@zurek2022PerformanceClosedformEquations.
]

#let fig-pull-force = [
  #figure(
    image(
      "../figures/magnet_pull_force_plot_newton.pdf",
    ),
    caption: [
      Measured magnet pull force between voxel faces vs. Zurek's model~@zurek2022PerformanceClosedformEquations and fitted reciprocal cubic model (@eq:cube_fit).
    ],
  ) <fig:pull_force_lbf>
]

#let subsec-exp-pull = [
  == Pull Force Verification
  #exp-pull-text
  #fig-pull-force
]

#let exp-bending-text = [
  Tested submerged cantilevered chains ($N = 1 "to" 4$) using an external pulley rig.
  Experimental detachment loads matched predictions by @eq:f_applied within *14.90% average error* across all chain lengths.
]

#let fig-bending = [
  #figure(
    image(
      "../figures/bending.pdf",
    ),
    caption: [
      Maximum point load vs. distance from fixed end for cantilevered voxel chains.
    ],
  ) <fig:bending>
]

#let subsec-exp-bending = [
  == Bending Failure
  #exp-bending-text
  #fig-bending
]

#let exp-assembly-text = [
  Executed unassisted placement in 1D, 2D corner, and 3D vertex configurations under initial misalignments. Successfully assembled complex structures (arches, overhangs, branching chains).
]

#let fig-structures = [
  #figure(
    image(
      "../figures/structures.png",
    ),
    caption: [
      Examples of structures autonomously assembled from URCHIN voxels.
    ],
  ) <fig:structures>
]

#let subsec-exp-assembly = [
  == Autonomous 1D/2D/3D Assembly
  #exp-assembly-text
  #fig-structures
]

#let sec-experiments = [
  = Experiments & Results
  #grid(
    columns: (1fr, 1fr),
    subsec-exp-snapping, subsec-exp-pull,
    subsec-exp-bending, subsec-exp-assembly,
  )
]


// ==========================================
// 6. RESULTS & CONCLUSION
// ==========================================
#let sec-results = [
  = Results
  - *High-Tolerance Alignment:* Reliably snapped underwater at offsets up to *4.44 cm (1.75 in)* top-down and *1.90 cm (0.75 in)* side-in.
  - *Model Accuracy:* Reciprocal cubic model achieved an *RMSE of 0.118 N* (*20x error reduction* over standard analytical models).
  - *Bending Validation:* Detachment loads matched predictions within *14.90% average error*.
  - *Autonomous Assembly:* Achieved consistent snapping across multi-axis releases to form complex overhangs and arches.
]

#let sec-conc = [
  = Conclusion
  - Passive magnetic alignment successfully mitigates spatial uncertainty in underwater construction.
  - *Future Work:* Integration of passive mechanical interlocks for long-term structural viability and testing in dynamic marine environments.
]

// ==========================================
// 7. ACKNOWLEDGEMENTS & BIBLIOGRAPHY
// ==========================================
#let ack-text = [
  This work was supported in part by ONR awards N00014-22-1-2114 & N00014-23-1-2171, and NSF awards 2349747 & 2437138. We thank #box[Christopher] Holm and Brian Van Stratum for design feedback, and the Robotic Decision Making Laboratory (RDML) for support.
]

#let sec-bib = [
  #set text(.7em)
  #set par(justify: false)
  #bibliography("bibliography.bib", style: "ieee")
]

#let sec-ack = [
  #set text(.7em)
  = Acknowledgements
  #ack-text
]


// #{
//   let logo-height = 2in
//   box(
//     // fill: white,
//     height: logo-height,
//     width: logo-height,
//     // width: (logo-height * 1.1),
//     // clip: false,
//     place(
//       center + horizon,
//       float: false,
//       image(
//         "../logos/NSF_1200ppi.png",
//         alt: "National Science Foundation Logo",
//         height: (logo-height * 1.1),
//       ),
//     ),
//   )
// }
