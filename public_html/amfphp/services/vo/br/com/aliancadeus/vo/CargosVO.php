<?php

class CargosVO {
	public $id;
	public $nome;
	
	//Variavel usada para o mapeamento da class vo do lado do flex
	public $_explicitType = "br.com.simao.vo.CargosVO";	
	/**
	 * @return the $id
	 */
	function getId() {
		return $this->id;
	}

	/**
	 * @return the $nm_cargo
	 */
	function getNome() {
		return $this->nome;
	}

	/**
	 * @param $id the $id to set
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

	
	

}

?>