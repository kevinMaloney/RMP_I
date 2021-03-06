﻿package {
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import starling.events.Event;
	import starling.display.Sprite;	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.display.Image;
	import starling.utils.AssetManager
	
	import feathers.themes.MetalWorksMobileTheme;
	import feathers.events.FeathersEventType;
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import feathers.controls.Panel;
	import feathers.controls.ImageLoader;
	import feathers.controls.TabBar;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.data.ListCollection;

	public class AppController extends Screen {
		[Embed(source = "assets/sprites/SpriteSheet.xml", mimeType = "application/octet-stream")]
		public static const ATLAS_XML: Class;
		[Embed(source = "assets/sprites/SpriteSheet.png")]
		public static const ATLAS_TEXTURE: Class;
		private var atlas: TextureAtlas;
		private var atlasTexture: Texture;
		private var bgTexture: Texture;
		private var bgImgLoader: ImageLoader;
		private var button: Button;
		private var contentPanel: Panel;
		private var buttonPanel: Panel;
		private var assetMgr: AssetManager;

		public function AppController() {
			super();
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
		}
		private function initializeHandler(e: Event): void {
			this.removeEventListener(FeathersEventType.INITIALIZE, initializeHandler);
			this.stage.addEventListener(Event.RESIZE, stageResized);
			assetMgr = new AssetManager();
			assetMgr.verbose = true;
			assetMgr.enqueue(EmbeddedAssets);
			assetMgr.loadQueue(handleAssetsLoading);
		}
		private function handleAssetsLoading(ratioLoaded: Number): void {
			trace("handleAssetsLoading: " + ratioLoaded);
			if (ratioLoaded == 1) {
				startApp()
			}
		}
		private function startApp() {
			//new AeonDesktopTheme();
			new MetalWorksMobileTheme();
			//new MinimalMobileTheme();

			var screenLayout: AnchorLayout = new AnchorLayout();
			this.layout = screenLayout;
			this.width = this.stage.stageWidth;
			this.height = this.stage.stageHeight;
			atlasTexture = Texture.fromBitmap(new ATLAS_TEXTURE());
			var xml: XML = XML(new ATLAS_XML());
			atlas = new TextureAtlas(atlasTexture, xml);

			this.buttonPanel = new Panel();
			var buttonPanelLayoutData: AnchorLayoutData = new AnchorLayoutData();
			buttonPanelLayoutData.left = 10;
			buttonPanelLayoutData.right = 10;
			buttonPanelLayoutData.bottom = 10;
			this.buttonPanel.layoutData = buttonPanelLayoutData;
			var buttonPanelLayout: HorizontalLayout = new HorizontalLayout();
			buttonPanelLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			this.buttonPanel.layout = buttonPanelLayout;
			this.addChild(this.buttonPanel);

			this.contentPanel = new Panel();
			var contentPanelLayoutData: AnchorLayoutData = new AnchorLayoutData();
			contentPanelLayoutData.top = 10;
			contentPanelLayoutData.bottom = 10;
			contentPanelLayoutData.left = 10;
			contentPanelLayoutData.right = 10;
			contentPanelLayoutData.bottomAnchorDisplayObject = this.buttonPanel;
			contentPanel.layoutData = contentPanelLayoutData;
			this.addChild(contentPanel);

			bgTexture = atlas.getTexture("Mario");
			bgImgLoader = new ImageLoader();
			bgImgLoader.source = bgTexture;
			bgImgLoader.width = this.stage.stageWidth;
			bgImgLoader.maintainAspectRatio = true;
			contentPanel.addChild(bgImgLoader);
			
			this.button = new Button();
			this.button.label = "Mario";
			this.button.addEventListener(Event.TRIGGERED, button_triggeredHandler2);
			this.buttonPanel.addChild(this.button);
			
			this.button = new Button();
			this.button.label = "Luigi";
			this.button.addEventListener(Event.TRIGGERED, button_triggeredHandler1);
			this.buttonPanel.addChild(this.button);
			
			this.button = new Button();
			this.button.label = "Bowser";
			this.button.addEventListener(Event.TRIGGERED, button_triggeredHandler3);
			this.buttonPanel.addChild(this.button);
		}
		private function button_triggeredHandler2(e: Event): void {
			bgImgLoader.source = atlas.getTexture("Mario");
			trace("Mario");
			assetMgr.playSound("Sound1");
		}
		private function button_triggeredHandler1(e: Event): void {
			bgImgLoader.source = atlas.getTexture("Luigi");
			trace("Luigi");
			assetMgr.playSound("Sound2");
		}
		private function button_triggeredHandler3(e: Event): void {
			bgImgLoader.source = atlas.getTexture("Bowser");
			trace("Bowser");
			assetMgr.playSound("Sound3");
		}
		private function stageResized(e: Event): void {
			this.width = this.stage.stageWidth;
			this.height = this.stage.stageHeight;
			bgImgLoader.width = this.width;
			bgImgLoader.height = this.height;
		}
		
	}
	
}
