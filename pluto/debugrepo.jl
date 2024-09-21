### A Pluto.jl notebook ###
# v0.19.46

using Markdown
using InteractiveUtils

# ╔═╡ b19c46f0-7825-11ef-02d8-6fccd475a733
begin
	using Pkg
	Pkg.add(url = "https://github.com/neelsmith/BrownDriverBriggs.jl")
	using BrownDriverBriggs
end

# ╔═╡ 958cf881-6f6f-4071-8e6b-56e4d5b59c72
md"""# Test package from github repo"""

# ╔═╡ bf2efa1d-b63e-47b3-b843-b2b3f4bfff73
token = "בָּרָ֣א"

# ╔═╡ 8047fe16-05a7-42b5-bd83-0fdc786784b3
articles = bdb(token)

# ╔═╡ 01075025-57ca-4ce1-b5b3-665052bf9c96
html_string(articles[3]) |> HTML

# ╔═╡ Cell order:
# ╠═b19c46f0-7825-11ef-02d8-6fccd475a733
# ╟─958cf881-6f6f-4071-8e6b-56e4d5b59c72
# ╠═bf2efa1d-b63e-47b3-b843-b2b3f4bfff73
# ╠═8047fe16-05a7-42b5-bd83-0fdc786784b3
# ╠═01075025-57ca-4ce1-b5b3-665052bf9c96
