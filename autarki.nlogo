__includes [ "NetLogo/includes.nls" ]
@#$#@#$#@
GRAPHICS-WINDOW
1200
10
1241
52
-1
-1
1.0
1
10
1
1
1
0
1
1
1
-16
16
-16
16
0
0
1
ticks
30.0

BUTTON
35
45
99
78
Setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
35
85
100
118
Go
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

SLIDER
220
40
480
73
No-of-Peers
No-of-Peers
0
200
20.0
5
1
NIL
HORIZONTAL

SLIDER
220
80
480
113
Votes-Required
Votes-Required
50.1
99
50.1
0.1
1
%
HORIZONTAL

SWITCH
930
55
1085
88
Heterogeneous-Cost
Heterogeneous-Cost
1
1
-1000

SLIDER
765
100
920
133
Benefit-Per-Unit-Of-Cost
Benefit-Per-Unit-Of-Cost
1
10
3.0
0.2
1
NIL
HORIZONTAL

CHOOSER
510
55
737
100
Learning-Methodology
Learning-Methodology
"Random" "> Required" "Mixed Strategy" "Reputation Optimization" "Reputation Optimization (with f)"
3

SLIDER
220
170
420
203
Block-Timeout
Block-Timeout
0
1000
25.0
5
1
ticks
HORIZONTAL

SLIDER
220
130
420
163
Rounds
Rounds
10
100
20.0
10
1
NIL
HORIZONTAL

SLIDER
425
130
585
163
Min-Con-Delay
Min-Con-Delay
1
Max-Con-Delay
2.0
1
1
NIL
HORIZONTAL

SLIDER
425
170
585
203
Max-Con-Delay
Max-Con-Delay
Min-Con-Delay
10
9.0
1
1
NIL
HORIZONTAL

SLIDER
765
55
920
88
Min-Attack-Probability
Min-Attack-Probability
0
0.99
0.0
0.01
1
NIL
HORIZONTAL

SLIDER
590
130
710
163
Min-Peer-Cons
Min-Peer-Cons
1
Max-Peer-Cons
2.0
1
1
NIL
HORIZONTAL

SLIDER
590
170
710
203
Max-Peer-Cons
Max-Peer-Cons
Min-Peer-Cons
10
6.0
1
1
NIL
HORIZONTAL

SLIDER
930
100
1085
133
Cost-Std-Dev
Cost-Std-Dev
0.025
0.125
0.025
0.025
1
NIL
HORIZONTAL

PLOT
25
245
380
405
Total Protection
Round
NIL
0.0
10.0
0.0
100.0
true
false
"" ""
PENS
"Invested" 1.0 0 -5298144 true "" ""
"Required" 1.0 0 -7500403 true "" ";; plot a threshold line\nplot-pen-reset\nplotxy 0 Votes-Required\nplotxy plot-x-max Votes-Required"

PLOT
25
435
380
595
Average Reputations
Round
NIL
0.0
10.0
0.0
1.0
true
true
"" ""
PENS
"Reputation" 1.0 0 -16777216 true "" ""
"Reputation Limit" 1.0 0 -5298144 true "" ""

PLOT
385
435
740
595
Average Utilities
NIL
NIL
0.0
10.0
0.0
10.0
true
false
"" ""
PENS
"default" 1.0 0 -16777216 true "" ""

PLOT
385
245
740
405
Validity Count
NIL
NIL
0.0
10.0
1.0
10.0
true
false
"" ""
PENS
"Validity" 1.0 0 -5298144 true "" ""
"Required" 1.0 0 -7500403 true "" ";; plot a threshold line\nplot-pen-reset\nplotxy 0 Votes-Required\nplotxy plot-x-max Votes-Required"

@#$#@#$#@
## WHAT IS IT?

This model was designed to study the behavior of rational players in distributed consensus, which in turn translates to the security and reliability of the entire system.

It simulates a voting-based consensus protocol for Blockchain applications that require **completeness** assurance. This is the property of all authentic and valid blocks presented for consensus being accepted and included in the distributed-ledger in their correct chronological order.

The model allows users to observe how a rational peer's decision for self-protection investment would differ when various parameters that concern them are altered.

## HOW IT WORKS

The model emulates a Blockchain application. It is designed as an infinitely repeated game which is repeated in sets of `n` block proposals. `n` is the same as the number of peers participating in the consensus. `r` is a parameter that indicates the number of rounds the game is repeated for the simulation. (Note that to emulate the infinitely repeated game, `r` should be assigned a high value.)

From the `n` blocks in a given round, certain blocks of interest are selected by a powerful adversary whose objective is to exclude the blocks from being added to the chain. Considering a selected learning methodology, each peer individually decides on whether to invest in self-protection or not. And if the total protection is higher than the number of votes required, the adversary's attempts are thwarted. Therefore, our model evaluates what learning methodologies are effective and under which conditions. The conditions applicable mostly concerns costs of self-protection, probability of a given proposed block being attacked, benefits given to the peers, and ultimately, the volatility of the network.

## HOW TO USE IT

A set of parameters that concerns the peers, their heterogeneity, and the network environment/volatility are provided as variables. Users can alter these variables and observe how it affects peer self-protection investment decision through the below graphs in real-time.

### Simulation Output

  * Block Acceptance
    * How many votes each Block obtained as a percentage
  * Total Protection
    * How many peers invested in self-protection
  * Average Utilities
  * Average Reputations (Only valid for Reputation Optimization Learning Methodology)
  * Validity Count (Only valid for Reputation Optimization Learning Methodology)
    * How many peers satisfied the learning methodology condition before deciding on self-protection investment. This measure validates whether the Learning Methodology was applicable for the given set of parameters or whether the decision was simply random.


### Configurable Parameters

The parameters that could be altered to test different conditions are as follows.
> It is not recommended to alter parameters during the simulation.

  * No-of-Peers
    * Number of participants in the consensus, `n`. Each round will therefore propose `n` blocks before proceeding to the next round.
  * Vote-Required
    * What percentage of votes are required for the Block to be accepted to the chain
  * Rounds
    * How many rounds the simulation must continue `r`. Note that  ` r x n ` blocks will be proposed before the simulation is concluded.
  * Block-Timeout
    * How many ticks to wait for until the number of votes received is compared against the percentage of votes required
  * Min-Attack-Probability
    * The probability that a given number of blocks are attacked during each round. For 10 blocks per round (i.e. *n=10*) and an attack probability of 0.5, 5 randomly selected blocks are attacked for denial of service in each round.
  * Benefit-Per-Unit-Of-Cost
    * The constant benefit given to a peer for having voted for a block confirmed into the distributed ledger, divided by the cost of self-protection. The cost of self-protection is homogeneous unless "Heterogeneous-Cost" parameter is turned on.
  * Learning-Methodology
    * This option provides various options that the peers could use to decide whether to invest in self-protection or not, given the information that is available to them without any coordination with other users. More information can be found in **Learning Methodologies** section below.
  * Min-Con-Delay, Max-Con-Delay
    * Emulates network volatility by randomly assigning a value between the minimum and maximum value for a given peer to wait before propagating the block that was received.
  * Min-Peer-Cons, Max-Peer-Cons
    * Emulates peer heterogeneity by assigning a value between the minimum and maximum values for a given peer to limit possible peer-to-peer connections.
  * Heterogeneous-Cost, Cost-Std-Dev
    * If Heterogeneous-Cost is turned on, then the peer heterogeneity is increased by allowing peers to have different protection investment costs. Costs are assigned in a normal distribution with the given standard deviation.

### Learning Methodologies

  * Random
    * Peers randomly decide whether to invest in self-protection or not
  * \> Required
    * (For reference only) A number of peers higher than the required percentage of votes are told to always invest in protection. This tests whether the primary functionality of the simulation is functional.
  * Mixed Strategy
    * (Experimental) Given the players are rational, they will invest in protection with some probability. Our research proposes a mixed strategy game-theoretical model which uses the above peer-related parameters to estimate the probability of protection investment. This value is used by peers to decide how many rounds to invest in (Which rounds the investment is made is decided at the start of simulation). Note that peers do not coordinate in this scenario.
  * Reputation Optimization
    * Players obtain a Reputation Limit through the mixed strategy game-theoretical model from our research, and if their reputation exceeds this limit, they decide to not invest. A peer with a lesser reputation than the reputation limit decides to invest in protection.
  * Reputation Optimization (with f)
    * (Experimental) Similar to Reputation Optimization, but incorporates the `f` value in calculations. `f` value determines how many blocks were accepted from the total proposed number of blocks. This cannot be calculated until the round is over, and therefore cannot be used for decision making. In this learning methodology, the previous round's `f` value is used as a substitution.
  * Regret Matching
    * (Experimental)  Players probabilistically choose their action depending on what the total utility for the previous round had been, had they chosen a different action **[2]**.
  * Regret Matching (with History)
    * (Experimental) Same as Regret Matching, but the utility of historical plays are considered in decision making.
  * Bounded Rationality
    * (Experimental) Emulates the El Farol Bar Game, where a set of random beliefs are assigned which are scored according to their success rates. Higher scoring beliefs survive and are used for decision-making regarding self-investment. **[3]**

> Note that some of the below methodologies are better explained in our research.

## LIMITATIONS

- A simplified implementation of a Blockchain application is implemented to facilitate the continued execution of the simulation. Transaction and block propagation, block verification aspects, are not implemented by the simulation. While these factors introduce the network volatility and therein the level of the noise present, which ultimately affects the learning outcomes and investment probabilities, the accuracy of the simulation is affected. However, studying the effects of such noise could also be induced through lower timeout values, higher ranges of connection delays, and smaller ranges of connections allowed between peers, and therefore this was an acceptable limitation.

- Since the native NetLogo `tick` functionality is used for timeouts, some amount of time allocated to the first block timeout was consumed during round initiation calculations. Therefore in the Block Acceptance graphs, the first block of each round is not accepted by the network due to the remaining amount of time not being sufficient for gossip message/vote propagation. We advise the reader to interpret the results with this in mind and to consult the Total Protection graph in doubt.

- In case all peers were under attack, the simulation was tweaked for one random peer to come online and propose a block irrespective of their protection decision. Considering that this block would never be accepted, the impact of this was negligible.

- Given the single-threaded nature of NetLogo (per singular simulation run) true concurrent timeout at individual peer-level could not be emulated.

- Given the nature of the game-theoretical model proposed, the effects of open participation are not incorporated in our analysis. While this is a limitation of the reputation-based learning based on our round-based infinitely repeated mixed strategy equilibria, considering that our implementation used NetLogo, it should be possible to extend our model to evaluate the effect of peers dropping and joining the network during the simulation execution. The impact of a varying number of peers will be evaluated in future work.

- The incentive for message propagation is implicitly baked into the game-theoretical model proposed by the requirement of peers having up-to-date transactions for block hash verification and subsequent voting purposes. In addition, since it is a known fact that there will be some peers who will not invest in security, reaching everyone available in the interest of obtaining the required number of votes before the timeout is also required. Another aspect that influences this would be the necessity of accurate calculations regarding reputation, benefits, and system-wide availability during learning processes. Our simulation design, however, does not include transactions in its implementation, and thus is disadvantaged in representing the amount of network volatility that would be present in a real network.

- In bounded rationality learning methodology implementation **[3]**, parameters of memory size and the number of strategies for peers were kept constant. A comparison of differing parameters for this methodology alongside the existing parameters of our model was considered out of scope for our evaluation.



## SOURCE AND UPDATES

The source is included in the below order (for ease of reference and version control)


    autarki.nlogo
     └ NetLogo/includes.nls
        ├ NetLogo/procs.nls
        ├ NetLogo/learning.nls
        └ NetLogo/elfarol.nls ([1])

Updates to this model can be obtained through [the GitHub repository](https://github.com/jkehelwala/Autarki). The repository access will be granted on request. Please refer to the attached MIT License for further details.

## RELATED MODELS

To compare with our original reputation optimization learning methodology performance, code for the El Farol model was adapted as a learning methodology. The related code (`NetLogo/elfarol.nls`) was included from El Farol model in the NetLogo model library as is [1], which can be found in the NetLogo Models Library under Social Science category.

## CREDITS AND REFERENCES

**[1]** Rand, W., Wilensky, U. (2007).  NetLogo El Farol model.  http://ccl.northwestern.edu/netlogo/models/ElFarol.  Center for Connected Learning and Computer-Based Modeling, Northwestern Institute on Complex Systems, Northwestern University, Evanston, IL.

**[2]**  Hart, S., & Mas‐Colell, A. (2000). A simple adaptive procedure leading to correlated equilibrium. Econometrica, 68(5), 1127-1150.

**[3]** Arthur, W. B. (1994). Inductive reasoning and bounded rationality. The American economic review, 84(2), 406-411.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

a_peer
false
0
Polygon -14835848 true false 0 240 15 270 285 270 300 240 165 15 135 15

a_server
false
0
Rectangle -7500403 true true 15 15 285 210
Polygon -7500403 true true 120 210 120 210 120 210 120 240 180 240 180 210 180 210 180 210
Rectangle -7500403 true true 15 240 285 285
Rectangle -10899396 true false 249 223 237 217

a_victim
false
0
Polygon -2674135 true false 0 240 15 270 285 270 300 240 165 15 135 15
Polygon -16777216 true false 180 75 120 75 135 180 165 180
Circle -16777216 true false 129 204 42

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

computer workstation
false
0
Rectangle -7500403 true true 60 45 240 180
Polygon -7500403 true true 90 180 105 195 135 195 135 210 165 210 165 195 195 195 210 180
Rectangle -16777216 true false 75 60 225 165
Rectangle -7500403 true true 45 210 255 255
Rectangle -10899396 true false 249 223 237 217
Line -16777216 false 60 225 120 225

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

monster
false
0
Polygon -7500403 true true 75 150 90 195 210 195 225 150 255 120 255 45 180 0 120 0 45 45 45 120
Circle -16777216 true false 165 60 60
Circle -16777216 true false 75 60 60
Polygon -7500403 true true 225 150 285 195 285 285 255 300 255 210 180 165
Polygon -7500403 true true 75 150 15 195 15 285 45 300 45 210 120 165
Polygon -7500403 true true 210 210 225 285 195 285 165 165
Polygon -7500403 true true 90 210 75 285 105 285 135 165
Rectangle -7500403 true true 135 165 165 270

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

warning
false
0
Polygon -7500403 true true 0 240 15 270 285 270 300 240 165 15 135 15
Polygon -16777216 true false 180 75 120 75 135 180 165 180
Circle -16777216 true false 129 204 42

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.2.2
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="base_rep_op" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <final>export-experiment</final>
    <exitCondition>end-simulation</exitCondition>
    <enumeratedValueSet variable="Votes-Required">
      <value value="50.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Block-Timeout">
      <value value="25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Benefit-Per-Unit-Of-Cost">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Heterogeneous-Cost">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Rounds">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Learning-Methodology">
      <value value="&quot;Reputation Optimization&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Con-Delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Con-Delay">
      <value value="9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Peer-Cons">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Peer-Cons">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Attack-Probability">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="No-of-Peers">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Cost-Std-Dev">
      <value value="0.025"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="0.0.base_random" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <final>export-experiment</final>
    <exitCondition>end-simulation</exitCondition>
    <enumeratedValueSet variable="Votes-Required">
      <value value="50.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Block-Timeout">
      <value value="25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Benefit-Per-Unit-Of-Cost">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Heterogeneous-Cost">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Rounds">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Learning-Methodology">
      <value value="&quot;Random&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Con-Delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Con-Delay">
      <value value="9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Peer-Cons">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Peer-Cons">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Attack-Probability">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="No-of-Peers">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Cost-Std-Dev">
      <value value="0.025"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="1.1.benefits" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <final>export-experiment</final>
    <exitCondition>end-simulation</exitCondition>
    <enumeratedValueSet variable="Votes-Required">
      <value value="50.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Block-Timeout">
      <value value="25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Benefit-Per-Unit-Of-Cost">
      <value value="1.5"/>
      <value value="3"/>
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Heterogeneous-Cost">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Rounds">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Learning-Methodology">
      <value value="&quot;Reputation Optimization&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Con-Delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Con-Delay">
      <value value="9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Peer-Cons">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Peer-Cons">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Attack-Probability">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="No-of-Peers">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Cost-Std-Dev">
      <value value="0.025"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="1.2.min_attack" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <final>export-experiment</final>
    <exitCondition>end-simulation</exitCondition>
    <enumeratedValueSet variable="Votes-Required">
      <value value="50.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Block-Timeout">
      <value value="25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Benefit-Per-Unit-Of-Cost">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Heterogeneous-Cost">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Rounds">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Learning-Methodology">
      <value value="&quot;Reputation Optimization&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Con-Delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Con-Delay">
      <value value="9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Peer-Cons">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Peer-Cons">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Attack-Probability">
      <value value="0"/>
      <value value="0.1"/>
      <value value="0.5"/>
      <value value="0.9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="No-of-Peers">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Cost-Std-Dev">
      <value value="0.025"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="1.3.timeout" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <final>export-experiment</final>
    <exitCondition>end-simulation</exitCondition>
    <enumeratedValueSet variable="Votes-Required">
      <value value="50.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Block-Timeout">
      <value value="15"/>
      <value value="25"/>
      <value value="40"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Benefit-Per-Unit-Of-Cost">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Heterogeneous-Cost">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Rounds">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Learning-Methodology">
      <value value="&quot;Reputation Optimization&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Con-Delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Con-Delay">
      <value value="9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Peer-Cons">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Peer-Cons">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Attack-Probability">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="No-of-Peers">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Cost-Std-Dev">
      <value value="0.025"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="1.4.no_of_peers" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <final>export-experiment</final>
    <exitCondition>end-simulation</exitCondition>
    <enumeratedValueSet variable="Votes-Required">
      <value value="50.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Block-Timeout">
      <value value="25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Benefit-Per-Unit-Of-Cost">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Heterogeneous-Cost">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Rounds">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Learning-Methodology">
      <value value="&quot;Reputation Optimization&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Con-Delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Con-Delay">
      <value value="9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Peer-Cons">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Peer-Cons">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Attack-Probability">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="No-of-Peers">
      <value value="200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Cost-Std-Dev">
      <value value="0.025"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="2.1.costs" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <final>export-experiment</final>
    <exitCondition>end-simulation</exitCondition>
    <enumeratedValueSet variable="Votes-Required">
      <value value="50.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Block-Timeout">
      <value value="25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Benefit-Per-Unit-Of-Cost">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Heterogeneous-Cost">
      <value value="false"/>
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Rounds">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Learning-Methodology">
      <value value="&quot;Reputation Optimization&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Con-Delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Con-Delay">
      <value value="9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Peer-Cons">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Peer-Cons">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Attack-Probability">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="No-of-Peers">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Cost-Std-Dev">
      <value value="0.025"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="2.2.cost_range" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <final>export-experiment</final>
    <exitCondition>end-simulation</exitCondition>
    <enumeratedValueSet variable="Votes-Required">
      <value value="50.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Block-Timeout">
      <value value="25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Benefit-Per-Unit-Of-Cost">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Heterogeneous-Cost">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Rounds">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Learning-Methodology">
      <value value="&quot;Reputation Optimization&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Con-Delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Con-Delay">
      <value value="9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Peer-Cons">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Peer-Cons">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Attack-Probability">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="No-of-Peers">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Cost-Std-Dev">
      <value value="0.125"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="3.1.tolerance" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <final>export-experiment</final>
    <exitCondition>end-simulation</exitCondition>
    <enumeratedValueSet variable="Votes-Required">
      <value value="50.1"/>
      <value value="59.9"/>
      <value value="66.6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Block-Timeout">
      <value value="25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Benefit-Per-Unit-Of-Cost">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Heterogeneous-Cost">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Rounds">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Learning-Methodology">
      <value value="&quot;Reputation Optimization&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Con-Delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Con-Delay">
      <value value="9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Peer-Cons">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Peer-Cons">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Attack-Probability">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="No-of-Peers">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Cost-Std-Dev">
      <value value="0.025"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="3.2.tolerance_66" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <final>export-experiment</final>
    <exitCondition>end-simulation</exitCondition>
    <enumeratedValueSet variable="Votes-Required">
      <value value="66.6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Block-Timeout">
      <value value="25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Benefit-Per-Unit-Of-Cost">
      <value value="1.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Heterogeneous-Cost">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Rounds">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Learning-Methodology">
      <value value="&quot;Reputation Optimization&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Con-Delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Con-Delay">
      <value value="9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Peer-Cons">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Peer-Cons">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Attack-Probability">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="No-of-Peers">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Cost-Std-Dev">
      <value value="0.025"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="3.2.tolerance_80" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <final>export-experiment</final>
    <exitCondition>end-simulation</exitCondition>
    <enumeratedValueSet variable="Votes-Required">
      <value value="80"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Block-Timeout">
      <value value="25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Benefit-Per-Unit-Of-Cost">
      <value value="1.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Heterogeneous-Cost">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Rounds">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Learning-Methodology">
      <value value="&quot;Reputation Optimization&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Con-Delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Con-Delay">
      <value value="9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Peer-Cons">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Peer-Cons">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Attack-Probability">
      <value value="0"/>
      <value value="0.5"/>
      <value value="0.9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="No-of-Peers">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Cost-Std-Dev">
      <value value="0.025"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="4.0.rep_max_r20" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <final>export-experiment</final>
    <exitCondition>end-simulation</exitCondition>
    <enumeratedValueSet variable="Votes-Required">
      <value value="50.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Block-Timeout">
      <value value="25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Benefit-Per-Unit-Of-Cost">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Heterogeneous-Cost">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Rounds">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Learning-Methodology">
      <value value="&quot;Reputation Optimization&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Con-Delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Con-Delay">
      <value value="9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Peer-Cons">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Peer-Cons">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Attack-Probability">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="No-of-Peers">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Cost-Std-Dev">
      <value value="0.025"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="4.1.regret_r" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <final>export-experiment</final>
    <exitCondition>end-simulation</exitCondition>
    <enumeratedValueSet variable="Votes-Required">
      <value value="50.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Block-Timeout">
      <value value="25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Benefit-Per-Unit-Of-Cost">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Heterogeneous-Cost">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Rounds">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Learning-Methodology">
      <value value="&quot;Regret Matching&quot;"/>
      <value value="&quot;Regret Matching (with History)&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Con-Delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Con-Delay">
      <value value="9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Peer-Cons">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Peer-Cons">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Attack-Probability">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="No-of-Peers">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Cost-Std-Dev">
      <value value="0.025"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="4.2.regret_benefit" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <final>export-experiment</final>
    <exitCondition>end-simulation</exitCondition>
    <enumeratedValueSet variable="Votes-Required">
      <value value="50.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Block-Timeout">
      <value value="25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Benefit-Per-Unit-Of-Cost">
      <value value="1.5"/>
      <value value="3"/>
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Heterogeneous-Cost">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Rounds">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Learning-Methodology">
      <value value="&quot;Regret Matching&quot;"/>
      <value value="&quot;Regret Matching (with History)&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Con-Delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Con-Delay">
      <value value="9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Peer-Cons">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Peer-Cons">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Attack-Probability">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="No-of-Peers">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Cost-Std-Dev">
      <value value="0.025"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="4.3.boundedr_r" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <final>export-experiment</final>
    <exitCondition>end-simulation</exitCondition>
    <enumeratedValueSet variable="Votes-Required">
      <value value="50.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Block-Timeout">
      <value value="25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Benefit-Per-Unit-Of-Cost">
      <value value="3"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Heterogeneous-Cost">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Rounds">
      <value value="10"/>
      <value value="20"/>
      <value value="40"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Learning-Methodology">
      <value value="&quot;Bounded Rationality&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Con-Delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Con-Delay">
      <value value="9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Peer-Cons">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Peer-Cons">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Attack-Probability">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="No-of-Peers">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Cost-Std-Dev">
      <value value="0.025"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="4.4.boundedr_benefit" repetitions="1" runMetricsEveryStep="false">
    <setup>setup</setup>
    <go>go</go>
    <final>export-experiment</final>
    <exitCondition>end-simulation</exitCondition>
    <enumeratedValueSet variable="Votes-Required">
      <value value="50.1"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Block-Timeout">
      <value value="25"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Benefit-Per-Unit-Of-Cost">
      <value value="1.5"/>
      <value value="3"/>
      <value value="4"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Heterogeneous-Cost">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Rounds">
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Learning-Methodology">
      <value value="&quot;Bounded Rationality&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Con-Delay">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Con-Delay">
      <value value="9"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Peer-Cons">
      <value value="2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Max-Peer-Cons">
      <value value="6"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Min-Attack-Probability">
      <value value="0"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="No-of-Peers">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="Cost-Std-Dev">
      <value value="0.025"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
1
@#$#@#$#@
