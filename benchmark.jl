include("utils.jl")
include("GLOUTON_VC.jl")
include("IPL_VC.jl")
include("ARB_VC.jl")
include("KERNEL_VC.jl")


function benchmark()

    __precompile()
    terminates = trues(5,6)
    # terminates[2,:] .= true

    n = 10
    while any(terminates)
        println(" ; ; ; ; Greedy ; ; IPL ; ; IP ; KERNEL ; ARB ")
        println("n = $n ; m ; delta ; dmoy ; Temps ; Val ; Temps ; Val ; Temps ; Temps; Temps; Val* ")
        ptab = [4/n,5/n,log(n)/n,1/sqrt(n),0.1,0.2]
        pname = ["4/n", "5/n", "log(n)/n", "1/√n", "0.1", "0.2"]
        for pi = 1:6
            
            p = ptab[pi]

            G = random_graph(n,p)
            m = sum(G.m) ÷ 2
            Δ = maximum(deg(G,i) for i = 1:n)
            dmoy = sum(deg(G,i) for i = 1:n) / n

            TT = STDOUT 
            redirect_stdout() # CPLEX est très bavard...

            if terminates[1, pi]
                a,at = @timed GLOUTON_VC(G)
                at > 180 && (terminates[1,pi] = false)
            else
                a,at = [],0
            end
            if terminates[2, pi]
                b,bt = @timed IPL_VC(G)
                bt > 180 && (terminates[2,pi] = false)
            else
                b,bt = [],0
            end
            if terminates[3, pi]
                c,ct = @timed IPL_VC(G, relax=false)
                ct > 180 && (terminates[3,pi] = false)
            else
                c,ct = [],0
            end
            if terminates[4, pi]
                d,dt = @timed KERNEL_VC(G, length(c))
                dt > 180 && (terminates[4,pi] = false)
            else
                d,dt = [],0
            end
            if terminates[5, pi]
                e,et = @timed ARB_VC(G, length(c))
                et > 180 && (terminates[5,pi] = false)
            else
                e,et = [],0
            end

            sleep(0.1)
            redirect_stdout(TT)

            al,bl,cl = length(a), length(b), length(c)

            
            s = 3 # nombre de chiffres significatifs
            println("p = $(pname[pi]) ; $m ; $Δ ; $(signif(dmoy,s)) ; $(signif(at,s)) ; $al ; $(signif(bt,s)) ; $bl ; $(signif(ct,s)) ; $(signif(dt,s)) ; $(signif(et,s)) ; $cl")

        end
        if n < 100
            n += 10
        elseif n < 500
            n += 20
        elseif n < 1000
            n += 50
        elseif n < 2000
            n += 100
        else
            n += 500
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
    return b,bt
end

benchmark()