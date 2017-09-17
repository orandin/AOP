package main.aspectJ;

import java.util.HashMap;
import java.util.Map;

import org.aspectj.lang.Signature;

public aspect Inspector {
	private Map<Class<?>, Integer> actors = new HashMap<Class<?>, Integer>();
	private final String blanks = "                                 ";
	private final String line 	= "---------------------------------";
	private final int lineSize	= blanks.length();
	private int rank = -1;
	private int previousActorRank = 0;

	pointcut traceCallMethod(): !within(Inspector) && !within(main.aspectJ..*) && within(main..*);
	
	Object around(): traceCallMethod() {
		String lineCall = "";
		String lineCallReturn = "";
		
		Signature s = thisJoinPoint.getSignature();
		Class<?> ClassInstance = s.getDeclaringType();		
		String method = s.getName();
		method = (method.equals("<init>")) ? "new()" : method+"()";
		
		int previousActorRank = this.previousActorRank;
		int currentActorRank = getRankActor(ClassInstance);
		
		if ( previousActorRank < currentActorRank ) {
			lineCall = initPosition(previousActorRank);
			lineCallReturn = lineCall;
			lineCall += trace(previousActorRank, currentActorRank, method, "-", this.lineSize-3) + "->|";
			lineCall = traceOtherActors(currentActorRank, this.rank, lineCall, " ", this.lineSize);
			lineCallReturn += "<"+ trace(previousActorRank, currentActorRank, method, "-", this.lineSize-3) + "-|";
		}		
		else if ( previousActorRank == currentActorRank ) {
			lineCall = initPosition(currentActorRank);
			lineCall = traceCallIntern(currentActorRank, lineCall, method);
		} else {
			lineCall = initPosition(currentActorRank);
			lineCallReturn = lineCall;
			lineCall += "<" + trace(currentActorRank, previousActorRank, method, "-", this.lineSize-3) + "-";
			lineCall = traceOtherActors(currentActorRank, this.rank, lineCall, " ", this.lineSize);
			lineCallReturn += trace(previousActorRank, currentActorRank, method, "-", this.lineSize-3) + "->|";
		}
		
		System.out.println(lineCall);
		
		this.previousActorRank = currentActorRank;
		Object obj = proceed();
		
		
		if (lineCallReturn != "") {
			System.out.println(lineCallReturn);
		}
		this.previousActorRank = previousActorRank;
		
		return obj;
	}
	
	private int getRankActor(Class<?> actor) {
		if (actors.containsKey(actor))
			return actors.get(actor);
		return addActor(actor);	
	}
	
	private int addActor(Class<?> actor) {
		rank++;
		actors.put(actor, rank);
		System.out.println(initPosition(rank) +" ["+ actor.getSimpleName() + "]");
		return rank;
	}
	
	private String initPosition(int rank) {
		String out = "|";
		for(int i = 0; i < rank; i++) {
			out += blanks + "|";
		}
		return out;
	}
	
	private String trace(int fromRank, int toRank, String method, String separator, int lineSize) {
		String out = "";
		String line = separator + method;
		toRank -= 1;
		
		for(int i = fromRank; i < toRank; i++) {
			out += this.line;
			lineSize++;
		}
		
		while(line.length() < lineSize) {
			line += separator;
			
			if((line.length() % 2) != 1) {
				line += separator;
			}
		}
		
		out += line;
		return out;
	}
	
	private String traceCallIntern(int rank, String base, String method) {
		String out = base + traceOtherActors(rank, this.rank, "-+", " ", this.lineSize) + "\n";
		out += base + traceOtherActors(rank, this.rank, (" | " + method), " ", this.lineSize) + "\n";
		out += base + traceOtherActors(rank, this.rank, "<+", " ", this.lineSize);
		return out;
	}
	
	private String traceOtherActors(int fromRank, int toRank, String text, String separator, int lineSize) {
		String out = text;
		lineSize -= 1;
		
		if (fromRank == toRank)
			return out;
		
		while(out.length() < lineSize) {
			out += separator;
			
			if((out.length() % 2) != 1) {
				out += separator;
			}
		}
		
		toRank -= 1;
		out += "|";
		
		for(int i = fromRank; i < toRank; i++) {
			out += blanks + "|";
		}
		
		return out;
	}
}
