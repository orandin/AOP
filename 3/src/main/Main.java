package main;

public class Main {

	public static void main(String[] args) {
		//System.out.println("Init");
		Clients clientList = new Clients();
		Orders orderList = new Orders();
		
		Client bob = new Client("Bob", "fil");
		Client alice = new Client("Alice", "fil");
		
		clientList.addClient(bob);
		clientList.addClient(alice);
		
		Order o1 = new Order(1, 2.00);
		Order o2 = new Order(2, 1200);
		Order o3 = new Order(3, 42);
		
		orderList.addOrder(o1);
		orderList.addOrder(o2);
		orderList.addOrder(o3);
		
		//System.out.println("Ajout");
		
		bob.addOrder(o1);
		o1.setClient(bob);
		alice.addOrder(o2);
		o2.setClient(alice);
		alice.addOrder(o3);
		o3.setClient(alice);
		/*
		o1.printOrder();
		o2.printOrder();
		o3.printOrder();
		*/
		//System.out.println("Suppression");
		
		
		//System.out.println("Nb clients avant suppression: " + clientList.size());
		clientList.delClient(alice);
		//System.out.println("Nb clients après tentative de suppression (alice): " + clientList.size());
		
		bob.delOrder(o1);
		//System.out.println("Suppression de l'unique commande de bob");
		clientList.delClient(bob);
		//System.out.println("Nb clients après tentative de suppression (bob): " + clientList.size());
		
	}

}
