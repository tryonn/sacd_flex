package ro
{
	import br.com.aliancadeus.vo.Origem_conversaoVO;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;

	public class OrigemConversao_ro
	{
		private var _ro_origemConversao:RemoteObject;
		private var _async:AsyncToken;
		private static var instance:OrigemConversao_ro;
		
		public static function getInstance():OrigemConversao_ro{
			if(instance == null){
				instance = new OrigemConversao_ro();
			}
			return instance;
		}
		public function listOrigemConversao(result:Function):void{
			_async = _ro_origemConversao.getListar();
			_async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		public function save(_origemConversao:Origem_conversaoVO,result:Function):void
		{
			_async = _ro_origemConversao.inserir(_origemConversao);
			_async.addResponder(new Responder(result, defaultFaultHandler));
		}
		public function deleta(_origem_conversao:Origem_conversaoVO, result:Function):void
		{
			_async = _ro_origemConversao.excluir(_origem_conversao.id);
			_async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		public function atualiza(_origem_conversao:Origem_conversaoVO, result:Function):void
		{
			_async = _ro_origemConversao.atualizar(_origem_conversao);
			_async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		private function defaultFaultHandler(e:FaultEvent):void{
			Alert.show(e.fault.faultDetail, e.fault.message);
		}
		public function OrigemConversao_ro()
		{
			_ro_origemConversao = new RemoteObject();
			_ro_origemConversao.showBusyCursor = true;
			_ro_origemConversao.destination = 'amfphp';
			_ro_origemConversao.source = 'DAO.Origem_conversaoDAO';			
		}
	}
}