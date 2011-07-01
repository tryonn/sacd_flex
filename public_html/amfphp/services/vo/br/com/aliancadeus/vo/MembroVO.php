<?php
/**
 * Description of Membro
 *
 * @author simao
 */
class MembroVO {
  
      public $id;
      public $nome;
      public $data_nascimento;
      public $data_conversao;
      public $fone_cel;
      public $fone_resid;
      public $estado_civil;
      public $batizado;
      public $data_batismo;
      public $enderecos_id;
      public $origem_conversao_id;
      public $endereco;
      public $origem_conversao;
      
      
      //Variavel usada para o mapeamento da class vo do lado do flex
      public $_explicitType = "br.com.aliancadeus.vo.MembroVO";      
      
      
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

      public function getData_conversao() {
          return $this->data_conversao;
      }

      public function setData_conversao($data_conversao) {
          $this->data_conversao = $data_conversao;
      }

      public function getFone_cel() {
          return $this->fone_cel;
      }

      public function setFone_cel($fone_cel) {
          $this->fone_cel = $fone_cel;
      }

      public function getFone_resid() {
          return $this->fone_resid;
      }

      public function setFone_resid($fone_resid) {
          $this->fone_resid = $fone_resid;
      }

      public function getEstado_civil() {
          return $this->estado_civil;
      }

      public function setEstado_civil($estado_civil) {
          $this->estado_civil = $estado_civil;
      }

      public function getBatizado() {
          return $this->batizado;
      }

      public function setBatizado($batizado) {
          $this->batizado = $batizado;
      }

      public function getData_batismo() {
          return $this->data_batismo;
      }

      public function setData_batismo($data_batismo) {
          $this->data_batismo = $data_batismo;
      }

      public function getEnderecos_id() {
          return $this->enderecos_id;
      }

      public function setEnderecos_id($enderecos_id) {
          $this->enderecos_id = $enderecos_id;
      }

      public function getOrigem_conversao_id() {
          return $this->origem_conversao_id;
      }

      public function setOrigem_conversao_id($origem_conversao_id) {
          $this->origem_conversao_id = $origem_conversao_id;
      }

      public function getEndereco() {
          return $this->endereco;
      }

      public function setEndereco($endereco) {
          $this->endereco = $endereco;
      }

      public function getOrigem_conversao() {
          return $this->origem_conversao;
      }

      public function setOrigem_conversao($origem_conversao) {
          $this->origem_conversao = $origem_conversao;
      }

      public function get_explicitType() {
          return $this->_explicitType;
      }

      public function set_explicitType($_explicitType) {
          $this->_explicitType = $_explicitType;
      }


}

?>
