<?php
include_once '../conexao/PDOConnectionFactory.php';
include_once '../interface/Origem_conversaoInterface.php';
include_once '../vo/br/com/aliancadeus/vo/Origem_conversaoVO.php';
/**
 * Description of Batismo_aguasDAO
 *
 * @author simao
 */
class Origem_conversaoDAO implements Origem_conversaoInterface{
    private $conn = null;
    private $origem= null;
    public function __construct() {
        $this->conn = PDOConnectionFactory::getInstance();
    }
    
    public function atualizar(Origem_conversaoVO $origem) {

    }
    public function excluir($id) {

    }
    public function getListar() {
        $sqlLista = "select *,DATE_FORMAT(dtConversao,'%d/%m/%Y') AS dtConversao from origem_conversao";
        try {        
                $rs = $this->conn->query($sqlLista);
                if($rs){
                    while($ln = $rs->fetch(PDO::FETCH_OBJ)){
                        $this->origem = new Origem_conversaoVO();
                        $this->origem->setId($ln->id);
                        $this->origem->setDescricao($ln->descricao);
                        $this->origem->setDtConversao($ln->dtConversao);
                        $this->origem->setAno($ln->ano);
                        $this->origem->setNome_igreja($ln->nome_igreja);
                        $origems[] = $this->origem;
                    }
                }            
        } catch (Exception $exc) {
            echo $exc->getMessage();
        }
        return $origems;        

    }
    public function inserir(Origem_conversaoVO $origem) {
        try {
            
            $sqlInsert = "INSERT INTO origem_conversao (descricao, nome_igreja, dtConversao,ano) 
                values (?,?,?,?)";
            
            $stmt = $this->conn->prepare($sqlInsert);
            $stmt->bindParam(1,utf8_decode($origem->getDescricao()), PDO::PARAM_STR);
            $stmt->bindParam(2,utf8_decode($origem->getNome_igreja()), PDO::PARAM_STR);
            $stmt->bindParam(3,$origem->getDtConversao());
            $stmt->bindParam(4,$origem->getAno(), PDO::PARAM_INT);
            $stmt->execute();  
            
//            var_dump($stmt->execute());
            $retorno['mensagem'] = "Cadastro efetuado com Sucesso!000";
        } catch (Exception $e) {
            $retorno['mensagem'] = "Error : " . $e->getMessage();           
        }
        return $retorno;
        
        
    }
}

?>