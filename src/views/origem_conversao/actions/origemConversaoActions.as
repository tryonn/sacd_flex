import br.com.aliancadeus.vo.Origem_conversaoVO;
import br.com.flexbrasilia.formatters.MySQLDateHelper;

import mx.collections.ArrayCollection;
import mx.controls.Alert;
import mx.controls.dataGridClasses.DataGridColumn;
import mx.events.CloseEvent;
import mx.events.FlexEvent;
import mx.rpc.events.ResultEvent;

import ro.OrigemConversao_ro;

import util.Util;

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
	protected function btnSalvar_clickHandler(event:MouseEvent):void
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
	protected function btnCancelar_clickHandler(event:MouseEvent):void
	{
		clearRecord();
		leituraBtn();
		leituraTxtInput();
	}				
	/*-----------------------------------------------------------------------*/
	protected function btnAlterar_clickHandler(event:MouseEvent):void
	{
		clearRecord();
		leituraTxtInput();
	}
/*-----------------------------------------------------------------------*/	
	protected function btnDeleta_clickHandler(event:MouseEvent):void
	{
		Alert.noLabel = ".:Não:.";
		Alert.yesLabel = ".:Sim:.";
		Alert.show('Deseja realmente excluir o registro?', 'Atenção', Alert.YES|Alert.NO, null, excluirRegistro);		
	}
	protected function excluirRegistro(e:CloseEvent):void
	{
		if(e.detail == Alert.YES){
			_registroSelecionado = dgOrigemConversao.selectedItem as Origem_conversaoVO;
			_ro_origemConversao.deleta(_registroSelecionado, excluirRecord);
			leituraTxtInput();
		}
	}
	protected function excluirRecord(e:ResultEvent):void
	{
		Alert.show(e.result.mensagem , "Mensagem");
		_datagridOrigemConversao.removeItemAt(dgOrigemConversao.selectedIndex);
		btnDeleta.enabled = false;
		clearRecord();
		_ro_origemConversao.listOrigemConversao(listaRegistroOrigem);
	}
/*-----------------------------------------------------------------------*/
	
	protected function btnNovo_clickHandler(event:MouseEvent):void
	{
		// TODO Auto-generated method stub
		escritaTxtInput();
		txtNmIgreja.setFocus();
		escritaBtn();
	}
	/*-----------------------------------------------------------------------*/
	protected function leituraBtn():void
	{
		btnAlterar.enabled= false;
		btnCancelar.enabled= false;
		btnDeleta.enabled= false;
		btnNovo.enabled= true;
		btnSalvar.enabled= false;
	}
	
	protected function escritaBtn():void
	{
		btnAlterar.enabled= false;
		btnCancelar.enabled= true;
		btnDeleta.enabled= false;
		btnNovo.enabled= false;
		btnSalvar.enabled= true;
	}
	protected function leituraTxtInput():void
	{
		txtAno.enabled = false;
		txtDescricao.enabled = false;
		txtNmIgreja.enabled = false;
		txtDtConversao.enabled = false;
	}
	
	protected function escritaTxtInput():void
	{
		txtAno.enabled = true;
		txtDescricao.enabled = true;
		txtNmIgreja.enabled = true;
		txtDtConversao.enabled = true;
	}
	protected function selecaoGridItem():void
	{
		btnAlterar.enabled= true;
		btnCancelar.enabled= true;
		btnDeleta.enabled= true;
		btnNovo.enabled= false;
		btnSalvar.enabled= false;
		escritaTxtInput();
	}
	protected function dgEndereco_clickHandler(event:MouseEvent):void
	{
		// TODO Auto-generated method stub
		selecaoGridItem();
	}

	protected function clearRecord():void
	{
		txtAno.text = "";
		txtDescricao.text = "";
		txtNmIgreja.text = "";
		txtDtConversao.text = "";
	}
	protected function dgOrigemConversao_clickHandler(event:MouseEvent):void
	{
		selecaoGridItem();
	}
/*-----------------------------------------------------------------------*/
