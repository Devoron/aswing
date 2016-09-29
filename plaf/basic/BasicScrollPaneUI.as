/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.plaf.basic
{
	
import devoron.aswing3d.plaf.BaseComponentUI;
import devoron.aswing3d.*;
import devoron.aswing3d.event.*;
import devoron.aswing3d.geom.*;

/**
 * The basic scroll pane ui imp.
 * @author iiley
 * @private
 */
public class BasicScrollPaneUI extends BaseComponentUI{

	protected var scrollPane:JScrollPane;
	protected var lastViewport:Viewportable;
	
	public function BasicScrollPaneUI(){
	}
    	
    override public function installUI(c:Component):void{
		scrollPane = JScrollPane(c);
		installDefaults();
		installComponents();
		installListeners();
    }
    
	override public function uninstallUI(c:Component):void{
		scrollPane = JScrollPane(c);
		uninstallDefaults();
		uninstallComponents();
		uninstallListeners();
    }
    
    protected function getPropertyPrefix():String {
        return "ScrollPane.";
    }
    
	protected function installDefaults():void{
		var pp:String = getPropertyPrefix();
        LookAndFeel.installColorsAndFont(scrollPane, pp);
        LookAndFeel.installBorderAndBFDecorators(scrollPane, pp);
        LookAndFeel.installBasicProperties(scrollPane, pp);
        if(!scrollPane.getVerticalScrollBar().isFocusableSet()){
        	scrollPane.getVerticalScrollBar().setFocusable(false);
        	scrollPane.getVerticalScrollBar().setFocusableSet(false);
        }
        if(!scrollPane.getHorizontalScrollBar().isFocusableSet()){
        	scrollPane.getHorizontalScrollBar().setFocusable(false);
        	scrollPane.getHorizontalScrollBar().setFocusableSet(false);
        }
	}
    
    protected function uninstallDefaults():void{
    	LookAndFeel.uninstallBorderAndBFDecorators(scrollPane);
    }
    
	protected function installComponents():void{
    }
	protected function uninstallComponents():void{
    }
	
	protected function installListeners():void{
		scrollPane.addAdjustmentListener(__adjustChanged);
		scrollPane.addEventListener(ScrollPaneEvent.VIEWPORT_CHANGED, __viewportChanged);
		__viewportChanged(null);
	}
    
    protected function uninstallListeners():void{
		scrollPane.removeAdjustmentListener(__adjustChanged);
		scrollPane.removeEventListener(ScrollPaneEvent.VIEWPORT_CHANGED, __viewportChanged);
		if(lastViewport != null){
			lastViewport.removeStateListener(__viewportStateChanged);
		}
    }
    
	//-------------------------listeners--------------------------
    protected function syncScrollPaneWithViewport():void{
		var viewport:Viewportable = scrollPane.getViewport();
		var vsb:JScrollBar = scrollPane.getVerticalScrollBar();
		var hsb:JScrollBar = scrollPane.getHorizontalScrollBar();
		if (viewport != null) {
		    var extentSize:IntDimension = viewport.getExtentSize();
		    if(extentSize.width <=0 || extentSize.height <= 0){
		    	//trace("/w/zero extent size");
		    	return;
		    }
		    var viewSize:IntDimension = viewport.getViewSize();
		    var viewPosition:IntPoint = viewport.getViewPosition();
			var extent:int, max:int, value:int;
		    if (vsb != null) {
				extent = extentSize.height;
				max = viewSize.height;
				value = Math.max(0, Math.min(viewPosition.y, max - extent));
				vsb.setValues(value, extent, 0, max);
				vsb.setUnitIncrement(viewport.getVerticalUnitIncrement());
				vsb.setBlockIncrement(viewport.getVerticalBlockIncrement());
	    	}

		    if (hsb != null) {
				extent = extentSize.width;
				max = viewSize.width;
				value = Math.max(0, Math.min(viewPosition.x, max - extent));
				hsb.setValues(value, extent, 0, max);
				hsb.setUnitIncrement(viewport.getHorizontalUnitIncrement());
				hsb.setBlockIncrement(viewport.getHorizontalBlockIncrement());
	    	}
		}
    }	
	
	private function __viewportChanged(e:ScrollPaneEvent):void{
		if(lastViewport != null){
			lastViewport.removeStateListener(__viewportStateChanged);
		}
		lastViewport = scrollPane.getViewport();
		lastViewport.addStateListener(__viewportStateChanged);
	}
	
	private function __viewportStateChanged(e:InteractiveEvent):void{
		syncScrollPaneWithViewport();
	}
	
    private function __adjustChanged(e:ScrollPaneEvent):void{
    	var viewport:Viewportable = scrollPane.getViewport();
    	viewport.scrollRectToVisible(scrollPane.getVisibleRect(), e.isProgrammatic());
    }
	
}
}