module BrownDriverBriggs

import Base: show
import Base: ==

using JSON3
using Downloads

using TestSetExtensions
using Documenter, DocStringExtensions

export bdb, strong, bdbplus
export html_string

export Article
export id, headword, strong_numbers
export next_hw, prev_hw
export senses
export strongmatches

#export next, prev

export Sense
export label, definition, verbform, subsenses

export Strong
export pos, definitions, bdbmatches

export BDBplus
export bdbplus, bdbid, strongids

include("json.jl")
include("html.jl")
include("sense.jl")
include("article.jl")
include("strong.jl")
include("bdbplus.jl")

end # module BrownDriverBriggs
