<?php
include_once '../vo/br/com/aliancadeus/vo/Origem_conversaoVO.php';
/**
 *
 * @author simao
 */
interface Origem_conversaoInterface {
    
    public function inserir(Origem_conversaoVO $Origem_conversao);
    public function getListar();
    public function atualizar(Origem_conversaoVO $Origem_conversao);
    public function excluir($id);
}

?>
