function simple_VC(g::Graph)::Set{T}
    G = copy(g)
    VC = Set{T}()
    x = vertex_deg_equals_x(G,1)
    while x != 0
        nb = first(voisins(G,x))
        push!(VC, nb)
        del_neighbour_edges!(G, nb)
        x = vertex_deg_equals_x(G, 1)
    end
    x = vertex_deg_geq_than_x(G, 2)
    while x != 0
        push!(VC, x)
        del_neighbour_edges!(G, x)
        x = vertex_deg_geq_than_x(G, 2)
    end
    x = vertex_deg_geq_than_x(G,1)
    while x != 0
        nb = first(voisins(G,x))
        push!(VC, nb)
        del_neighbour_edges!(G, nb)
        x = vertex_deg_geq_than_x(G, 1)
    end
    return VC
end

function ARB_VC(G::Graph, k::Integer, VC::Set{T}=Set{T}())::Set{T}
    
    if k <= 0
        is_VC(G, VC) && return VC
        return Set{T}()
    else
        u,deg_u = vertex_deg_max(G)
        if deg_u < 3
            SVC = simple_VC(G)
            length(SVC) <= k && return union(SVC, VC)
            return Set{T}()
        else
            G_left = copy(G)
            del_neighbour_edges!(G_left, u)
            ARB_left = ARB_VC(G_left, k-1, union(VC, Set(u)))

            !isempty(ARB_left) && return ARB_left

            nb = voisins(G, u)
            if k - length(nb) >= 0
                G_right = copy(G)
                for v in nb
                    del_neighbour_edges!(G_right, v)
                end
                return ARB_VC(G_right, k-length(nb), union(VC, Set(nb)))
            else 
                return Set{T}()
            end
        end
    end
end
