package main;

import java.util.ArrayList;
import java.util.List;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;

aspect ClientCustom {	
	private List<Order> Client.orderList = new ArrayList<Order>();
	public void Client.addOrder(Order o) {
		orderList.add(o);
	}
	
	public boolean Client.hasOrder() {
		return !orderList.isEmpty();
	}
	
	public void Client.delOrder(Order o) {
		orderList.remove(o);
	}
}

aspect OrderCustom {
	private Client Order.client;

	public void Order.setClient(Client client) {
		this.client = client;
	}
}

@Aspect
public class AClientOrder {

	@Pointcut("call(public void Clients.delClient(Client))")
	void canDeleteThisClient() {}
	
	@Around("canDeleteThisClient()")
	public Object canDeleteThisClientMethod( ProceedingJoinPoint jp ) {
		Object[] argsList = jp.getArgs();
		Client client = (Client) argsList[0];
		
		if (!client.hasOrder())
			return jp.proceed();
		
		System.out.println("Le client "+ client.getName() +" a encore des commandes. Suppression impossible.");
		return null;
	}
}
