using BrownDriverBriggs
s = "בָּרָ֣א"


blist = bdb(s)
slist = strong(s)



overlaps = []
for b in blist
    strongmatches = filter(slist) do stg
        id(stg) in strong_numbers(b)
    end
    push!(overlaps, (b, strongmatches))
end

overlaps[1]