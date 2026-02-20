#import "@preview/physica:0.9.8": *

=== 00:00

We start with a cold night of 1758, where Charles an astronomer was observing the sky with his telescope. Just like like today, the funding of a scientist was stuck on the whims of the rich, and Charles was no exception. The richest man in the land was of course the kind, and the easiest way to appease the king as an astronomer was to find something in the sky that could be named after him. So Charles was looking for new things, particularly comets, something that made the Halley guy so famous.

He moved his telescope slowly looking at the sky trying to find something -- anything. And suddenly he saw it, near the horn of the constellation of Taurus, a bright patch of sky. He was excited that he had discovered a comet, and wanted to estimate its trajectory so he could show it to the King the next day; so he waited and waited and waited but the patch didn't move one bit?

Charles became very grumpy, and angrily made note of the location of the object and numbered it 1. He thought he would make a list of these objects so as to not get tricked by the same one twice. He had discovered The Crab Nebula.

=== 01:30

So what exactly was it? Well let's with a star, which exists in a balance of power. A giant tug of war between gravity wanting to crush it and nuclear fusion trying to keep it inflated. And this works out for a while, but eventually the fuel runs out and gravity wins instantly. The core collapses, bounces and sends a "wall of energy outwards".

This wall of energy slams into the outer layer of the star but doesnt stop there, like a snowplow picking up snow, it pcisk up everything in its path, compressing it, heating it and then ultimately spreading it over a region, giving us these beautiful structures.

But, a supernova is a violent event, literally meaning "new star", they can outshine other galaxies and stars for a period of time. Someone must have seen it happen and maybe recorded it somewhere. So we need to figure out an estimate on when it could have happened. To find this, we need to figure out how much the shockwave has expanded over the period of time.

=== 03:00

To answer how a big explosion evolves in space, we can try to relate it to a big explosion here on earth. We go back to the second world war, where two physicist had the difficult job of estimating the energy output of the Trinity tests just by looking at the photos of the glowing fireball.

Turns out the exact answer is messy and requires the solving of complex fluid dynamics simulations. But to find a rough estimate, basic dimensional analysis will take us very far.

So let's start by thinking, what will the radius of this shockwave depend on. The easiest one to come up with is time, over time we expect the radius to increase. It will also depend on the energy produced by the explosion, the more energy the bigger the shockwave. Finally, it should also depend on the density of the sorrounding medium, the more dense the medium the harder it is for the shockwave to expand. We can maybe think about n other parameters but these are the simplest ones and we start with them.

Lets perform dimensional analysis, we have three parameters and three dimensions, so we can find a unique solution. We can write the radius as a product of the parameters raised to some power, and then we can solve for the powers by equating the dimensions on both sides.
- $E = [M L^2 T^(-2)]$
- $rho = [M L^(-3)]$
- $R = [L]$
- $t = [T]$

Let's equate: the dimensions:$
R &= "const." times E^a times rho^b times t^c \
L &= (M L^2 T^(-2))^a times (M L^(-3))^b times T^c \
M^0 times L^1 times T^1 &= M^(a+b) times L^(2a-3b) times T^(-2a+c)
$

Solving the algebra:$
a + b &= 0 => b = -a & arrow.long "Mass"\
-2a + c &= 0 => c = 2a & arrow.long "Time"\
2a - 3b &= 1 => 5a = 1 => a = 1/5 #h(3em) & arrow.long "Length"
$

Putting these values in $
R(t) = ((E t^2)/rho)^(1/5)
$

And voila, we have a formula for the radius of the shockwave as a function of time, energy and density. This is called the Sedov-Taylor solution, and it is a very good approximation for the evolution of a shockwave in space.

Let's put in the values:
- $R ~ 5.5 "ly" ~ 5 times 10^(18) "cm"$
- $E ~ 10^(50) "ergs"$
- $rho ~ 15 "atoms"/"cm"^3 ~ 2.5 times 10^(-23)$

$
t &= sqrt((R^5 rho)/E) \
t &= sqrt(((5 times 10^(18))^5 times 2.5 times 10^(-23))/(10^(50))) \
t &~ 3 times 10^(10) "s" ~ 1000 "years"
$

And sure enough in the year 1054, Chinese astronomers recorded a "guest star" that was visible in the day time for 23 days, and was visible in the night sky for almost two years.

===

Okay so now we have found that the radius of a supernova increases wrt to time, but will it keep on increasing infinitely? Well let's go back to the snowplow example, the snowplow keeps picking up and accumulating more and more snow but due to the increasing force it will slow down right. So this too has to slow down. And again doing some simple physics, we can show that $ v = dv(R, t) prop dv(, t) t^(2/5) prop t^(- 3/5) $
Eventually this will slow down enough that that radiative losses from the hot gas left behind by the shockwave becomes important. Now the explosion is not energy conserving and the remnant enters the radiative phase where momentum is conserved.

It may feel like we need to introduce fluid dynamics, but basic dimensional anlysis is still ready to carry us ahead.

The shockwave has been sweeping up all the mass and has been carrying it outwards, so there is a shell of mass formed around it which has a mass$ M ~ rho R^3 $
Therefore the momentum of the shockwave is $ P ~ M v ~ rho R^3 v $ which we will assume to be constant in this phase. Therefore:$ P &~ "const." \ rho R^3 v &~ "const." \ v & prop 1/R^3 $

Turning this into a differential equation:$
v &= dv(R, t) \ dv(R, t) & prop R^(-3) \ R^3 dd(R) & prop dd(t) \
integral R^3 dd(R) & prop integral dd(t) \ R^4/4 &prop t \ R(t) &prop t^(1/4)
$

The velocity can be similarly calculated by:$
v = dv(R, t) prop t^(- 3/4)
$

Therefore the expansion slows down, and we get a simple biphasic model.

1. Sedov-Taylor phase: $R(t) prop t^(2/5)$, $v(t) prop t^(- 3/5)$ and energy conserved.
2. Radiative phase: $R(t) prop t^(1/4)$, $v(t) prop t^(- 3/4)$ and momentum conserved.

=== 

A theory is incomplete without some experimental verification, so let's see if we can find some evidence for this model.

When astronomers look at a population of supernova remnants and plot their size against their estimated age on a logarithmic scale, a beautiful and satisfying pattern emerges. Because we are using a log-log scale, the exponents we just derived become the slopes of the graph.

For the younger remnants, we see the data points neatly line up with a slope of 0.4, which perfectly matches the 2/5 power law of our energy-conserving Sedov-Taylor phase. And as we look at older remnants, the slope distinctly flattens out to 0.25, exactly matching the 1/4 power law of our momentum-conserving radiative phase.

It turns out, that simple dimensional analysis we did earlier accurately describes the life cycle of some of the most violent explosions in the universe. Charles would probably still be grumpy it wasn't a comet he could name after the King, but I think he too would think that the math is pretty neat. Thank you.
