/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.plaf{

import devoron.aswing3d.JTable;
import devoron.aswing3d.geom.IntDimension;

/**
 * Pluginable ui for JTable.
 * @see devoron.aswing3d.JTable
 * @author iiley
 */
public interface TableUI extends ComponentUI{
	
    /**
     * Returns the view size.
     */    
	function getViewSize(table:JTable):IntDimension;
}
}