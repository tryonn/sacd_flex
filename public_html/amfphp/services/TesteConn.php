<?php
//session_start("deus");
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
include_once '../services/conexao/PDOConnectionFactory.php';
include_once '../services/vo/br/com/aliancadeus/vo/UsuarioVO.php';
include_once '../services/vo/br/com/aliancadeus/vo/EnderecoVO.php';
include_once '../services/vo/br/com/aliancadeus/vo/Origem_conversaoVO.php';
include_once '../services/DAO/Origem_conversaoDAO.php';
include_once '../services/autentica/Autenticacao.php';

$db = PDOConnectionFactory::getInstance();
//$usuario = new UsuarioVO();
//$autent = new Autenticacao();
//$endereco = new EnderecoDAO();

//$stm = $db->query( 'select * from usuarios' );
//foreach ( $stm->fetchAll( PDO::FETCH_OBJ ) as $cargo){
//        echo $cargo->login."<br>";
//}

$origem = new Origem_conversaoDAO();





$stm = $db->query( 'select * from origem_conversao' );
foreach ( $stm->fetchAll( PDO::FETCH_OBJ ) as $origem){
        echo $origem->data_conversao."<br>";
}



////$stm = $db->query( 'select * from enderecos' );
//echo $endereco->listar()







//$login = "simao";
//$senha = "123";
//
//$autent->autenticar($login, $senha);
//
//$autent->estaLogado();
//
//echo $autent->retornaNome();
////$login = $db->usuario->setLogin("simao");
//////$senha = $db->usuario->setSenha("123");
//
//if(isset ($_SESSION['usuarioLogado'])){
//    $userID = $_SESSION['user'];
////    $id = $_SESSION['id']; 
//    $membro = $_SESSION['nome'];
//    echo "<br/>"."Logado seja bem vindo $userID";
//        echo "<br/>"."Logado seja bem vindo $membro";
//    echo "<br> ID da Sessao : " .  session_id();
//}else{
//    echo "Erro LOGIN FALIE";
//}
?>
