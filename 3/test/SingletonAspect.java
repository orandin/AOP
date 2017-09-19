import static org.junit.Assert.*;

import org.junit.Test;

import main.Clients;
import main.Orders;

public class SingletonAspect {

	@Test
	public void test_orders_singleton() {
		assertSame(new Orders(), new Orders());
	}
	
	@Test
	public void test_clients_singleton() {		
		assertSame(new Clients(), new Clients());
	}
}
