package challenge_F

import rego.v1

condition_1 if { input.q == true }
condition_2 if { input.t == true }
condition_3 if { input.r == true }
condition_0 if { condition_1; condition_2; condition_3 }
entry_F_r1 if { condition_0 }
condition_5 if { input.q == true }
condition_6 if { input.t == true }
condition_8 if { input.r == true }
condition_7 if { not condition_8 }
condition_4 if { condition_5; condition_6; condition_7 }
entry_F_r2 if { condition_4 }
condition_10 if { input.q == true }
condition_12 if { input.t == true }
condition_11 if { not condition_12 }
condition_13 if { input.s == true }
condition_9 if { condition_10; condition_11; condition_13 }
entry_F_r3 if { condition_9 }
condition_15 if { input.q == true }
condition_17 if { input.t == true }
condition_16 if { not condition_17 }
condition_19 if { input.s == true }
condition_18 if { not condition_19 }
condition_14 if { condition_15; condition_16; condition_18 }
entry_F_r4 if { condition_14 }
