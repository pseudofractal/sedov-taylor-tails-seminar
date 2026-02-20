#import "@preview/polylux:0.4.0": *
#import "@preview/physica:0.9.5": *
#import "@preview/lilaq:0.5.0" as lq
#import "@preview/pinit:0.2.2": *
#set page(paper: "presentation-16-9", fill: rgb("#1e1e2e"))

#set text(size: 25pt, fill: rgb("#cdd6f4"), font: "Maple Mono")
#show heading: set text(fill: rgb("#74c7ec"))
#show heading: set align(center)

#let emph(term) = text(fill: rgb("#94e2d5"), term)
#let important(term, size: 30pt) = text(fill: rgb("#b4befe"), size, align(
  center,
  box(
    stroke: 2pt + rgb("#94e2d5"),
    outset: 15pt,
  )[#term],
))

#let funsies(term) = place(
  bottom + center,
  dx: 0pt,
  dy: 30pt,
  block(
    width: 100%,
    align(left)[#text(size: 20pt, fill: rgb("#fab387"), term)],
  ),
)

#slide[
  #set align(horizon)
  #heading[#text(
    fill: rgb("#eba0ac"),
    size: 40.5pt,
  )[Dating Supernovae for Dummies!]]

  Kshitish Kumar Ratha

  #v(1em)

  #text(
    size: 20pt,
    fill: rgb("#74c7ec"),
  )[How Grade 12 physics is sometimes enough.]

  #funsies[Look out for these fun bits]
]

#slide[
  === The Cataloger and His First Object

  #place(
    top + right,
    dx: 65pt,
    dy: 305pt,
    rotate(-35deg)[#image("./assets/crabby.png", height: 5em)],
  )

  #grid(
    columns: (1fr, 1fr),
    gutter: 2em,
    align: center + horizon,
    figure(
      image("./assets/charles_messier.jpg", height: 65%),
      caption: "Charles Messier",
    ),
    figure(
      image("./assets/crab_nebula.jpg", height: 65%),
      caption: "Crab Nebula (M1)",
    ),
  )
]

#slide[
  #v(-1em)
  === The Cosmic Tug-of-War
  #v(1em)
  #grid(
    columns: (2fr, 1fr),
    gutter: 0.25em,
    align: horizon,
    [
      A delicate balance:
      - #emph[Inward Force of Gravity.]
      - #emph[Outward Force of Nuclear Fusion.]
      *When the fuel runs out...* \
      Gravity wins instantly. The core collapses, bounces, and sends a massive wall of energy outwards.
    ],
    [
      #figure(
        image("./assets/stellar_balance.png"),
      )
    ],
  )

  #funsies[Spoiler alert: Gravity always wins in the end.]
]

#slide[
  #v(-1em)
  === The Interstellar Snowplow
  #v(1em)
  #grid(
    columns: (2fr, 1fr),
    gutter: 0.25em,
    align: horizon,
    [
      The shockwave doesn't just pass through empty space; it acts like a snowplow:
      - Sweeps up surrounding material.
      - Compresses and heats the gas.
      - Leaves behind beautiful, glowing structures.
    ],
    [
      #figure(
        image("./assets/snowplow.png"),
      )
    ],
  )
  #v(0.2em)

  #important[The Big Question: When did this happen?]
]

#slide[
  === Math to the Rescue: Dimensional Analysis
  #v(1em)
  How does a shockwave radius ($R$) evolve? It depends on:
  #v(1em)

  - Energy of explosion ($E$): $[M L^2 T^(-2)]$
  - Density of medium ($rho$): $[M L^(-3)]$
  - Time ($t$): $[T]$

  #v(1em)
  #emph[$ R = "const." times E^a times rho^b times t^c $]
]

#slide[
  === Crunching the Dimensions
  #v(2em)
  Let's equate the dimensions on both sides:
  $
              R & = "const." times E^a times rho^b times t^c \
              L & = (M L^2 T^(-2))^a times (M L^(-3))^b times T^c \
    M^0 L^1 T^0 & = M^(a+b) times L^(2a-3b) times T^(-2a+c)
  $
  #v(1em)

  We end up with 3 equations and 3 variables, a system we know how to solve.
]

#slide[
  === Some More Math Exposition
  #v(2em)
  Solving the algebra:
  #v(1em)
  $
      a + b & = 0 => b = -a            &           quad "Mass" \
    -2a + c & = 0 => c = 2a            &           quad "Time" \
    2a - 3b & = 1 => 5a = 1 => a = 1/5 & "      "quad "Length"
  $

  #funsies[Behold, the power of Grade 12 physics!]
]

#slide[
  #v(-1em)
  === The Sedov-Taylor Solution
  #v(1em)
  Equating the dimensions gives us:
  $ R(t) = ((E t^2)/rho)^(1/5) $

  #v(0.5em)

  Plugging in the Crab Nebula's stats:
  - $R ~ 5.5 "ly"$, $E ~ 10^(50) "ergs"$, $rho ~ 15 "atoms"/"cm"^3$

  $ t = sqrt((R^5 rho)/E) ~ 1000 "years" $
]

#slide[
  #v(-1.25em)
  === The Guest Star of 1054 AD
  #v(0.25em)
  #align(center)[#image("./assets/guest_star_of_1054.png", width: 95%)]
]

#slide[
  #v(-1em)
  === The Snowplow Slows Down
  #v(1em)
  Does the shockwave expand forever? No.

  - As it accumulates more "snow" (interstellar gas), the mass increases.
  - The gas left behind cools down, leading to #emph[radiative losses].
  - The explosion is no longer energy-conserving!

  #v(0.75em)

  #important[
    Welcome to the Radiative Phase!
  ]
]

#slide[
  === Conserving Momentum
  #v(1em)
  The shockwave sweeps up a shell of mass:
  $ M ~ rho R^3 $

  Assuming momentum ($P$) is conserved:
  $
            P & ~ M v ~ rho R^3 v \
    rho R^3 v & ~ "const." \
            v & prop R^(-3)
  $

  #funsies[Still no complex fluid dynamics required!]
]

#slide[
  === A Little Calculus
  #v(2em)
  Let's turn that relationship into a differential equation:
  #v(1em)
  $
            v & = dv(R, t) \
     dv(R, t) & prop R^(-3) \
    R^3 dd(R) & prop dd(t)
  $
]

#slide[
  === A Bit More Doesn't Hurt
  #v(2em)
  Integrating both sides:
  #v(1em)
  $
    integral R^3 dd(R) & prop integral dd(t) \
                 R^4/4 & prop t \
                  R(t) & prop t^(1/4)
  $
  #place(
    top + right,
    dx: 85pt,
    dy: -25pt,
    rotate(-10deg)[#image("./assets/messier_oh_no.png", height: 7.5em)],
  )
]

#slide[
  #v(-1em)
  === The Biphasic Model
  #v(1em)
  We now have a simple two-part model for a supernova's life:

  + #emph[Sedov-Taylor Phase] (Energy Conserved)
    - Radius: $R(t) prop t^(2/5)$
    - Velocity: $v(t) prop t^(-3/5)$

  #v(0.5em)
  + #emph[Radiative Phase] (Momentum Conserved)
    - Radius: $R(t) prop t^(1/4)$
    - Velocity: $v(t) prop t^(-3/4)$

  #funsies[Notice how it slows down faster in phase 2? Math proves it!]
]

#slide[
  #v(-1em)
  === The Proof Is In The Plot
  #figure(image("./assets/snr_rt.png", height: 95%))

  #funsies[Sometimes Simple Scaling Laws Are Enough! Thank you!]
]

#slide[
  === References
  #set text(size: 20pt)
  #bibliography("references.bib", title: none, full: true, style: "ieee")
]
