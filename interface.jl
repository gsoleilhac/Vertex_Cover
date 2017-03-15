include("utils.jl")
include("GLOUTON_VC.jl")
include("IPL_VC.jl")
include("ARB_VC.jl")
include("KERNEL_VC.jl")

function run_all_algos(G, k)
    a = GLOUTON_VC(G)
    b = IPL_VC(G)
    c = IPL_VC(G, relax=false)
    d = KERNEL_VC(G, length(c))
    e = ARB_VC(G, length(c))

    for i in [a,b,c,d,e]
        println("|$(length(i))| : $i")
    end
end

G = random_graph(20, 0.2)