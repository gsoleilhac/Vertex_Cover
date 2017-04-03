include("utils.jl")
include("GLOUTON_VC.jl")
include("IPL_VC.jl")
include("ARB_VC.jl")
include("KERNEL_VC.jl")


precompile(GLOUTON_VC, (Graph,))
precompile(IPL_VC, (Graph,))
precompile(KERNEL_VC, (Graph,Int64))
precompile(ARB_VC, (Graph,Int64))

function run_all_algos(G)

    TT = STDOUT
    redirect_stdout()

    a,at = @timed GLOUTON_VC(G)
    b,bt = @timed IPL_VC(G)
    c,ct = @timed IPL_VC(G, relax=false)
    d,dt = @timed KERNEL_VC(G, length(c))
    e,et = @timed ARB_VC(G, length(c))


    redirect_stdout(TT)

    algos = ["Glouton","IPL","IP","KERNEL","ARB"]
    res = [a,b,c,d,e]
    time = [at,bt,ct,dt,et]
    for i = 1:5
        VC = res[i]
        println(algos[i], " : |$(length(VC))| $(is_VC(G,VC)) / $(time[i])")
    end
end

run_all_algos(n,p) = begin 
G = random_graph(n,p) ; 
pp = if p ≈ 4/n
        "4/n"
    elseif p ≈ 5/n
        "5/n"
    elseif p ≈ log(n)
        "log(n)"
    elseif p ≈ 1/sqrt(n)
        "1/√n"
    else
        "$p"
    end
println("\n***********************************")
println("n = $n, p = $pp"); 
run_all_algos(G) 
end


if length(ARGS) == 1
    run_all_algos(parse(Int,ARGS[1]), 0.2)
elseif length(ARGS) == 2
    run_all_algos(parse(Int,ARGS[1]), parse(Float64, ARGS[2]))
end

# G = Graph(collect(1:30),[0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0; 0 0 1 0 1 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0; 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 1 0 0; 1 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0; 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0; 0 0 0 1 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 1 0 0 1 0 0 0 0 0 0 1 0 1; 0 0 0 0 0 0 0 0 0 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0; 0 0 0 0 1 0 0 0 1 0 0 0 0 0 0 0 0 1 0 1 0 0 0 1 0 0 0 0 0 0; 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 0 0; 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 1 0 1 0 0 0 0 0 0 0 0 0 0 0 1 1 0 1 0 0 0 0 0 0 1; 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 1 1 0 0 0; 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0; 0 0 0 0 0 0 0 1 0 1 1 0 0 0 0 0 0 0 0 1 0 1 0 0 0 0 0 0 0 0; 0 0 1 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 0 1 0 0 0 0 1 0 0 1 0 0 0 0 1 0 0 0 0 0 0 0; 0 0 0 0 0 0 1 1 0 0 0 0 0 0 1 1 1 0 0 0 0 0 1 0 0 1 0 0 0 0; 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 1 0 1 0 0 0; 0 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 0 1 0; 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 0 0 0; 0 0 1 0 0 0 0 1 0 0 0 1 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0; 0 0 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0])
G = Graph(collect(1:20),[0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0; 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0; 0 0 0 1 0 0 0 0 0 0 0 1 1 1 0 0 0 0 0 1; 0 1 1 0 0 0 0 1 1 1 0 0 0 0 0 1 0 0 0 0; 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1 0; 1 0 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 1; 1 0 0 1 0 0 0 0 1 1 0 0 1 0 0 0 1 0 0 1; 1 0 0 1 0 1 0 1 0 0 0 1 1 1 0 0 0 1 0 0; 0 0 0 1 0 0 0 1 0 0 0 1 1 1 1 1 0 0 0 0; 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0; 0 0 1 0 0 0 0 0 1 1 0 0 0 0 1 1 0 0 0 1; 0 0 1 0 0 0 1 1 1 1 0 0 0 1 0 1 0 0 0 0; 0 0 1 0 0 1 0 0 1 1 0 0 1 0 0 1 0 0 0 0; 0 0 0 0 0 0 0 0 0 1 0 1 0 0 0 0 0 1 0 0; 0 0 0 1 0 0 0 0 0 1 1 1 1 1 0 0 0 1 1 0; 0 1 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0; 0 0 0 0 0 0 0 0 1 0 0 0 0 0 1 1 0 0 0 0; 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 1 0 0 0 1; 0 0 1 0 0 0 1 1 0 0 0 1 0 0 0 0 0 0 1 0])
G = Graph(collect(1:10),[0 1 1 0 0 0 0 1 0 0; 1 0 1 0 1 0 1 0 0 0; 1 1 0 1 0 0 0 0 0 0; 0 0 1 0 0 0 0 0 0 0; 0 1 0 0 0 0 1 1 0 1; 0 0 0 0 0 0 0 1 1 0; 0 1 0 0 1 0 0 0 0 0; 1 0 0 0 1 1 0 0 0 1; 0 0 0 0 0 1 0 0 0 1; 0 0 0 0 1 0 0 1 1 0])

VC = IPL_VC(G, relax=false)
println("|$(VC)|")

VC = KERNEL_VC(G, 5)
println("|$(length(VC))|")

VC = ARB_VC(G, 5)
println("|$(length(VC))|")
