package br.com.aliancadeus.vo
{
	[Bindable]
	[RemoteClass(alias="br.com.aliancadeus.vo.EnderecoVO")]
	public class EnderecoVO
	{
		public var id:int;
		public var bairro:String;
		public var cidade:String;
		public var uf:String;
		public var numero:int;
		public var complemento:String;
		public var cep:String;
		
		public function EnderecoVO()
		{
		}
	}
}