<?php
/**
 * Description of Batismo_aguasVO
 *
 * @author simao
 */
class Origem_conversaoVO {
    
    public $id;
    public $descricao;
    public $nome_igreja;
    public $dtConversao;
    public $ano;
    
    
    //Variavel usada para o mapeamento da class vo do lado do flex
    public $_explicitType = "br.com.aliancadeus.vo.Origem_conversaoVO";
    
    public function getId() {
        return $this->id;
    }

    public function setId($id) {
        $this->id = $id;
    }

    public function getDescricao() {
        return $this->descricao;
    }

    public function setDescricao($descricao) {
        $this->descricao = $descricao;
    }

    public function getNome_igreja() {
        return $this->nome_igreja;
    }

    public function setNome_igreja($nome_igreja) {
        $this->nome_igreja = $nome_igreja;
    }

    public function getDtConversao() {
        return $this->dtConversao;
    }

    public function setDtConversao($dtConversao) {
        $this->dtConversao = $dtConversao;
    }

    public function getAno() {
        return $this->ano;
    }

    public function setAno($ano) {
        $this->ano = $ano;
    }

    public function get_explicitType() {
        return $this->_explicitType;
    }

    public function set_explicitType($_explicitType) {
        $this->_explicitType = $_explicitType;
    }


}

?>
