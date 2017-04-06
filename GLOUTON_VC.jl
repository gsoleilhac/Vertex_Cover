function GLOUTON_VC(g::Graph)
    G = Graph(copy(g.ind), g.m)
    VC = Set{T}()
    u,v = pick_edge_max(G)
    while (u,v) != (T(0),T(0))
        push!(VC, u)
        push!(VC, v)
        del_neighbour_edges!(G, u)
        del_neighbour_edges!(G, v)
        u,v = pick_edge_max(G)
    end
    return VC
end