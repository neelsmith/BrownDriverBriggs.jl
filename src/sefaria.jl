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