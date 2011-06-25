<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */



include_once '../services/conexao/PDOConnectionFactory.php';
include_once '../services/vo/br/com/aliancadeus/vo/UsuarioVO.php';
include_once '../services/autentica/Autenticacao.php';

$db = PDOConnectionFactory::getInstance();
$usuario = new UsuarioVO();
$autent = new Autenticacao();

$autent->sessionDestroi();


if(isset ($_SESSION['login'])){
    $userID = $_SESSION['login'];
    $id = $_SESSION['id'];
    echo "<br/>"."Logado seja bem vindo $userID";
    echo "<br> ID da Sessao : " .  session_id() . "com id : " . $id;
}else{
    echo "Session Finalizada";
}

?>
