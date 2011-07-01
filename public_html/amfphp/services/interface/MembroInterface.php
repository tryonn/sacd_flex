<?php
include_once '../vo/br/com/aliancadeus/vo/MembroVO.php';
/**
 *
 * @author simao
 */
interface MembroInterface {
    
    public function inserir(MembroVO $membro);
    public function getListar();
    public function atualizar(MembroVO $membro);
    public function excluir($id);
}