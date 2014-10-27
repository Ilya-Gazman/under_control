package assets.game
{
	public class StaticAssets
	{
		// Texture
		[Embed(source="sprites.png")]
		public static const sprites:Class;
		
		// XML
		[Embed(source="sprites.xml", mimeType="application/octet-stream")]
		public static const imageXml:Class;
	}
}