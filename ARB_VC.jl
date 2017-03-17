function simple_VC(G)
    VC = Set{Int}()
    x = vertex_deg_geq_than_x(G, 2)
    while x != 0
        push!(VC, x)
        del_neighbour_edges!(G, x)
        x = vertex_deg_geq_than_x(G, 2)
    end
    x = vertex_deg_geq_than_x(G,1)
    while x != 0
        push!(VC, x)
        del_neighbour_edges!(G, x)
        x = vertex_deg_geq_than_x(G, 1)
    end
    return VC
end

function ARB_VC(G::Matrix{Int}, k, VC=Set{Int}())

    u = vertex_deg_geq_than_x(G,3)
    if u == 0
        return union(simple_VC(G), VC)
    elseif k ==0
        if all(x -> x == 0, G)
            return VC
        else
            return Set{Int}()
        end
    else
        G_left = deepcopy(G)
        del_neighbour_edges!(G_left, u)
        ARB_left = ARB_VC(G_left, k-1, union(VC, u))

        G_right = deepcopy(G)
        nb = voisins(G_right, u)
        for v in nb
            del_neighbour_edges!(G_right, v)
        end
        ARB_right = ARB_VC(G_right, k-1, union(VC, nb))

        if isempty(ARB_left)
            return ARB_right
        end
        if isempty(ARB_right)
            return ARB_left
        end
        if length(ARB_left) < length(ARB_right)
            return ARB_left
        else
            return ARB_right
        end
    end
end
