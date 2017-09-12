package main;

public class Main {

	public static void main(String[] args) {
		Singleton object = new Singleton();
		Singleton singleton = new Singleton();
		
		System.out.println(object.toString());
		System.out.println(singleton.toString());
	}
}
