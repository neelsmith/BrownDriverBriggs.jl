using BrownDriverBriggs

token = "בָּרָ֣א"
articles = bdb(token)

html = html_string(articles[3]) 

open("testout.html", "w") do io
    write(io, html)
end