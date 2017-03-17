function KERNEL_VC(g, k, VC=Set{Int}())
    G = deepcopy(g)
    VC = Set{Int}()
    while true
        if k == 0 
            return VC
        end
        u = vertex_deg_equals_x(G, 1)
        if u!= 0
            v = voisins(G, u)[1]
            push!(VC, v)
            del_neighbour_edges!(G, v)
            k = k-1
        else
            v = vertex_deg_geq_than_x(G, k+1)
            if v != 0
                push!(VC, v)
                k = k-1
                del_neighbour_edges!(G, v)
            else
                break
            end
        end
    end
    if count_edges(G) > k^2
        return Set()
    else
        return union(VC, GLOUTON_VC(G))
    end
end