<?php
include_once '../vo/br/com/aliancadeus/vo/MembroVO.php';
/**
 *
 * @author simao
 */
interface MembroInterface {
    
    public function insert(MembroVO $membro);
    public function getListar();
    public function update(MembroVO $membro);
    public function excluir($id);
}