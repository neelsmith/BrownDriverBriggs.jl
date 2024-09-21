LEXICON_API = "https://www.sefaria.org/api/words/"

"""Download a URL and parse its contents as JSON3.
$(SIGNATURES)
"""
function parse_url(u)
   f = Downloads.download(u)

   parsed = JSON3.read(f)
   rm(f)
   parsed
end

"""Get parsed JSON for all BDB entries for a word.
$(SIGNATURES)
"""
function bdbentries(wd)
	filter(parse_url(LEXICON_API * wd)) do entry 
		entry.parent_lexicon == "BDB Dictionary"
	end
end


"""Compose HTML header for a single article.
$(SIGNATURES)
"""
function format_entry_header(json; level = 3)
	lines = []
	
	push!(lines, """<h$(level)> $(json.headword)</h$(level)>""")
	push!(lines, """<p>Article has <b>$(length(json.content.senses))</b> senses</p>""")
	join(lines, "\n\n")
end