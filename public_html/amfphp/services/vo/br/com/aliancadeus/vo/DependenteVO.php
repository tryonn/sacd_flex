<?php
/**
 * Description of DependenteVO
 *
 * @author simao
 */
class DependenteVO {
    public $id;
    public $nome;
    public $data_nascimento;
    public $membros_id;
    public $membro;
    
    //Variavel usada para o mapeamento da class vo do lado do flex
    public $_explicitType = "br.com.aliancadeus.vo.DependenteVO";	

    public function getId() {
        return $this->id;
    }

    public function setId($id) {
        $this->id = $id;
    }

    public function getNome() {
        return $this->nome;
    }

    public function setNome($nome) {
        $this->nome = $nome;
    }

    public function getData_nascimento() {
        return $this->data_nascimento;
    }

    public function setData_nascimento($data_nascimento) {
        $this->data_nascimento = $data_nascimento;
    }

    public function getMembros_id() {
        return $this->membros_id;
    }

    public function setMembros_id($membros_id) {
        $this->membros_id = $membros_id;
    }

    public function getMembro() {
        return $this->membro;
    }

    public function setMembro($membro) {
        $this->membro = $membro;
    }


}

?>
