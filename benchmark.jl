include("utils.jl")
include("GLOUTON_VC.jl")
include("IPL_VC.jl")
include("ARB_VC.jl")
include("KERNEL_VC.jl")


precompile(GLOUTON_VC, (Graph,))
precompile(IPL_VC, (Graph,))
precompile(KERNEL_VC, (Graph,Int64))
precompile(ARB_VC, (Graph,Int64))

function benchmark()

    __precompile()
    A,B,C,D,E = true,true,true,true,true

    for n = [10,20,30,40,50,60,70,80,90,100,120,140,160,180,200,220,240,260,280,300,320,340,360,380,400,420,440,460,480,500]
        println(" ; ; ; ; Greedy ; ; IPL ; ; IP ; KERNEL ; ARB ")
        println("n = $n ; m ; delta ; dmoy ; Temps ; Val ; Temps ; Val ; Temps ; Temps; Temps; Val* ")
        for (p,pp) in [(4/n,"4/n"), (5/n,"5/n"), (log(n)/n, "log(n)/n"), (1/sqrt(n),"1/√n"), (0.1,"0.1"), (0.2,"0.2")]
            
            G = random_graph(n,p)
            m = sum(G.m) ÷ 2
            Δ = maximum(deg(G,i) for i = 1:n)
            dmoy = sum(deg(G,i) for i = 1:n) / n

            TT = STDOUT 
            redirect_stdout() # CPLEX est très bavard...

            a,at = @timed GLOUTON_VC(G)
            b,bt = @timed IPL_VC(G)
            c,ct = @timed IPL_VC(G, relax=false)
            d,dt = @timed KERNEL_VC(G, length(c))
            e,et = @timed ARB_VC(G, length(c))


            redirect_stdout(TT)

            al,bl,cl = length(a), length(b), length(c)

            if A&&B&&C&&D&&E
                s = 3 # nombre de chiffres significatifs
                println("p = $pp ; $m ; $Δ ; $(signif(dmoy,s)) ; $(signif(at,s)) ; $al ; $(signif(bt,s)) ; $bl ; $(signif(ct,s)) ; $(signif(dt,s)) ; $(signif(et,s)) ; $cl")
            else
                println("p = $pp ; $m ; $Δ ; $dmoy")
                A && println("Glouton :  |$(length(a))| $at")
                B && println("IPL :      |$(length(b))| $bt")
                C && println("IP :       |$(length(c))| $ct")
                D && println("KERNEL :   |$(length(d))| $dt")
                E && println("ARB :      |$(length(e))| $et")
            end

        end
        println("")
    end
end

function __precompile()
    G = random_graph(5,0.2)
    TT = STDOUT 
    redirect_stdout() # CPLEX est très bavard...

    a,at = @timed GLOUTON_VC(G)
    b,bt = @timed IPL_VC(G)
    c,ct = @timed IPL_VC(G, relax=false)
    d,dt = @timed KERNEL_VC(G, length(c))
    e,et = @timed ARB_VC(G, length(c))

    redirect_stdout(TT)

end

benchmark()