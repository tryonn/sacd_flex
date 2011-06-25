package ro
{	
	import br.com.aliancadeus.vo.EnderecoVO;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;

	public class Endereco_ro
	{
		private var _ro_endereco:RemoteObject;
		private var _async:AsyncToken;
		private static var instance:Endereco_ro;
		
		public static function getInstance():Endereco_ro{
			if(instance == null){
				instance = new Endereco_ro();
			}
			return instance;
		}
		
		public function listEndereco(result:Function):void{
			_async = _ro_endereco.getListar();
			_async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		public function inserir(_enderecoVO:EnderecoVO, result:Function):void{
			_async = _ro_endereco.inserir(_enderecoVO);
			_async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		public function atualizar(_enderecoVO:EnderecoVO, result:Function):void
		{
			_async = _ro_endereco.atualizar(_enderecoVO);
			_async.addResponder(new Responder(result,defaultFaultHandler));
		}
		public function deleta(_enderecoVO:EnderecoVO, result:Function):void
		{
			_async = _ro_endereco.excluir(_enderecoVO.id);
			_async.addResponder(new Responder(result, defaultFaultHandler));
		}
		
		private function defaultFaultHandler(e:FaultEvent):void{
			Alert.show(e.fault.faultDetail, e.fault.message);
		}
		public function Endereco_ro()
		{
			_ro_endereco = new RemoteObject();
			_ro_endereco.showBusyCursor = true;
			_ro_endereco.destination = 'amfphp';
			_ro_endereco.source = 'DAO.EnderecoDAO';
		}
	}
}