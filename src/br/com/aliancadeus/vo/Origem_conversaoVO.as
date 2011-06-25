package br.com.aliancadeus.vo
{
	[Bindable]
	[RemoteClass(alias="br.com.aliancadeus.vo.Origem_conversaoVO")]
	public class Origem_conversaoVO
	{
		public var id:int;
		public var descricao:String;
		public var nome_igreja:String;
		public var dtConversao:String;
		public var ano:int;
		
		public function Origem_conversaoVO()
		{
		}
	}
}