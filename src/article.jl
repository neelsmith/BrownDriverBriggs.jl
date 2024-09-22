
"""A single article in BDB."""
struct Article
	json::JSON3.Object
end


"""Override Base.show for a BDB article.
$(SIGNATURES)
"""
function show(io::IO, a::Article)
    print(io, label(a))
end

function label(a::Article)
	string(headword(a), " (", id(a), ")")
end

"""Find all BDB articles for a given token.
$(SIGNATURES)
"""
function bdb(tkn::AbstractString)::Vector{Article}
	map(json -> Article(json), bdbentries(tkn))
end


"""Find BDB ID for an article.
$(SIGNATURES)
"""
function id(a::Article)
	a.json.rid
end

"""Hebrew headword for an article.
$(SIGNATURES)
"""
function headword(a::Article)
	a.json.headword
end


"""List of Strong numbers (string values) for a BDB article.
$(SIGNATURES)
"""
function strong_numbers(a::Article)
	a.json.strong_numbers
end

"""Next headword in BDB.
$(SIGNATURES)
"""
function next_hw(a::Article)
	a.json.next_hw
end

function next(a::Article)
	# How do you retrieve by headword?
	#next_hw(a) |> ???
end


"""Previous headword in BDB.
$(SIGNATURES)
"""
function prev_hw(a::Article)
	a.json.prev_hw
end


"""All top-level sections (senses) in an article.
$(SIGNATURES)
"""
function senses(a::Article)
	map(s -> Sense(s), a.json.content.senses)
end

"""Compose HTML view of an article
$(SIGNATURES)
"""
function html_string(a::Article; level = 3)::String
	formatted = String[]

	push!(formatted, """<h$(level)> $(headword(a))</h$(level)>""")

	singpl = length(senses(a)) == 1 ? "" : "s"
	push!(formatted, """<p>Article  <code>$(id(a))</code> has <b>$(length(senses(a)))</b> sense$(singpl)</p>""")

	push!(formatted,"<ul>")
	for s in senses(a)
		push!(formatted, "<li>" * html_string(s) * "</li>")
	end
	push!(formatted, "</ul>")
	join(formatted, "\n\n")
end