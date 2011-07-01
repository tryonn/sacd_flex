<?php
include_once '../conexao/PDOConnectionFactory.php';
include_once '../interface/MembroInterface.php';
include_once '../vo/br/com/aliancadeus/vo/MembroVO.php';

class MembroDAO implements MembroInterface{
    
    private $conn = null;
    private $membro = null;
    public function __construct() {
        $this->conn = PDOConnectionFactory::getInstance();
    }
    
    public function inserir(MembroVO $membro) {
        try {
            
            $sqlInsert = "INSERT INTO membros (nome, data_nascimento, data_conversao, fone_cel,
                fone_resid, estado_civil, enderecos_id, origem_conversao_id, batizado, data_batismo) 
                values (?,?,?,?,?,?,?,?,?,?)";

            $stmt = $this->conn->prepare($sqlInsert);
            $stmt->bindParam(1, utf8_decode($membro->getNome()), PDO::PARAM_STR);
            $stmt->bindParam(2, $membro->getData_nascimento());
            $stmt->bindParam(3, $membro->getData_conversao());
            $stmt->bindParam(4, $membro->getFone_cel(), PDO::PARAM_STR);
            $stmt->bindParam(5, $membro->getFone_resid(), PDO::PARAM_STR);
            $stmt->bindParam(6, utf8_decode($membro->getEstado_civil()), PDO::PARAM_STR);        
            $stmt->bindParam(7, $membro->getEnderecos_id(), PDO::PARAM_INT);            
            $stmt->bindParam(8, $membro->getOrigem_conversao_id(), PDO::PARAM_INT);            
            $stmt->bindParam(9, utf8_decode($membro->getBatizado()), PDO::PARAM_STR);            
            $stmt->bindParam(10, $membro->getData_batismo());            
            $stmt->execute();
            $retorno['mensagem'] = "Cadastro efetuado com Sucesso!";
        } catch (Exception $e) {
            $retorno['mensagem'] = "Error : " . $e->getMessage();           
        }
        return $retorno;
    }
    
    public function atualizar(MembroVO $membro){
        try {            
            $sqlInsert = "UPDATE membros set
                              nome=?
                            , data_nascimento=?
                            , data_conversao=?
                            , fone_cel=?
                            , fone_resid=?
                            , estado_civil=?
                            , enderecos_id=?
                            , origem_conversao_id=?
                            , batizado=?
                            , data_batismo=? where id=?;";
            $stmt = $this->conn->prepare($sqlInsert);
            $stmt->bindParam(1, utf8_decode($membro->getNome()), PDO::PARAM_STR);
            $stmt->bindParam(2, $membro->getData_nascimento());
            $stmt->bindParam(3, $membro->getData_conversao());
            $stmt->bindParam(4, $membro->getFone_cel(), PDO::PARAM_STR);
            $stmt->bindParam(5, $membro->getFone_resid(), PDO::PARAM_STR);
            $stmt->bindParam(6, utf8_decode($membro->getEstado_civil()), PDO::PARAM_STR);        
            $stmt->bindParam(7, $membro->getEnderecos_id(), PDO::PARAM_INT);            
            $stmt->bindParam(8, $membro->getOrigem_conversao_id(), PDO::PARAM_INT);            
            $stmt->bindParam(9, utf8_decode($membro->getBatizado()), PDO::PARAM_STR);            
            $stmt->bindParam(10,$membro->getData_batismo());            
            $stmt->bindParam(11,$membro->getId(),PDO::PARAM_INT);
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
                        $this->membro = new EnderecoVO();
                        $this->membro->setId($ln->id);
                        $this->membro->setBairro($ln->bairro);
                        $this->membro->setCidade($ln->cidade);
                        $this->membro->setUf($ln->uf);
                        $this->membro->setNumero($ln->numero);
                        $this->membro->setComplemento($ln->complemento);
                        $this->membro->setCep($ln->cep);                        
                        $membros[] = $this->membro;
                    }
                }            
        } catch (Exception $exc) {
            echo $exc->getMessage();
        }
        return $membros;        
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