<?php
class EnderecoVO {
    //put your code here
  public $id;
  public $bairro;
  public $cidade;
  public $uf;
  public $numero;
  public $complemento;
  public $cep;
  
      //Variavel usada para o mapeamento da class vo do lado do flex
    public $_explicitType = "br.com.aliancadeus.vo.EnderecoVO";	
  
  public function getId() {
      return $this->id;
  }

  public function setId($id) {
      $this->id = $id;
  }

  public function getBairro() {
      return $this->bairro;
  }

  public function setBairro($bairro) {
      $this->bairro = $bairro;
  }

  public function getCidade() {
      return $this->cidade;
  }

  public function setCidade($cidade) {
      $this->cidade = $cidade;
  }

  public function getUf() {
      return $this->uf;
  }

  public function setUf($uf) {
      $this->uf = $uf;
  }
  
  public function getNumero() {
      return $this->numero;
  }

  public function setNumero($numero) {
      $this->numero = $numero;
  }

  public function getComplemento() {
      return $this->complemento;
  }

  public function setComplemento($complemento) {
      $this->complemento = $complemento;
  }

  public function getCep() {
      return $this->cep;
  }

  public function setCep($cep) {
      $this->cep = $cep;
  }





}

?>
