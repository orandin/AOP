
public class Client {

	private String name;
	private String address;
	
	public Client(String name, String address) {
		this.setName(name);
		this.address = address;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

}
