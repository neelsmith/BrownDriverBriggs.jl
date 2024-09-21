module BrownDriverBriggs

using JSON3
using Downloads

using TestSetExtensions
using Documenter, DocStringExtensions

export bdb

export Article
export id, headword, strong_numbers
export next_hw, prev_hw
export senses
#export next, prev

export Sense
export label, definition, verbform, subsenses


include("json.jl")
include("html.jl")
include("sense.jl")
include("article.jl")


end # module BrownDriverBriggs
