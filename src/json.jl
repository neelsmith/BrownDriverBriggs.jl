LEXICON_API = "https://www.sefaria.org/api/words/"


"""Download a URL and parse its contents as JSON3.
$(SIGNATURES)
"""
function parse_url(u)::Vector{JSON3.Object}
   f = Downloads.download(u)

   parsed = JSON3.read(f)
   rm(f)
   parsed
end


"""Get parsed JSON for all BDB entries for a word.
$(SIGNATURES)
"""
function strongentries(wd)
	filter(parse_url(LEXICON_API * wd)) do entry 
		entry.parent_lexicon == "BDB Augmented Strong"
	end
end

"""Get parsed JSON for all BDB entries for a word.
$(SIGNATURES)
"""
function bdbentries(wd)
	filter(parse_url(LEXICON_API * wd)) do entry 
		entry.parent_lexicon == "BDB Dictionary"
	end
end
