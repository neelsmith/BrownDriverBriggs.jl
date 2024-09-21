
"""Compose HTML header for a single article.
$(SIGNATURES)
"""
function format_entry_header(json; level = 3)
	lines = []
	
	push!(lines, """<h$(level)> $(json.headword)</h$(level)>""")
	push!(lines, """<p>Article has <b>$(length(json.content.senses))</b> senses</p>""")
	join(lines, "\n\n")
end