<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

//iniciando a session
session_start();
//session_destroy();
//echo "Sessao destruida!";


$_SESSION["nome"] = "Uso de session no php";//variavel de session
$_SESSION["lendo"] = "sim";

$s = $_SESSION["lendo"];


if($_SESSION["lendo"] !=="sim"){
    
    echo "Voce não esta lendo arquigo";
} else {
    echo "Voce esta lendo o artigo " . $s .  $_SESSION["nome"];
}

?>
