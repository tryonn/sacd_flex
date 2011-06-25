<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of UsuarioVO
 *
 * @author simao
 */
class UsuarioVO {
    //put your code here
    public $id;
    public $login;
    public $senha;
    public $ultimo_login;
    public $perfis_id;
    public $membros_id;
    

    //Variavel usada para o mapeamento da class vo do lado do flex
    public $_explicitType = "vo.UsuarioVO";	
    
    
    public function __construct() {
        
    }
    
    
    
    public function getId() {
        return $this->id;
    }

    public function setId($id) {
        $this->id = $id;
    }

    public function getLogin() {
        return $this->login;
    }

    public function setLogin($login) {
        $this->login = $login;
    }

    public function getSenha() {
        return $this->senha;
    }

    public function setSenha($senha) {
        $this->senha = $senha;
    }

    public function getUltimo_login() {
        return $this->ultimo_login;
    }

    public function setUltimo_login($ultimo_login) {
        $this->ultimo_login = $ultimo_login;
    }

    public function getPerfis_id() {
        return $this->perfis_id;
    }

    public function setPerfis_id($perfis_id) {
        $this->perfis_id = $perfis_id;
    }

    public function getMembros_id() {
        return $this->membros_id;
    }

    public function setMembros_id($membros_id) {
        $this->membros_id = $membros_id;
    }


}

?>
