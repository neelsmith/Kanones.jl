
function lemmalabel(lexurn::LexemeUrn; dict = lemmatadict())
	string(lexurn, dict = dict) |> hacklabel
end

function lemmalabel(s::AbstractString;  dict = lemmatadict())
    if startswith(s, "lsjx.")
		stripped = replace(s, "lsjx." => "")
		haskey(dict, stripped) ? string(s, "@", dict[stripped]) : string(s, "@labelmissing")
	elseif startswith(s, "lsj.")
		stripped = replace(s, "lsj." => "")
		haskey(dict, stripped) ? string(s, "@", dict[stripped]) : 
		string(s, "@labelmissing")
	else
		string(s, "@nolabel")
	end
end
