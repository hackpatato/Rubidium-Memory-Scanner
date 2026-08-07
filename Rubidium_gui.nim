import nigui
import std/[os, strutils, syncio]

app.init()

# Renk Tanımları
let abyssal_slate = rgb(7, 9, 10)     # #07090a (Arka plan)
let sari = rgb(255, 255, 0)            # #ffff00 (Yazı rengi)
let kutu_koyu = rgb(18, 22, 25)        # Elemanlar için koyu ton
var pencere = newWindow("Rubidium Memory Scanner")
pencere.width = 750
pencere.height = 500
var anakutu = newLayoutContainer(Layout_Vertical)
anakutu.backgroundColor = abyssal_slate
pencere.add(anakutu)
var baslik = newLabel("RUBIDIUM MEMORY SCANNER")
baslik.textColor = sari
anakutu.add(baslik)
var ustkutu = newLayoutContainer(Layout_Horizontal)
ustkutu.backgroundColor = abyssal_slate
anakutu.add(ustkutu)

var pidetiket = newLabel("PID Giriniz: ")
pidetiket.textColor = sari
ustkutu.add(pidetiket)

var pidgirdi = newTextBox()
pidgirdi.placeholder = "Örn: 1234"
pidgirdi.backgroundColor = kutu_koyu
pidgirdi.textColor = sari
ustkutu.add(pidgirdi)
var tarabuton = newButton("Haritayı Çıkar")
tarabuton.backgroundColor = kutu_koyu
tarabuton.textColor = sari
ustkutu.add(tarabuton)
var sonucalani = newTextArea()
sonucalani.backgroundColor = abyssal_slate
sonucalani.textColor = sari
anakutu.add(sonucalani)

tarabuton.onClick = proc(event: ClickEvent) =
  let pid_id = pidgirdi.text.strip()
  
  if pid_id.len == 0:
    sonucalani.text = "Lütfen geçerli bir PID giriniz!"
    return

  let mapsyolu = "/proc/" & pid_id & "/maps"
  
  if fileExists(mapsyolu):
    var cikti = ""
    for satir in lines(mapsyolu):
      let data_1 = satir.splitWhitespace()
      
      if data_1.len >= 2 and data_1[1].contains('r'):
        let adres = data_1[0].split('-')
        let basla = adres[0]
        let bitis = adres[1]
        
        cikti &= "Okunabilir Bölge -> Başlangıç: " & basla & " | Bitiş: " & bitis & "\n"
        
    sonucalani.text = cikti
  else:
    sonucalani.text = "Hata: /proc/" & pid_id & "/maps dosyası bulunamadı!"

pencere.show()
app.run()