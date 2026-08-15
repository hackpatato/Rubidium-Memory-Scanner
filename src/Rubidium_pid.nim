import std/[os, strutils]

for kind, path in walkdir("/proc"):
  
  let klasorAdi = extractfilename(path)

  
  if allCharsInSet(klasorAdi, Digits) and klasorAdi != "":
    
    let commYolu = path & "/comm"

    
    if fileexists(commYolu):
      
      let progIsmi = readfile(commYolu).strip()
      echo "PID: ", klasorAdi, " -> ", progIsmi
