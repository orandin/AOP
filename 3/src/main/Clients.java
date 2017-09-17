package main;
import java.util.ArrayList;
import java.util.List;

public class Clients {
	private List<Client> clientList = new ArrayList<Client>();
	
	public void addClient(Client c) {
		clientList.add(c);
	}
	
	public void delClient(Client c) {
		clientList.remove(c);
	}
	
	public int size() {
		return clientList.size();
	}
}
