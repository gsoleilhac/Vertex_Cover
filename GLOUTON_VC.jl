function GLOUTON_VC(x)
    G = Graph(copy(x.ind, x.m))
    VC = Set{Int}()
    u,v = pick_edge_max(G)
    while (u,v) != (0,0)
        push!(VC, u)
        push!(VC, v)
        del_neighbour_edges!(G, u)
        del_neighbour_edges!(G, v)
        u,v = pick_edge_max(G)
    end
    return VC
end