### A Pluto.jl notebook ###
# v0.19.46

using Markdown
using InteractiveUtils

# ╔═╡ 68026c63-5cf5-47a5-a318-3440de7d201a
begin
	using Pkg
	repo = dirname(pwd())
	Pkg.add(path = repo)
	using BrownDriverBriggs
	Pkg.add("PlutoUI")
	using PlutoUI
	
	#Pkg.add("Downloads")
	#using Downloads
	#Pkg.add("HTTP")
	#using HTTP
	Pkg.add("JSON3")
	using JSON3
	
	md"""*Unhide this cell to see the Julia environment*."""
end


# ╔═╡ 7a1c8187-4438-4370-ba49-166ffbe0c120
TableOfContents()

# ╔═╡ 5f8b3fa2-7900-11ef-2c80-c9f7cc113072
md"""# Sefaria morphology

Seems like there's some PoS information in Sefaria's extended BDB
"""

# ╔═╡ 0503326e-08ff-4a8a-b646-20bb92822a08
tkn = "בָּרָ֣א"

# ╔═╡ 31ffaa40-1a3a-4611-a3ad-db77b012a799
url = BrownDriverBriggs.LEXICON_API * tkn

# ╔═╡ 22620865-4d24-4f9c-ac2c-beffff3f71c6
json = BrownDriverBriggs.parse_url(url)

# ╔═╡ 1cc01bbf-5215-4b50-92d1-a0378fc474ca
bdb = filter(obj -> obj.parent_lexicon == "BDB Dictionary", json)

# ╔═╡ 52de810e-33c5-453c-b5c4-c72d0a90fc36
bdbplus = filter(obj -> obj.parent_lexicon == "BDB Augmented Strong", json)

# ╔═╡ ec224a8c-dd33-4d1d-b8d0-659c8954155a
string(bdbplus[1].content.morphology, " for ", bdbplus[1].headword, " (", bdbplus[1].strong_number, ")")

# ╔═╡ 22f283cb-e9bd-4812-beac-c2fa7335667d
map(bdbplus) do article
	string(article.content.morphology, " for ",article.headword, " (", article.strong_number, ")")
end

# ╔═╡ 160d361f-e7da-4827-b3d7-70f305c71432
"""Get parsed JSON for all Strong entries for a word.
"""
function strongentries(wd)
	filter(BrownDriverBriggs.parse_url(BrownDriverBriggs.LEXICON_API * wd)) do entry 
		entry.parent_lexicon == "BDB Augmented Strong"
	end
end


# ╔═╡ 4988cf67-2b9b-457c-bd17-1714a3dc17f3
strong = strongentries(tkn)

# ╔═╡ 6b7dae10-5fe6-4b9c-a631-6796ed7e0718
strong[1].content.morphology

# ╔═╡ a3417acd-243b-49fc-bb60-c7b874f6ac3e
"""Data from a Strong entry."""
struct Strong
	pos
	strong_number
	headword
end

# ╔═╡ 9bbfa655-81f0-4885-b71d-da6c08c64451
"""Extract Strong data from Sefaria JSON object."""
function strengthen(jsonobj)
	pos = jsonobj.content.morphology
	strongnum = jsonobj.strong_number
	headword = jsonobj.headword
	Strong(pos, strongnum, headword)
end

# ╔═╡ 41271d9e-ec83-435c-aa91-6b2e8b2e42b6
strengthen.(strong)

# ╔═╡ 0938fd1f-ff1b-4808-bd3d-c70e26b7fb03
md"""## Pair entries"""

# ╔═╡ 6b50f52b-a3c2-466a-8551-fa7821068f0e
bdbarticles = BrownDriverBriggs.bdb(tkn)

# ╔═╡ 77d7993b-7317-4121-b609-8280cf317131
strong_numbers.(bdbarticles)

# ╔═╡ 6ab07294-f6aa-443c-822e-6e8efec66641
strengthen.(bdbplus)

# ╔═╡ 64be56eb-99e4-461f-a240-59a746c7ffb6
dbdplusexample = strengthen(bdbplus[5])

# ╔═╡ 77acb21e-6e6f-4e7c-b7cc-be8407eba534
bdbmatch = filter(bdbarticles) do a
	dbdplusexample.strong_number in strong_numbers(a)
end[1]


# ╔═╡ d7d0e690-7771-49d6-9745-5bf6206b7068
"""$(bdbmatch) pairs with part of speech `$(dbdplusexample.pos)`""" |> Markdown.parse

# ╔═╡ Cell order:
# ╟─68026c63-5cf5-47a5-a318-3440de7d201a
# ╟─7a1c8187-4438-4370-ba49-166ffbe0c120
# ╟─5f8b3fa2-7900-11ef-2c80-c9f7cc113072
# ╟─0503326e-08ff-4a8a-b646-20bb92822a08
# ╟─31ffaa40-1a3a-4611-a3ad-db77b012a799
# ╟─22620865-4d24-4f9c-ac2c-beffff3f71c6
# ╠═1cc01bbf-5215-4b50-92d1-a0378fc474ca
# ╠═52de810e-33c5-453c-b5c4-c72d0a90fc36
# ╠═ec224a8c-dd33-4d1d-b8d0-659c8954155a
# ╠═22f283cb-e9bd-4812-beac-c2fa7335667d
# ╠═160d361f-e7da-4827-b3d7-70f305c71432
# ╠═4988cf67-2b9b-457c-bd17-1714a3dc17f3
# ╠═6b7dae10-5fe6-4b9c-a631-6796ed7e0718
# ╠═41271d9e-ec83-435c-aa91-6b2e8b2e42b6
# ╟─a3417acd-243b-49fc-bb60-c7b874f6ac3e
# ╟─9bbfa655-81f0-4885-b71d-da6c08c64451
# ╟─0938fd1f-ff1b-4808-bd3d-c70e26b7fb03
# ╠═6b50f52b-a3c2-466a-8551-fa7821068f0e
# ╠═77d7993b-7317-4121-b609-8280cf317131
# ╠═6ab07294-f6aa-443c-822e-6e8efec66641
# ╠═64be56eb-99e4-461f-a240-59a746c7ffb6
# ╠═77acb21e-6e6f-4e7c-b7cc-be8407eba534
# ╠═d7d0e690-7771-49d6-9745-5bf6206b7068
