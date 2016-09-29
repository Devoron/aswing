/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package devoron.aswing3d.ext{

import devoron.aswing3d.*;
import devoron.aswing3d.event.InteractiveEvent;
import devoron.aswing3d.layout.BorderLayout;
import org.aswing3d.ASFont;

/**
 * Dispatched when the button's state changed. the state is all about:
 * <ul>
 * <li>enabled</li>
 * <li>rollOver</li>
 * <li>pressed</li>
 * <li>released</li>
 * <li>selected</li>
 * </ul>
 * </p>
 * <p>
 * Buttons always fire <code>programmatic=false</code> InteractiveEvent.
 * </p>
 * @eventType devoron.aswing3d.event.InteractiveEvent.STATE_CHANGED
 */
[Event(name="stateChanged", type="devoron.aswing3d.event.InteractiveEvent")]

/**
 * A panel with a title bar, click the title bar can collapse or expand the panel content.
 * @author iiley
 */
public class Folder extends JPanel{

	public static const TOP:int = AsWingConstants.TOP;
	public static const BOTTOM:int = AsWingConstants.BOTTOM;
	
	protected var titleButton:JToggleButton;
	protected var contentPane:Component;
	protected var title:String;
	protected var titlePosition:int;
	protected var gap:int;
	
	/**
	 * Folder(title:String, titlePosition:Number, gap:Number)<br>
	 * Folder(title:String, titlePosition:Number) default gap to 4<br>
	 * Folder(title:String) default titlePosition to TOP<br>
	 * Folder() default title to ""
	 */
	public function Folder(title:String="", titlePosition:int=AsWingConstants.TOP, gap:int=4) {
		super();
		setName("Folder");
		this.title = title;
		this.titlePosition = titlePosition;
		this.gap = gap;
		setLayout(new BorderLayout(0, gap));
		titleButton = createTitleButton();
		titleButton.setSelected(false);
		setForeground(new ASColor(0x336600));
		setFocusable(false);
		
		titleButton.addSelectionListener(__titleSelectionChanged);
		initTitleBar();
		changeTitleRepresentWhenStateChanged();
	}
	
	protected function createTitleButton():JToggleButton{
		return new JToggleButton();
	}
	
	/**
	 * Override this method to init different LAF title bar
	 */
	protected function initTitleBar():void{
		setFont(new ASFont("Dialog", 12, true));
		titleButton.setFont(null);
		titleButton.setHorizontalAlignment(AsWingConstants.LEFT);
		if(titlePosition == BOTTOM){
			titleButton.setConstraints(BorderLayout.SOUTH);
		}else{
			titleButton.setConstraints(BorderLayout.NORTH);
		}
		super.insertImp(0, titleButton);
	}
	
	/**
	 * Override this method to control the title representation.
	 */
	protected function changeTitleRepresentWhenStateChanged():void{
		if(isExpanded()){
			titleButton.setText("- " + getTitle());
		}else{
			titleButton.setText("+ " + getTitle());
		}
	}
	
	protected function __titleSelectionChanged(e:InteractiveEvent):void{
		getContentPane().setVisible(titleButton.isSelected());
		changeTitleRepresentWhenStateChanged();
		dispatchEvent(new InteractiveEvent(InteractiveEvent.STATE_CHANGED, e.isProgrammatic()));
		revalidate();
	}
	
	/**
	 * Adds listener to listen the expand or collapse state change event.
	 */
	public function addChangeListener(func:Function, priority:int=0, useWeekReference:Boolean=false):void{
		addEventListener(InteractiveEvent.STATE_CHANGED, func, false, priority, useWeekReference);
	}
	
	/**
	 * Sets the folder font, title font will keep same to this
	 */
	override public function setFont(f:ASFont):void{
		super.setFont(f);
		if(titleButton){
			titleButton.repaint();
		}
	}
		
	public function setTitleForeground(c:ASColor):void{
		titleButton.setForeground(c);
	}
	public function getTitleForeground():ASColor{
		return titleButton.getForeground();
	}
	
	public function setTitleBackground(c:ASColor):void{
		titleButton.setBackground(c);
	}
	public function getTitleBackground():ASColor{
		return titleButton.getBackground();
	}
	
	public function setTitleToolTipText(t:String):void{
		titleButton.setToolTipText(t);
	}
	public function getTitleToolTipText():String{
		return titleButton.getToolTipText();
	}
	
	/**
	 * Returns whether the folder is expanded or not.
	 */
	public function isExpanded():Boolean{
		return titleButton.isSelected();
	}
	
	/**
	 * Sets whether to expand the folder or not.
	 */
	public function setExpanded(b:Boolean):void{
		titleButton.setSelected(b);
	}
	
	/**
	 * Sets the title
	 */
	public function setTitle(t:String):void{
		if(t != title){
			title = t;
			changeTitleRepresentWhenStateChanged();
		}
	}
	
	/**
	 * Returns the title
	 */
	public function getTitle():String{
		return title;
	}
	
	/**
	 * Returns the content pane
	 */
	public function getContentPane():Component{
		if(contentPane == null){
			contentPane = new JPanel();
			contentPane.setConstraints(BorderLayout.CENTER);
			contentPane.setVisible(isExpanded());
			super.insert(-1, contentPane);
		}
		return contentPane;
	}
	
	/**
	 * Sets the content pane
	 * @param p the content pane
	 */
	public function setContentPane(p:Component):void{
		if(contentPane != p){
			remove(contentPane);
			contentPane = p;
			contentPane.setConstraints(BorderLayout.CENTER);
			contentPane.setVisible(isExpanded());
			super.insert(-1, contentPane);
		}
	}
	
	override public function append(c:Component, constraints:Object=null):void{
		if(c.getConstraints() == null){
			c.setConstraints(constraints);
		}
		setContentPane(c);
	}
	
	/**
	 * Adds this folder to a group, to achieve one time there just can be one or less folder are expanded.
	 * @param group the group to add in.
	 */
	public function addToGroup(group:ButtonGroup):void{
		if(!group.contains(titleButton)){
			group.append(titleButton);
		}
	}
	
	/**
	 * Removes this folder from a group.
	 * @see #addToGroup()
	 */
	public function removeFromGroup(group:ButtonGroup):void{
		group.remove(titleButton);
	}
}
}