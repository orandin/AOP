public class A {
    public void callB() {
        B b = new B();
        b.print("Hello world");
    }
    
    public static void main(String[] args) {
		A a = new A();
		a.callB();
	}
}
