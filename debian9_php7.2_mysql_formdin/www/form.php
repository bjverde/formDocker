<?php
require_once 'install/control/autoload_install.php';
$filename = 'formDin';
if (!file_exists($filename)) {
    header('Location: index.php');
}
?>

<!DOCTYPE html>
<html>
<title>Ambiente FormDin</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-teal.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"><style>
body {font-family: "Roboto", sans-serif}
.w3-bar-block .w3-bar-item{padding:16px;font-weight:bold}
</style>
<body>

<nav class="w3-sidebar w3-bar-block w3-collapse w3-animate-left w3-card" style="z-index:3;width:250px;" id="mySidebar">
  <a class="w3-bar-item w3-button w3-border-bottom w3-large" href="#"><img src="/formDin/base/imagens/formdin_logo.png" style="width:80%;"></a>
  <a class="w3-bar-item w3-button w3-hide-large w3-large" href="javascript:void(0)" onclick="w3_close()">Close <i class="fa fa-remove"></i></a>
  <a class="w3-bar-item w3-button w3-teal" href="#">Home</a>
  <a class="w3-bar-item w3-button" href="#formDin">FormDin</a>
  <a class="w3-bar-item w3-button" href="#sysgen">SysGen</a>
  <a class="w3-bar-item w3-button" href="#docker">Docker</a>
  <a class="w3-bar-item w3-button" href="#exemplos">Exemplos</a>
  </div>
</nav>

<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" id="myOverlay"></div>

<div class="w3-main" style="margin-left:250px;">

<div id="myTop" class="w3-container w3-top w3-theme w3-large">
  <p><i class="fa fa-bars w3-button w3-teal w3-hide-large w3-xlarge" onclick="w3_open()"></i>
  <span id="myIntro" class="w3-hide">O Ambiente do FormDin</span></p>
</div>

<header class="w3-container w3-theme" style="padding:44px 22px">
  <h1 class="w3-xxxlarge">FormDin com Docker</h1>
</header>

<div class="w3-container" style="padding:32px">

<h2 id="formDin">O que é o FormDin?</h2>

<p>FormDin é um FrameWork PHP para o desenvolvimento rapido de aplições web. Exige pouco conhecimento do desenvovedor permitindo fazer muito.</p>

<ul class="w3-leftbar w3-theme-border" style="list-style:none">
 <li>No momento da criação dessa pagina a versão do <a href="https://github.com/bjverde/formDin/releases/latest" target="new">formDin era 4.2.2</a></li>
 <li>Funciona com diversos bancos relacionais via PDO.</li>
 <li>Foco no desenvolvimento de sistema cooporativo com perfis de acesso.</li>
 <li>Diversos tipos de campos e recursos</li>
 <li>Código Livre</li>
 <li><a href="https://github.com/bjverde/formDin" target="_blank"> FormDin no Github</a></li>
</ul>
<br>
<img src="/formDin/base/imagens/formdin_logo.png" alt="Logo do FormDin">

<hr>
<h2 id="sysgen">O que é o SysGen?</h2>
<p>É um gerador de sistemas ! É Feito em formDin e gera sistema formDin</p>
<p><b>Write less, do more. But "Talk is Cheap. Show me the Code"!</b></p>
<p>O gerador de sistemas lê um banco de dados e gera uma tela crud para cada uma das tabelas montando o esqueleto do sistema. O código gerado é de fácil manutenção e modificação utilizando o como framework FormDin para o novo sistema.</p>

<hr>
<h2 id="docker">Docker?</h2>
<div class="w3-container w3-sand w3-leftbar">
<p><i>Docker é container para montar de forma simples e rápida o Ambiente necessário para rodar o FormDin e suas aplicações de exemplo. As configurações:</i></p>
<ul>
    <li>Sistema Operacional Debian 8</li>
    <li>Servidor Web Apache 2.4.</li>
    <li>PHP 7.1.</li>
    <li>Banco de dados MySQL.</li>
    <li>Banco de dados SQLite.</li>
</ul>
</div>

<hr>
<h2 id="exemplos">Tem algum exemplo ?</h2>

<p>Esse ambiente apresenta 5 aplicaçõs feitas em formDin que pode servir de exemplo</p>
<ul>
    <li><?php toolsHelper::showHref('formDin/appexemplo_form_alone','Formulario simples apenas mostrando informações'); ?></li>
    <li><?php toolsHelper::showHref('formDin/appexemplo_v1.0','Aplicação de exemplo v1.0'); ?> - apresenta quase todos os recursos do formDin apenas para mostrar o que pode ser feito</li>
    <li><?php toolsHelper::showHref('formDin/appexemplo_v2.0','Aplicação de exemplo v2.0'); ?> - Uma Aplicação feita com MySQL com diversos formulario relacionados</li>
    <li><?php toolsHelper::showHref('formDin/appexemplo_v2.5','Aplicação de exemplo v2.5'); ?> - é a mesmo que aplicação v2.0 pora com login e perfil</li>
    <li><?php toolsHelper::showHref('formDin/sysgen','SysGen'); ?> - é um o sistema que gera sistema.</li>
    <li><?php toolsHelper::showHref('phpinfo.php','PHP Info'); ?></li>
</ul>

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
