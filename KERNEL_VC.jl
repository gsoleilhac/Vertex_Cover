
function KERNEL_VC(g, k, VC=Set{Int}())
    k0 = k
    G = Graph(copy(g.ind, g.m))
    VC = Set{Int}()
    while true
        # show_graph(G)
        k == 0 && break
        u = vertex_deg_equals_x(G, 1)
        if u!= 0
            v dee= voisins(G, u)[1]
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
        return Set{Int}()
    else
        if count_edges(G) > k0*k
            println("oops")
            return Set()
        else
            ARB = ARB_VC(G,k)
            VC = union(VC, ARB)
            is_VC(G, VC) && return VC
            return Set{Int}()
        end
    end
end