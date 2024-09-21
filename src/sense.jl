"""A section of an article discussing a single sense or sub-sense."""
struct Sense
    json::JSON3.Object
end

"""Override Base.show for a BDB article.
$(SIGNATURES)
"""
function show(io::IO, s::Sense)
    print(io, longlabel(s))
end

function longlabel(s::Sense)
    top = if isnothing(label(s)) 
        if isnothing(definition(s))
            "subsection"
        else
            "subsection (with definition)"
        end
    else
        "section $(label(s))"
    end

    middle = if isnothing(verbform(s))
        ""
    else
        string("for verb form ", verbform(s))
    end
    bottom = if isempty(subsenses(s))
        ""
    else
        "with $(length(subsenses(s))) subsections"
    end
    join([top,middle,bottom], " ")
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


"""Compose HTML view of a sense.
$(SIGNATURES)
"""
function html_string(s::Sense)::String
    formatted = String[]
    if ! isnothing(label(s))
        push!(formatted, label(s))
    end

	if ! isnothing(definition(s))
		push!(formatted, definition(s))
	end
    if ! isnothing(verbform(s))
		push!(formatted, "<code>$(verbform(s))</code>")
	end
	

    if ! isempty(subsenses(s))
        push!(formatted, "<ul>")
        map(subsenses(s)) do subsense
            push!(formatted, html_string(subsense))
        end
        push!(formatted, "</ul>")
    end
  
	join(formatted,"\n")
end