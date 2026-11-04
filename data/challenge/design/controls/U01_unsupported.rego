package challenge_unsupported

import rego.v1

allow if { input.score + 1 >= 2 }
