import std/[os, strutils, syncio]


echo "plase pid ?dont forget sudo"

let pid_id = readLine(stdin).strip()
 
 #mapping kısmını yapaçağız şimdi yukarda pid id girme kısmı yapıldı
let mapsyolu = "/proc/" & pid_id & "/maps"
let memyolu = "/proc/" & pid_id & "/mem" 
if fileExists(mapsyolu):
  var f: File 
  if open(f,memyolu,fmRead):

    for satir in lines(mapsyolu):
      echo satir
      let data_1 = satir.splitwhitespace()

      if data_1.len >= 2 and data_1[1].contains('r'):
        let adres = data_1[0].split('-')
        let basla = adres[0]
        let bitis = adres[1]

        echo "Okunabilir Bölge -> Başlangıç: ", basla, " | Bitiş: ", bitis
        let baslangicadresi = parseHexInt(basla)
        let bitisadresi = parsehexInt(bitis)
        let boyut = bitisadresi - baslangicadresi
        if boyut > 0:
          try:
            f.setfilepos(baslangicadresi)
            var buffer = newseq[byte](boyut)
            discard f.readbuffer(addr buffer[0], boyut)
            echo "we readed", boyut," bayt"
          except IOError:
          echo "ehhh something is wrong with reading?"
    f.close() 
  else:
    echo "13. sometyhing worng"
else:
  echo "6. something is false"