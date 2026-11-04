import java.nio.file.*;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.io.*;
import javax.xml.parsers.*;
import org.w3c.dom.*;
import org.wso2.balana.*;
import org.wso2.balana.finder.*;
import org.wso2.balana.ctx.EvaluationCtx;

/** Actual unmodified Balana1.2.24 PDP, request/response XML retained per row.
 * Manifest UTF8 TSV: id policy-path request-path output-response-path.
 * A single supplied policy root is found through normal root-target matching.
 */
public class BalanaBatch {
    static class SingleRoot extends PolicyFinderModule {
        final AbstractPolicy policy;
        SingleRoot(Path path,PolicyFinder finder) throws Exception {
            DocumentBuilderFactory f=DocumentBuilderFactory.newInstance();f.setNamespaceAware(true);
            f.setFeature("http://apache.org/xml/features/disallow-doctype-decl",true);
            Element root=f.newDocumentBuilder().parse(path.toFile()).getDocumentElement();
            policy=root.getLocalName().equals("PolicySet")?PolicySet.getInstance(root,finder):Policy.getInstance(root);
        }
        public boolean isRequestSupported(){return true;}
        public void init(PolicyFinder finder){}
        public PolicyFinderResult findPolicy(EvaluationCtx ctx){
            MatchResult match=policy.match(ctx);
            if(match.getResult()==MatchResult.INDETERMINATE)return new PolicyFinderResult(match.getStatus());
            if(match.getResult()==MatchResult.MATCH)return new PolicyFinderResult(policy);
            return new PolicyFinderResult();
        }
    }
    static PDP load(String name) throws Exception {
        PolicyFinder pf=new PolicyFinder();
        Set<PolicyFinderModule> modules=new HashSet<PolicyFinderModule>();
        modules.add(new SingleRoot(Paths.get(name),pf));pf.setModules(modules);
        return new PDP(new PDPConfig(new AttributeFinder(),pf,null,false));
    }
    public static void main(String[] args) throws Exception {
        Map<String,PDP> cache=new HashMap<String,PDP>();Map<String,String> failed=new HashMap<String,String>();
        int rows=0,errors=0;
        for(String line:Files.readAllLines(Paths.get(args[0]),StandardCharsets.UTF_8)){
            if(line.trim().isEmpty())continue;
            String[] v=line.split("\t",-1);long started=System.nanoTime();String response;
            try {
                if(failed.containsKey(v[1]))throw new Exception(failed.get(v[1]));
                if(!cache.containsKey(v[1])){
                    try {cache.put(v[1],load(v[1]));}
                    catch(Throwable t){StringWriter sw=new StringWriter();t.printStackTrace(new PrintWriter(sw));failed.put(v[1],sw.toString());throw t;}
                }
                String request=new String(Files.readAllBytes(Paths.get(v[2])),StandardCharsets.UTF_8);
                response=cache.get(v[1]).evaluate(request);
            }catch(Throwable t){errors++;StringWriter sw=new StringWriter();t.printStackTrace(new PrintWriter(sw));response="<EngineError>"+sw.toString().replace("&","&amp;").replace("<","&lt;").replace(">","&gt;")+"</EngineError>";}
            Path out=Paths.get(v[3]);Files.createDirectories(out.getParent());Files.write(out,response.getBytes(StandardCharsets.UTF_8));
            System.out.println(v[0]+"\t"+((System.nanoTime()-started)/1000000.0)+"\t"+out.toString());rows++;
        }
        System.err.println("BALANA_BATCH rows="+rows+" engine_errors="+errors+" java="+System.getProperty("java.version"));
    }
}
