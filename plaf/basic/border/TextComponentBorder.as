/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.plaf.basic.border{
	
import devoron.aswing3d.graphics.*;
import devoron.aswing3d.geom.IntRectangle;
import devoron.aswing3d.*;
import flash.display.DisplayObject;
import devoron.aswing3d.plaf.*;
import devoron.aswing3d.error.ImpMissError;
import org.aswing3d.EditableComponent;
import org.aswing3d.Insets;

/**
 * Discard in aswing 2.0(Background raped his job)
 * @private
 */
public class TextComponentBorder implements Border, UIResource{

    private var light:ASColor;
    private var shadow:ASColor;
    	
	public function TextComponentBorder(){
		
	}
	
    protected function getPropertyPrefix():String {
    	throw new ImpMissError();
        return "";
    }
	
	private function reloadColors(ui:ComponentUI):void{
		light = ui.getColor(getPropertyPrefix()+"light");
		shadow = ui.getColor(getPropertyPrefix()+"shadow");
	}
    	
	public function updateBorder(c:Component, g:Graphics2D, r:IntRectangle):void
	{
		if(light == null){
			reloadColors(c.getUI());
		}
	    var x1:Number = r.x;
		var y1:Number = r.y;
		var w:Number = r.width;
		var h:Number = r.height;
		var textCom:EditableComponent = EditableComponent(c);
		if(textCom.isEditable() && c.isEnabled()){
			g.drawRectangle(new Pen(shadow, 1), x1+0.5, y1+0.5, w-1, h-1);
		}
		g.drawRectangle(new Pen(light, 1), x1+1.5, y1+1.5, w-3, h-3);		
	}
	
	public function getBorderInsets(com:Component, bounds:IntRectangle):Insets
	{
		return new Insets(2, 2, 2, 2);
	}
	
	public function getDisplay(c:Component):DisplayObject
	{
		return null;
	}
	
}
}