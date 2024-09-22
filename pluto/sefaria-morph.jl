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


# ╔═╡ Cell order:
# ╠═68026c63-5cf5-47a5-a318-3440de7d201a
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
