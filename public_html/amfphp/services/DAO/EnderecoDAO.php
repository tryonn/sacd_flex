<?php
include_once '../conexao/PDOConnectionFactory.php';
include_once '../interface/EnderecoInterface.php';
include_once '../vo/br/com/aliancadeus/vo/EnderecoVO.php';

class EnderecoDAO implements EnderecoInterface{
    
    private $conn = null;
    private $endereco = null;
    public function __construct() {
        $this->conn = PDOConnectionFactory::getInstance();
    }
    
    public function inserir(EnderecoVO $endereco) {
        try {
            
            $sqlInsert = "INSERT INTO enderecos (bairro, cidade, uf, numero, complemento, cep) 
                values (?,?,?,?,?,?)";

            $stmt = $this->conn->prepare($sqlInsert);
            $stmt->bindParam(1,utf8_decode($endereco->getBairro()), PDO::PARAM_STR);
            $stmt->bindParam(2,utf8_decode($endereco->getCidade()), PDO::PARAM_STR);
            $stmt->bindParam(3,utf8_decode($endereco->getUf()), PDO::PARAM_STR);
            $stmt->bindParam(4,  utf8_decode($endereco->getNumero()), PDO::PARAM_INT);
            $stmt->bindParam(5,  utf8_decode($endereco->getComplemento()), PDO::PARAM_STR);
            $stmt->bindParam(6,  utf8_decode($endereco->getCep()), PDO::PARAM_STR);            
            $stmt->execute();                
            $retorno['mensagem'] = "Cadastro efetuado com Sucesso!";
        } catch (Exception $e) {
            $retorno['mensagem'] = "Error : " . $e->getMessage();           
        }
        return $retorno;
    }
    
    public function atualizar(EnderecoVO $endereco){
        try {            
            $sqlInsert = "UPDATE enderecos set bairro=?, cidade=?, uf=?, numero=?, complemento=?, cep=? where id=?";
//            $endereco = new EnderecoDAO();
            $stmt = $this->conn->prepare($sqlInsert);
            $stmt->bindParam(1,utf8_decode($endereco->getBairro()), PDO::PARAM_STR);
            $stmt->bindParam(2,utf8_decode($endereco->getCidade()), PDO::PARAM_STR);
            $stmt->bindParam(3,utf8_decode($endereco->getUf()), PDO::PARAM_STR);
            $stmt->bindParam(4,utf8_decode($endereco->getNumero()), PDO::PARAM_INT);
            $stmt->bindParam(5,utf8_decode($endereco->getComplemento()), PDO::PARAM_STR);
            $stmt->bindParam(6,utf8_decode($endereco->getCep()), PDO::PARAM_STR); 
            $stmt->bindParam(7,$endereco->getId(),PDO::PARAM_INT);
            $stmt->execute();                
            
            $retorno['mensagem'] = "Cadastro atualizado com Sucesso!";
        } catch (Exception $e) {
            $retorno['mensagem'] = "Error : " . $e->getMessage();           
        }
        return $retorno;        
    }
    public function getListar() {
        $sqlLista = "select * from enderecos";
        try {        
                $rs = $this->conn->query($sqlLista);
                if($rs){
                    while($ln = $rs->fetch(PDO::FETCH_OBJ)){
                        $this->endereco = new EnderecoVO();
                        $this->endereco->setId($ln->id);
                        $this->endereco->setBairro($ln->bairro);
                        $this->endereco->setCidade($ln->cidade);
                        $this->endereco->setUf($ln->uf);
                        $this->endereco->setNumero($ln->numero);
                        $this->endereco->setComplemento($ln->complemento);
                        $this->endereco->setCep($ln->cep);                        
                        $enderecos[] = $this->endereco;
                    }
                }            
        } catch (Exception $exc) {
            echo $exc->getMessage();
        }
        return $enderecos;        
    }
    
    public function excluir($id){
        
        $valida = "select * from enderecos
                    inner join membros on membros.enderecos_id = enderecos.id
                    where enderecos.id = '$id'";
        $stmt = $this->conn->prepare($valida); 
        $stmt->bindParam(1,$id,PDO::PARAM_INT);
        $rs = $stmt->execute();
       
        if($stmt->rowCount()>0){
            $rs = $stmt->fetchAll( );
//             var_dump($rs);
            $retorno['mensagem'] = "Cadastro com o ID :  '$id' " . utf8_decode(' não ') . "pode ser deletado,
               pois esta associado a um Membro!";                            
        } else
        {
            try {           
                    $sqlDelete = "DELETE FROM enderecos WHERE id= '$id'";
                    $stmt = $this->conn->prepare($sqlDelete);
                    $stmt->bindParam(1,$id,PDO::PARAM_INT);
                    $stmt->execute();
                    $retorno['mensagem'] = "Cadastro" . utf8_decode(' excluído ') . "com Sucesso!";            
            } catch (Exception $e) {
                    $retorno['mensagem'] = "Error : " . $e->getMessage(); 
            }
        }
        return $retorno;
    }
}