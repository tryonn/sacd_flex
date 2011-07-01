package br.com.aliancadeus.vo
{
	[Bindable]
	[RemoteClass(alias="br.com.aliancadeus.vo.MembroVO")]
	public class MembroVO
	{
		public var id:int;
		public var nome:String;
		public var data_nascimento:String;
		public var data_conversao:String;
		public var fone_cel:String;
		public var fone_resid:String;
		public var estado_civil:String;
		public var batizado:String;
		public var data_batismo:String;
		public var enderecos_id:int;
		public var origem_conversao_id:int;
		public var endereco:String;
		public var origem_conversao:String;
		
		public function MembroVO()
		{
		}
	}
}