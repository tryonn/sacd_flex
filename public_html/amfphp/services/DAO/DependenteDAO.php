<?php
include_once '../conexao/PDOConnectionFactory.php';
include_once '../interface/DependenteInterface.php';
include_once '../vo/br/com/aliancadeus/vo/DependenteVO.php';
/**
 * Description of DependenteDAO
 *
 * @author simao
 */
class DependenteDAO implements DependenteInterface{
    
    private $conn = null;
    private $dependente = null;
    
    public function __construct() {
        $this->conn = PDOConnectionFactory::getInstance();
    }
    
    public function atualizar(DependenteVO $dependente) {
        
    }
    public function excluir($id) {
        
    }
    public function getListar() {
        
    }
    public function inserir(DependenteVO $dependente) {
        try {
            
            $sqlInsert = "INSERT INTO dependentes (nome, data_nascimento, membros_id) values (?,?,?)";

            $stmt = $this->conn->prepare($sqlInsert);
            $stmt->bindParam(1,utf8_decode($dependente->getNome()), PDO::PARAM_STR);
            $stmt->bindParam(2,utf8_decode($dependente->getData_nascimento()), PDO::PARAM_STR);
            $stmt->bindParam(3,$dependente->getMembros_id(), PDO::PARAM_STR);
            $stmt->execute();                
            $retorno['mensagem'] = "Cadastro efetuado com Sucesso!";
        } catch (Exception $e) {
            $retorno['mensagem'] = "Error : " . $e->getMessage();           
        }
        return $retorno;        
    }
}

?>
