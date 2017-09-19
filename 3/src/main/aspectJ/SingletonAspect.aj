package main.aspectJ;
import java.util.HashMap;
import java.util.Map;

public aspect SingletonAspect {	
	private Map<Class<?>, Object> instances = new HashMap<Class<?>, Object>();
	
	pointcut getInstance(): (call(*.Orders.new(..)) || call(*.Clients.new(..)));
	
	Object around(): getInstance() {
		Class<?> ClassInstance = thisJoinPoint.getSignature().getDeclaringType();
		Object instance = this.instances.get(ClassInstance);
		
		if (instance == null) {
			instance = proceed();
			System.out.println("[Singleton] Pas d'instance : création");
			this.instances.put(ClassInstance, instance);
		} else {
			System.out.println("[Singleton] Instance déjà existante: récupération");
		}
		return instance;
	}
}