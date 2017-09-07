import org.aspectj.lang.JoinPoint;

aspect ATrace {
    pointcut toBeTraced():
        call( void B.print(..) ) ||
        execution( public * *.print(..) );

    before(): toBeTraced()
    {
        JoinPoint point = thisJoinPoint;

        String s = point.getSourceLocation().getFileName();
        s += " "+ point.getTarget();
        s += " "+ point.getSignature().getName();

        String a = "params :";

        Object[] oList = point.getArgs();
        for(Object o : oList) {
            a += " "+ o.toString();
        }

        s += " "+ a;

        System.out.println(s);
    }
}
