package main;
import java.util.HashMap;
import java.util.Map;

public aspect SingletonAspect {	
	private Map<Class<?>, Object> instances = new HashMap<Class<?>, Object>();
	
	pointcut getInstance(): call( main..*.new(..) );
	
	Object around(): getInstance() {
		Class<?> ClassInstance = thisJoinPoint.getSignature().getDeclaringType();
		Object instance = this.instances.get(ClassInstance);
		
		if (instance == null) {
			instance = proceed();
			System.out.println("Pas d'instance : création");
			this.instances.put(ClassInstance, instance);
		} else {
			System.out.println("Instance déjà existante: récupération");
		}
		return instance;
	}
}