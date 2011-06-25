import br.com.aliancadeus.vo.Origem_conversaoVO;
import br.com.flexbrasilia.formatters.MySQLDateHelper;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.controls.dataGridClasses.DataGridColumn;
import mx.events.FlexEvent;
import mx.rpc.events.ResultEvent;

import ro.OrigemConversao_ro;

import util.Util;

	/*----------------------- Variaveis Usadas --------------------*/ 
	/*-------------------------------------------------------------*/

	[Bindable]	
	private var _origemConversao:Origem_conversaoVO = new Origem_conversaoVO();
	private var _ro_origemConversao:OrigemConversao_ro = OrigemConversao_ro.getInstance();
	[Bindable]
	private var _registroSelecionado:Origem_conversaoVO = new Origem_conversaoVO();
	[Bindable]
	private var _datagridOrigemConversao:ArrayCollection;
	/*-------------------------------------------------------------*/
	/*----------------------- Fim das Variaveis --------------------*/ 

	/*----------------- Função que lista os registros do banco no datagrid -------------*/
	public function listaRegistroOrigem(e:ResultEvent):void
	{
		_datagridOrigemConversao = new ArrayCollection(e.result as Array);
	}
	/*-------------------------------------------------------------*/
	
	/*--------------- Função que é chamada no inicio da aplicação ----------------------------*/
	public function init(event:FlexEvent):void
	{
		_ro_origemConversao.listOrigemConversao(listaRegistroOrigem);
	}
	/*-------------------------------------------------------------*/
	
	/*------------------- Funão do método salvar ----------------------------------*/
	protected function btnNovo_clickHandler(event:MouseEvent):void
	{
		if(	txtAno.text 			!= "" ||
			txtDescricao.text 		!= "" ||
			txtNmIgreja.text 		!= "" ||
			txtDtConversao.text 	!= "")
		{
			_origemConversao.ano = parseInt(txtAno.text);
			_origemConversao.descricao = txtDescricao.text;
			_origemConversao.nome_igreja = txtNmIgreja.text;
			_origemConversao.dtConversao = MySQLDateHelper.formatToMySQL(txtDtConversao.selectedDate);
			
			_ro_origemConversao.save(_origemConversao,saveOnResult);
		} else{
			Alert.show("Campos com * Obrigatorio", "Atenção!");
		}
	}

	protected function saveOnResult(e:ResultEvent):void
	{
		Alert.show(e.result.mensagem , "Mensagem");
		_datagridOrigemConversao.addItem(e.result);
		_ro_origemConversao.listOrigemConversao(listaRegistroOrigem);
	}
	/*-------------------------------------------------------------*/
	protected function registroSelecionado(e:Event):void
	{
		_registroSelecionado = Origem_conversaoVO(e.currentTarget.selectedItem);
		txtAno.text = _registroSelecionado.ano.toString();
		txtDescricao.text = _registroSelecionado.descricao;
		txtNmIgreja.text = _registroSelecionado.nome_igreja;
		txtDtConversao.text = _registroSelecionado.dtConversao;
		
	}

	/*-------------- Formata data para datagrid --------------------*/ 
	/*--------------------------------------------------------------*/
	private function FormataDatas(item:Object, coluna:DataGridColumn):String 
	{
		return dateFormatter.format(item[ coluna.dataField ]);
	}
/*-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------*/
	

