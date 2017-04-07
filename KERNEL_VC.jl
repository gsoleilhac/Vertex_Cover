
function KERNEL_VC(g::Graph, k::Integer, VC=Set{T}())
    k0 = k
    G = copy(g)
    VC = Set{T}()
    while true
        k == 0 && break
        u = vertex_deg_equals_x(G, 1)
        if u!= 0
            v = first(voisins(G, u))
            push!(VC, v)
            del_neighbour_edges!(G, v)
            k = k-1
        else
            v = vertex_deg_geq_than_x(G, k+1)
            v == 0 && break
            push!(VC, v)
            del_neighbour_edges!(G, v)
            k = k-1
        end
    end

    if k == 0
        is_VC(G, VC) && return VC
        return Set{T}()
    else
        if count_edges(G) > k0*k
            return Set{T}()
        else
            ARB = ARB_VC(G,k)
            VC = union(VC, ARB)
            is_VC(G, VC) && return VC
            return Set{T}()
        end
    end
end