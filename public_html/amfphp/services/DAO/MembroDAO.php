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
    
    public function insert(MembroVO $membro) {
        try {
            
            $sqlInsert = "INSERT INTO membros (nome, data_nascimento, fone_cel,
                fone_resid, estado_civil, enderecos_id, origem_conversao_id, batizado, data_batismo) 
                values (?,?,?,?,?,?,?,?,?)";

            $stmt = $this->conn->prepare($sqlInsert);
            $stmt->bindParam(1, utf8_decode($membro->getNome()), PDO::PARAM_STR);
            $stmt->bindParam(2, $membro->getData_nascimento());
            $stmt->bindParam(3, $membro->getFone_cel(), PDO::PARAM_STR);
            $stmt->bindParam(4, $membro->getFone_resid(), PDO::PARAM_STR);
            $stmt->bindParam(5, utf8_decode($membro->getEstado_civil()), PDO::PARAM_STR);        
            $stmt->bindParam(6, $membro->getEnderecos_id(), PDO::PARAM_INT);            
            $stmt->bindParam(7, $membro->getOrigem_conversao_id(), PDO::PARAM_INT);            
            $stmt->bindParam(8, utf8_decode($membro->getBatizado()), PDO::PARAM_STR);            
            $stmt->bindParam(9, $membro->getData_batismo());            
            $stmt->execute();
            $retorno['mensagem'] = "Cadastro efetuado com Sucesso!";
        } catch (Exception $e) {
            $retorno['mensagem'] = "Error : " . $e->getMessage();           
        }
        return $retorno;
    }
    
    public function update(MembroVO $membro){
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
            $stmt->bindParam(3, $membro->getFone_cel(), PDO::PARAM_STR);
            $stmt->bindParam(4, $membro->getFone_resid(), PDO::PARAM_STR);
            $stmt->bindParam(5, utf8_decode($membro->getEstado_civil()), PDO::PARAM_STR);        
            $stmt->bindParam(6, $membro->getEnderecos_id(), PDO::PARAM_INT);            
            $stmt->bindParam(7, $membro->getOrigem_conversao_id(), PDO::PARAM_INT);            
            $stmt->bindParam(8, utf8_decode($membro->getBatizado()), PDO::PARAM_STR);            
            $stmt->bindParam(9,$membro->getData_batismo());            
            $stmt->bindParam(10,$membro->getId(),PDO::PARAM_INT);
            $stmt->execute();                
            
            $retorno['mensagem'] = "Cadastro atualizado com Sucesso!";
        } catch (Exception $e) {
            $retorno['mensagem'] = "Error : " . $e->getMessage();           
        }
        return $retorno;        
    }
    public function getListar() {
        $sqlLista = "select membros.*,
                        DATE_FORMAT(data_nascimento,'%d/%m/%Y') AS data_nascimento,
                        DATE_FORMAT(data_batismo,'%d/%m/%Y') AS data_batismo,
                        origem_conversao.id as origem_conversao_id,
                        origem_conversao.descricao as origem_conversao_descricao,
                        origem_conversao.nome_igreja as origem_conversao_nome_igreja, 
                        origem_conversao.dtConversao as origem_conversao_dt_conversao,
                        origem_conversao.ano as origem_conversao_ano,
                        enderecos.id as enderecosId,
                        enderecos.bairro as enderecos_bairro,
                        enderecos.cidade as enderecos_cidade,
                        enderecos.uf as enderecos_uf,
                        enderecos.numero as enderecos_numero,
                        enderecos.complemento as enderecos_complemento,
                        enderecos.cep as enderecos_cep,
                        enderecos.logradouro as enderecos_logradouro
                from membros
                inner join enderecos on enderecos.id = membros.enderecos_id
                inner join origem_conversao on origem_conversao.id = membros.origem_conversao_id";
        try {        
                $rs = $this->conn->query($sqlLista);
                if($rs){
                    while($ln = $rs->fetch(PDO::FETCH_OBJ)){
                        $this->membro = new MembroVO();
                        
                        $this->membro->setBatizado($ln->batizado);
                        $this->membro->setData_batismo($ln->data_batismo);
                        $this->membro->setData_nascimento($ln->data_nascimento);
                        $this->membro->setEndereco($ln->enderecos_bairro);
                        $this->membro->setEnderecos_id($ln->enderecosId);
                        $this->membro->setEstado_civil($ln->estado_civil);                        
                        $this->membro->setFone_cel($ln->fone_cel);                        
                        $this->membro->setFone_resid($ln->fone_resid);                        
                        $this->membro->setNome($ln->nome);                        
                        $this->membro->setOrigem_conversao_id($ln->origem_conversao_id);                        
                        $this->membro->setOrigem_conversao($ln->origem_conversao_descricao);                        
                        $this->membro->setId($ln->id);
                        
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