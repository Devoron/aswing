/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.skinbuilder{

import devoron.aswing3d.plaf.basic.BasicProgressBarUI;
import flash.display.DisplayObject;
import devoron.aswing3d.geom.IntDimension;

public class SkinProgressBarUI extends BasicProgressBarUI{
	
	protected var barWidth:int;
	
	override protected function installDefaults():void{
		super.installDefaults();
		
		barWidth = 0;
		var bgAsset:DisplayObject = progressBar.getBackgroundDecorator().getDisplay(progressBar);
		if(bgAsset != null){
			barWidth = bgAsset.height;
		}
	}
	
	override protected function uninstallDefaults():void{
		super.uninstallDefaults();
		barWidth = 0;
	}
    
    override protected function getPreferredInnerHorizontal():IntDimension{
    	return new IntDimension(80, barWidth > 0 ? barWidth : 12);
    }
    
    override protected function getPreferredInnerVertical():IntDimension{
    	return new IntDimension(barWidth > 0 ? barWidth : 12, 80);
    }
}
}