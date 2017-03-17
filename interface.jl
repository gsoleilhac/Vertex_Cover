include("utils.jl")
include("GLOUTON_VC.jl")
include("IPL_VC.jl")
include("ARB_VC.jl")
include("KERNEL_VC.jl")

function run_all_algos(G)
    a,at = @timed GLOUTON_VC(G)
    b,bt = @timed IPL_VC(G)
    c,ct = @timed IPL_VC(G, relax=false)
    d,dt = @timed KERNEL_VC(G, length(c))
    e,et = @timed ARB_VC(G, length(c))

    algos = ["Glouton","IPL","IP","KERNEL","ARB"]
    res = [a,b,c,d,e]
    time = [at,bt,ct,dt,et]
    for i = 1:5
        VC = res[i]
        println(algos[i], " : |$(length(VC))| $(is_VC(G,VC)) / $(time[i])")
    end
end

G = random_graph(100, 0.2)

run_all_algos(G)