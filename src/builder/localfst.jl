
function fstinflcmd()
  rawout = read(`which fst-infl`, String)
  replace(rawout, "\n" => "")
end