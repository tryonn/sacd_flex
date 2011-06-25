<?php
/**
 * Inicia a Sessão : session_start('deus');
 * Nome da Sessão 'deus'
 * @author Simão Neto
 */
session_start("deus");
 
/**
 * ESSA PARTE DE CÓDIGO É PARA FAZER TESTES COM browser amfphp
 * e usada em toda aplicação
 */
include_once '../conexao/PDOConnectionFactory.php';
include_once '../vo/br/com/aliancadeus/vo/UsuarioVO.php';

/**
 * ESSA PARTE DE CÓDIGO É PARA FAZER TESTES COM OUTROS ARQUIVOS TIPO
 * O TesteConn.php e sessionDestroi.php
 */
//include_once '/conexao/PDOConnectionFactory.php';
//include_once '/vo/br/com/aliancadeus/vo/UsuarioVO.php';


/**
 * Description of Autentica
 *
 * @author simao
 */
class Autenticacao {
    //put your code here
    private $db = null;
    private $usuario = null;

    public function autenticar($login, $senha){
        $senha_md5 = md5($senha);
        $this->usuario = new UsuarioVO();
        $this->db = PDOConnectionFactory::getInstance();       
        $sqlSelecJoin = "select u.id, u.login, u.senha, m.nome, p.tipo from usuarios u
        inner join membros m on m.id = u.membros_id
        inner join perfis p on p.id = u.perfis_id
        WHERE u.login = '$login' AND u.senha = '$senha_md5'";
        
//        $sqlSelectLogin = "SELECT * FROM usuarios WHERE login = '$login' AND senha = '$senha'";
        
        $retorno['login'] = null;
	$retorno['mensagem'] = null;        
        try {
            $stmt = $this->db->prepare($sqlSelecJoin);
//            $stmt->bindParam(1,  $this->usuario->getLogin(),  PDO::PARAM_STR);
//            $stmt->bindParam(2,  $this->usuario->getSenha(),  PDO::PARAM_STR);
            $stmt->bindParam(1,  $login,  PDO::PARAM_STR);
            $stmt->bindParam(2, $senha_md5,  PDO::PARAM_STR);
            $rs = $stmt->execute();
            if($stmt->rowCount()>0){               
                $rs = $stmt->fetchAll( );
                $retorno['login'] = $_SESSION["usuarioLogado"] = "OK";
                $retorno['user'] = $_SESSION["user"] = $rs[0]['login'];
                $retorno['nome'] = $_SESSION["nome"] = $rs[0]['nome'];                
            } else {
                $retorno['login'] = "Falha";
		$retorno['mensagem'] = "Senha nao confere";
            }
        } catch (Exception $exc) {
            echo $exc->getTraceAsString();
        }
        return $retorno;
    }
    
    public function estaLogado(){
        session_start("deus");
        if (!session_start("deus")) {
            $deus = 1;
            $inicio = time();
//            $inicio = date("y-m-d H:i:s");
 
            session_register("deus");
            session_register("inicio");
        } else {
            $_SESSION["deus"] = $_SESSION["deus"] + 1;
        }
   
        if($_SESSION["usuarioLogado"] == "OK"){
            $retorno['logado'] = "OK";
            $retorno['contador'] = $_SESSION["deus"];
            $retorno['tempo'] = time() - $inicio;
            $retorno['nome'] = $_SESSION["nome"];
        } else{
            $retorno['logado'] = "Não Logado";
        }
        return $retorno;
    }
    
    /**
     * Método que retorna o nome do usuário logado
     * @access Public
     * @author Simão Neto
     * @method retornaNome()
     * @return $retorno 
     */
    public function retornaNome(){                
                $retorno['nome'] = $_SESSION["nome"];     
                return $retorno;
        }        
        public function retornaLogin(){               
                $valor = $_SESSION["login"];
                return $valor;
        }

    
    
    
    
    
//    public function logado($stmt){
//        if($stmt){
//            $rs = $stmt->fetchAll( );
//            if($_SESSION["usuarioLogado"] == "OK"){
//                $retorno['logado'] = "OK";
//            $retorno['user'] = $_SESSION["user"] = $rs[0]['id'];                            
//            } else{
//                $retorno['logado'] = "Não Logado";
//            }            
//        }
//        return $retorno;
//    }


//    public function iniciarSession($stmt){
//            session_start();
//            if($stmt){
//                $rs = $stmt->fetchAll( );                 
//                $_SESSION['id'] = $rs[0]['id'];
//                $_SESSION['login'] = $rs[0]['login'];
//                $_SESSION['membros_id'] = $rs[0]['membros_id'];
//                $_SESSION['perfis_id'] = $rs[0]['perfis_id'];
//            }else{
//                echo "Session fail";
//            }
//    }
    
    public function sessionDestroy(){
        session_destroy();        
        return "Session Destruida";
    }

}
?>
