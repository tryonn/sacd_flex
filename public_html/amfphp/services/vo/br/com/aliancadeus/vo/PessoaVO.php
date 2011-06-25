<?php

class PessoaVO {
	
	public $id;
	public $nome;
	public $endereco;
	public $sexo;
	public $cargo_id;
	public $cargo;
	
	//Variavel usada para o mapeamento da class vo do lado do flex
	public $_explicitType = "br.com.simao.vo.PessoaVO";	
	
	/**
	 * @return the $idPessoa
	 */
	function getId() {
		return $this->id;
	}
	/**
	 * @param $cargo the $cargo to set
	 */
	function setCargo($cargo) {
		$this->cargo = $cargo;
	}

	/**
	 * @return the $cargo
	 */
	function getCargo() {
		return $this->cargo;
	}

	/**
	 * @param $cargo_id the $cargo_id to set
	 */
	function setCargo_id($cargo_id) {
		$this->cargo_id = $cargo_id;
	}

	/**
	 * @return the $cargo_id
	 */
	function getCargo_id() {
		return $this->cargo_id;
	}


	/**
	 * @return the $nome
	 */
	function getNome() {
		return $this->nome;
	}

	/**
	 * @return the $endereco
	 */
	function getEndereco() {
		return $this->endereco;
	}

	/**
	 * @return the $sexo
	 */
	function getSexo() {
		return $this->sexo;
	}

	/**
	 * @param $idPessoa the $idPessoa to set
	 */
	function setId($id) {
		$this->id = $id;
	}

	/**
	 * @param $nome the $nome to set
	 */
	function setNome($nome) {
		$this->nome = $nome;
	}

	/**
	 * @param $endereco the $endereco to set
	 */
	function setEndereco($endereco) {
		$this->endereco = $endereco;
	}

	/**
	 * @param $sexo the $sexo to set
	 */
	function setSexo($sexo) {
		$this->sexo = $sexo;
	}
}
?>