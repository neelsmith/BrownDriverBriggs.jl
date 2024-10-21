"""Data from a Strong entry."""
struct Strong
	json::JSON3.Object
end

"""Override Base.show for a Strong entry.
$(SIGNATURES)
"""
function show(io::IO, strong_entry::Strong)
    print(io, label(strong_entry))
end

function pos(strong_entry::Strong)
	strong_entry.json.content.morphology
end


function id(strong_entry::Strong)
	strong_entry.json.strong_number
end


function headword(strong_entry::Strong)
	strong_entry.json.headword
end

function label(strong_entry::Strong)
	string(id(strong_entry), " ", headword(strong_entry), ", (", pos(strong_entry),"): ", join(definitions(strong_entry),"; "))
end



function definitions(strong_entry::Strong)
	map(sns -> sns.definition, strong_entry.json.content.senses)
end


"""Find all Strong entries for a given token.
$(SIGNATURES)
"""
function strong(tkn::AbstractString)::Vector{Strong}
	map(json -> Strong(json), strongentries(tkn))
end



