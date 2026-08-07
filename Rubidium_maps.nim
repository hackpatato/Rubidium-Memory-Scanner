import std/[os, strutils, syncio]


echo "lütfen pid i giriniz. lütfen sudo ile başlatmamışsanız kapatıp tekrar acınız.pid numarısı yoksa önçelikle pid bulucuyu kulanınız."

let pid_id = readLine(stdin).strip()
 
 #mapping kısmını yapaçağız şimdi yukarda pid id girme kısmı yapıldı
let mapsyolu = "/proc/" & pid_id & "/maps"
let memyolu = "/proc/" & pid_id & "/mem" 
if fileExists(mapsyolu):
  var f: File 
  if open (f,memyolu,fmRead):

   for satir in lines(mapsyolu):
    echo satir
    let data_1 = satir.splitwhitespace()

    if data_1.len >= 2 and data_1[1].contains('r'):
     let adres = data_1[0].split('-')
     let basla = adres[0]
     let bitis = adres[1]

     echo "Okunabilir Bölge -> Başlangıç: ", basla, " | Bitiş: ", bitis
     let baslangicadresi = parseHexInt(basla)
    
else:
  echo "bir şeyler yanlış gitti."