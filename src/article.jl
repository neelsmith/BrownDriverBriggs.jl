#=
struct BDBReply
	articles::Vector{Article}
end
=#


struct Article
	json::JSON3.Object
end

function bdb(wd::AbstractString)::Vector{Article}
	map(json -> Article(json), bdbentries(wd))
end

function id(a::Article)
	a.json.rid
end

function headword(a::Article)
	a.json.headword
end

function strong_numbers(a::Article)
	a.json.strong_numbers
end


function next_hw(a::Article)
	a.json.next_hw
end

function next(a::Article)
	# How do you retrieve by headword?
	#next_hw(a) |> ???
end

function prev_hw(a::Article)
	a.json.prev_hw
end

function senses(a::Article)
	map(s -> Sense(s), a.json.content.senses)
end