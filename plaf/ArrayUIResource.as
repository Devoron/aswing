package devoron.aswing3d.plaf{

public dynamic class ArrayUIResource extends Array implements UIResource{
	
	public function ArrayUIResource(content:Array=null){
		if(content){
			for each(var obj:* in content){
				push(obj);
			}
		}
	}
	
}
}