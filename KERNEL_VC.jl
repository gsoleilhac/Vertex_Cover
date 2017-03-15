function KERNEL_VC(g, k, VC=Set{Int}())
    G = deepcopy(g)
    VC = Set{Int}()
    while true
        k == 0 && return Set()
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
    return VC
end