"""A section of an article discussing a single sense or sub-sense."""
struct Sense
    json::JSON3.Object
end

"""BDB label for a sense or subsense in an article.
$(SIGNATURES)
"""
function label(s::Sense)::Union{String,Nothing}
    haskey(s.json,:num) ? s.json.num : nothing
end


"""Definition for a sense or subsense.
$(SIGNATURES)
"""
function definition(s::Sense)::Union{String,Nothing}
    haskey(s.json,:definition) ? s.json.definition : nothing 
end


"""Form verb for a sense or subsense.
$(SIGNATURES)
"""
function verbform(s::Sense)::Union{String,Nothing}
    haskey(s.json,:form) ? s.json.form : nothing
end


"""Further sub-senses for a sense or subsense.
$(SIGNATURES)
"""
function subsenses(s::Sense)::Vector{Sense}
    if haskey(s.json, :senses) 
        map(sns -> Sense(sns), s.json.senses) 
    else
        Sense[]
    end
end