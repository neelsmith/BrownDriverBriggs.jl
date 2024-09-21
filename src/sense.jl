
struct Sense
    json::JSON3.Object
end

function label(s::Sense)::Union{String,Nothing}
    haskey(s.json,:num) ? s.json.num : nothing
end

function definition(s::Sense)::Union{String,Nothing}
    haskey(s.json,:definition) ? s.json.definition : nothing 
end

function verbform(s::Sense)::Union{String,Nothing}
    haskey(s.json,:form) ? s.json.form : nothing
end

function subsenses(s::Sense)::Vector{Sense}
    if haskey(s.json, :senses) 
        map(sns -> Sense(sns), s.json.senses) 
    else
        Sense[]
    end
end