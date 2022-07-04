<?php
$filename = '../formDin';
if (file_exists($filename)) {
    header('Location: index.php');
}
?>

<!DOCTYPE html>
<html>
<title>Avisos - Instalação</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-teal.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<style>
    body {font-family: "Roboto", sans-serif}
    .w3-bar-block .w3-bar-item{padding:16px;font-weight:bold}
</style>
<body>

<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" id="myOverlay"></div>

<div class="w3-main">

    <div id="myTop" class="w3-container w3-top w3-theme w3-large">
    <p><i class="fa fa-bars w3-button w3-teal w3-hide-large w3-xlarge" onclick="w3_open()"></i>
    <span id="myIntro" class="w3-hide">Avisos - Instalação do Ambiente formDin</span></p>
    </div>

    <header class="w3-container w3-theme" style="padding:44px 22px">
    <h1 class="w3-xxxlarge">Avisos - Instalação do Ambiente formDin</h1>
    </header>

    <div class="w3-container" style="padding:32px">

    <h2>A Instalação não está completa !! Mas estamos quase lá ;-)</h2>
    <p>A copia do formDin será colocada na pasta WWW dentro do volume ou /var/www/html no Docker.</p>

    <hr>
    <h2>Avisos especiais para quem está rodando no Linux</h2>
        <div class="w3-container w3-sand w3-leftbar">
            <p><i>Infelizmente as configurações no Linux não estão 100%, especialmente no ponto de permisões</i></p>
            <ul>
                <li>Deixe a pasta WWW do volume com a permisão 777</li>
                <li>A copia da pasta formDin foi feita com 777</li>
                <li>Sistema gerados com SysGen terão permisão apenas para o Apache (www-data)</li>
            </ul>
        </div>

    <hr>
    <h2>Dicas</h2>    
    <p>Lembre-se essa imagem Docker tem o X-Debug instalado e configurado para acesso remoto</p>
    <p>Se estiver usado o <a href='https://github.com/bjverde/formDin/wiki/Usando-o-VS-Code'>VS Code poderá usar X-Debug com conexão remota</a></p>

    <hr>
    <form name="form" method="post">
        <button name="baixar" value="baixar" type="submit">Continuar a instalação -></button>
    </form>
</div>

<footer class="w3-container w3-theme" style="padding:5px">
  <p><a href="https://github.com/bjverde/formDin" target="_blank"> FormDin no Github</a></p>
</footer>
     
</div>

<script>
// Open and close the sidebar on medium and small screens
function w3_open() {
    document.getElementById("mySidebar").style.display = "block";
    document.getElementById("myOverlay").style.display = "block";
}
function w3_close() {
    document.getElementById("mySidebar").style.display = "none";
    document.getElementById("myOverlay").style.display = "none";
}

// Change style of top container on scroll
window.onscroll = function() {myFunction()};
function myFunction() {
    if (document.body.scrollTop > 80 || document.documentElement.scrollTop > 80) {
        document.getElementById("myTop").classList.add("w3-card-4", "w3-animate-opacity");
        document.getElementById("myIntro").classList.add("w3-show-inline-block");
    } else {
        document.getElementById("myIntro").classList.remove("w3-show-inline-block");
        document.getElementById("myTop").classList.remove("w3-card-4", "w3-animate-opacity");
    }
}

// Accordions
function myAccordion(id) {
    var x = document.getElementById(id);
    if (x.className.indexOf("w3-show") == -1) {
        x.className += " w3-show";
        x.previousElementSibling.className += " w3-theme";
    } else { 
        x.className = x.className.replace("w3-show", "");
        x.previousElementSibling.className = 
        x.previousElementSibling.className.replace(" w3-theme", "");
    }
}
</script>
     
</body>
</html> 
