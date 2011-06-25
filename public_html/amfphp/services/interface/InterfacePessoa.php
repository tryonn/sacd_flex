<?php
include_once '../vo/br/com/simao/vo/PessoaVO.php';
Interface InterfacePessoa {
	
	public  function insert(Pessoa $pessoa);
	public  function update(Pessoa $pessoa);
	public  function deleteItem(Pessoa $pessoa);
	public  function listar();
}

?>