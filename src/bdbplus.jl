struct BDBplus
    article::Article
    strong::Vector{Strong}
end

"""Override Base.show for a BDB article with Strong entries.
$(SIGNATURES)
"""
function show(io::IO, bdbp::BDBplus)
    print(io, label(bdbp))
end


function label(bdbp::BDBplus)
    sgpl = length(bdbp.strong) == 1 ? "entry" : "entries"
    string(label(bdbp.article), " plus $(length(bdbp.strong)) Strong $(sgpl)")
end

"""Construct BDBplus articles for a given Hebrew word.
$(SIGNATURES)
"""
function bdbplus(tkn::AbstractString)::Vector{BDBplus}
	bdblist = bdb(tkn)
	stronglist = strong(tkn)

	map(bdblist) do article
        BDBplus(article, strongmatches(article, stronglist))
	end
end



"""Find all Strong entries that are indexed to a given BDB article.
$(SIGNATURES)
"""
function strongmatches(a::Article, stronglist::Vector{Strong})::Vector{Strong}
	filter(stronglist) do strong_entry
		id(strong_entry) in strong_numbers(a)
	end
end


"""Find all BDB articles that are indexed to a given Strong entry.
$(SIGNATURES)
"""
function bdbmatches(strong_entry::Strong, bdblist::Vector{Article})::Vector{Article}
	filter(bdblist) do article
		id(strong_entry) in strong_numbers(article)
	end
end