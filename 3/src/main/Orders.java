package main;
import java.util.ArrayList;
import java.util.List;

public class Orders {
	private List<Order> orderList = new ArrayList<Order>();
	
	public void addOrder(Order o) {
		orderList.add(o);
	}
	
	public void delOrder(Order o) {
		orderList.remove(o);
	}
}
